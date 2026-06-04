package com.gennom.domain.model;

import java.time.LocalDateTime;
import lombok.Data;

@Data
public class Prediction {
    private Long id;
    private Long facilityId;
    private LocalDateTime predictionDate;
    private Double predictedKw;
    private Double confidenceLower;
    private Double confidenceUpper;
    private Double actualKw;
    private Double errorPercentage;
}