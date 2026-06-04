package com.gennom.domain.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Equipment {
    private Long id;
    private Long companyId;
    private String name;
    private Double powerKw; // potencia en kW
    private Double hoursPerDay; // horas de uso diario promedio
    private Double efficiency; // 0-1, factor de eficiencia
    private Boolean active;
}