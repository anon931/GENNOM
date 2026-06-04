package com.gennom.infrastructure.adapter.output.persistence.mysql.entity;
import jakarta.persistence.*;
import lombok.Data;
@Entity @Table(name = "inventory") @Data
public class InventoryEntity {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY) private Long id;
    private Long facilityId;
    private String equipmentName;
    private Double ratedPowerKw;
    private Integer quantity;
    private Integer estimatedAnnualHours;
}
