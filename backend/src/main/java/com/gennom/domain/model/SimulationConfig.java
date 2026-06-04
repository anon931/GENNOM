package com.gennom.domain.model;
import lombok.Data;
@Data
public class SimulationConfig {
    private Long id;
    private Long facilityId;
    private Boolean active;
    private Double baseConsumption;
    private Double variability;
}
