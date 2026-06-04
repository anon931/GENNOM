package com.gennom.infrastructure.adapter.output.persistence.mysql.repository;

import com.gennom.infrastructure.adapter.output.persistence.mysql.entity.IndustrialPlantEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface JpaIndustrialPlantRepository extends JpaRepository<IndustrialPlantEntity, Long> {
}