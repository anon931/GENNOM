package com.gennom.domain.model;

import java.time.LocalDateTime;
import lombok.Data;

@Data
public class EnergyConsumption {
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