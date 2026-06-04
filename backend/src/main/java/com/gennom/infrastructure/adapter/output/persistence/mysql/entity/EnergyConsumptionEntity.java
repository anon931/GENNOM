package com.gennom.infrastructure.adapter.output.persistence.mysql.entity;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDateTime;

@Entity
@Table(name = "energy_consumption")
@Data
public class EnergyConsumptionEntity {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private Long facilityId;
    private LocalDateTime timestamp;
    private Double powerKw;
    private Double voltageV;
    private Double currentA;
    private Double powerFactor;
    private Double temperatureC;
    private Double costPerKwh;
    private Integer dayOfWeek;
    private Integer month;
    private Integer year;
    private Boolean isHoliday;
}