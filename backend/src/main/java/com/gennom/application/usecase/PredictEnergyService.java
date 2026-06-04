package com.gennom.application.usecase;

import com.gennom.application.ports.input.PredictEnergyUseCase;
import com.gennom.application.ports.output.EnergyConsumptionRepositoryPort;
import com.gennom.application.ports.output.PredictionModelPort;
import com.gennom.domain.model.EnergyConsumption;
import com.gennom.domain.model.Prediction;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class PredictEnergyService implements PredictEnergyUseCase {

    private final EnergyConsumptionRepositoryPort consumptionRepo;
    private final PredictionModelPort modelPort;

    @Override
    public Prediction predictConsumption(Long facilityId, LocalDateTime targetDateTime) {
        // Obtener Ãºltimos 7 dÃ­as de consumo para construir features
        List<EnergyConsumption> lastWeek = consumptionRepo.findLastNDays(facilityId, 7);
        if (lastWeek.isEmpty()) throw new RuntimeException("No hay datos histÃ³ricos");

        double lastConsumption = lastWeek.get(lastWeek.size() - 1).getPowerKw();
        double dayOfWeek = targetDateTime.getDayOfWeek().getValue();
        double month = targetDateTime.getMonthValue();
        double hour = targetDateTime.getHour();
        double temperature = getEstimatedTemperature(targetDateTime); // mock

        double[] features = {lastConsumption, dayOfWeek, month, hour, temperature};
        double predictedKw = modelPort.predict(features);

        Prediction prediction = new Prediction();
        prediction.setFacilityId(facilityId);
        prediction.setPredictionDate(targetDateTime);
        prediction.setPredictedKw(predictedKw);
        prediction.setConfidenceLower(predictedKw * 0.9);
        prediction.setConfidenceUpper(predictedKw * 1.1);
        return prediction;
    }

    private double getEstimatedTemperature(LocalDateTime date) {
        // SimulaciÃ³n: se puede conectar a API real luego
        return 22.0 + 5 * Math.sin(2 * Math.PI * date.getDayOfYear() / 365.0);
    }
}