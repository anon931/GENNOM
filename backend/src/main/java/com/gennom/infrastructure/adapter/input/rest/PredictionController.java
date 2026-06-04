package com.gennom.infrastructure.adapter.input.rest;

import com.gennom.application.ports.input.PredictEnergyUseCase;
import com.gennom.domain.model.Prediction;
import lombok.RequiredArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;

@RestController
@RequestMapping("/api/predictions")
@RequiredArgsConstructor
@CrossOrigin(origins = "http://localhost:3000")
public class PredictionController {

    private final PredictEnergyUseCase predictUseCase;

    @PostMapping
    public Prediction predict(
            @RequestParam Long facilityId,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime datetime) {
        return predictUseCase.predictConsumption(facilityId, datetime);
    }
}