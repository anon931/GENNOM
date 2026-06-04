package com.gennom.infrastructure.adapter.output.persistence.mysql.entity;
import jakarta.persistence.*;
import lombok.Data;
@Entity @Table(name = "simulation_config") @Data
public class SimulationConfigEntity {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY) private Long id;
    private Long facilityId;
    private Boolean active;
    private Double baseConsumption;
    private Double variability;
}
