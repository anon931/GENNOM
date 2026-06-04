package com.gennom.infrastructure.adapter.output.persistence.mysql.entity;
import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDateTime;
@Entity @Table(name = "anomaly_detection") @Data
public class AnomalyDetectionEntity {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY) private Long id;
    private Long facilityId;
    private LocalDateTime detectedAt;
    private Double consumptionValue;
    private Double expectedValue;
    private Double deviationPercent;
    private Boolean resolved;
}
