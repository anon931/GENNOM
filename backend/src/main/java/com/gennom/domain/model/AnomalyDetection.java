package com.gennom.domain.model;
import lombok.Data;
import java.time.LocalDateTime;
@Data
public class AnomalyDetection {
    private Long id;
    private Long facilityId;
    private LocalDateTime detectedAt;
    private Double consumptionValue;
    private Double expectedValue;
    private Double deviationPercent;
    private Boolean resolved;
}
