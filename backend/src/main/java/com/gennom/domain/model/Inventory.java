package com.gennom.domain.model;
import lombok.Data;
@Data
public class Inventory {
    private Long id;
    private Long facilityId;
    private String equipmentName;
    private Double ratedPowerKw;
    private Integer quantity;
    private Integer estimatedAnnualHours;
}
