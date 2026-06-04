package com.gennom.infrastructure.adapter.output.persistence.mysql.entity;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDateTime;

@Entity
@Table(name = "industrial_facility")
@Data
public class IndustrialPlantEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;
    private String location;
    private String voltageLevel;
    private Double maxPowerKw;
    private Boolean active;
    private LocalDateTime createdAt;
}