package com.gennom.domain.model;

import com.gennom.domain.valueobject.VoltageLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class IndustrialFacility {
    private Long id;
    private String name;
    private String location;
    private VoltageLevel voltageLevel;
    private Double maxPowerKw;
    private Boolean active;
    // getters/ setters implÃ­citos por lombok
}