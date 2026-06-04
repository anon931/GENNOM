package com.gennom.infrastructure.adapter.input.rest;

import com.gennom.application.ports.output.EnergyConsumptionRepositoryPort;
import com.gennom.domain.model.EnergyConsumption;
import lombok.RequiredArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping("/api/consumptions")
@RequiredArgsConstructor
@CrossOrigin(origins = "http://localhost:3000")
public class ConsumptionController {

    private final EnergyConsumptionRepositoryPort consumptionRepository;

    @GetMapping("/{facilityId}")
    public List<EnergyConsumption> getConsumptions(
            @PathVariable Long facilityId,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime from,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime to) {
        return consumptionRepository.findByFacilityIdAndTimestampBetween(facilityId, from, to);
    }
}