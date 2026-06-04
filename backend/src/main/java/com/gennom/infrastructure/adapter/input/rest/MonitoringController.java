package com.gennom.infrastructure.adapter.input.rest;

import com.gennom.application.ports.output.EnergyConsumptionRepositoryPort;
import com.gennom.domain.model.EnergyConsumption;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import java.time.LocalDateTime;

@RestController
@RequestMapping("/api/monitoring")
@RequiredArgsConstructor
public class MonitoringController {

    private final EnergyConsumptionRepositoryPort consumptionRepo;

    @PostMapping("/record")
    public EnergyConsumption recordConsumption(@RequestBody EnergyConsumption consumption) {
        consumption.setTimestamp(LocalDateTime.now());
        consumption.setDayOfWeek(consumption.getTimestamp().getDayOfWeek().getValue());
        consumption.setMonth(consumption.getTimestamp().getMonthValue());
        consumption.setYear(consumption.getTimestamp().getYear());
        return consumptionRepo.save(consumption);
    }
}