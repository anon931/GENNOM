package com.gennom.application.ports.input;

import com.gennom.domain.model.Prediction;
import java.time.LocalDateTime;

public interface PredictEnergyUseCase {
    Prediction predictConsumption(Long facilityId, LocalDateTime targetDateTime);
}