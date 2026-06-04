package com.gennom.domain.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class IndustrialPlant {
    private Long id;
    private String name;
    private String location;
    private String voltageLevel;
    private Double maxPowerKw;
    private Boolean active;
}