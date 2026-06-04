package com.gennom.infrastructure.adapter.output.persistence.mysql.repository;

import com.gennom.infrastructure.adapter.output.persistence.mysql.entity.EnergyConsumptionEntity;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import java.time.LocalDateTime;
import java.util.List;

public interface JpaEnergyConsumptionRepository extends JpaRepository<EnergyConsumptionEntity, Long> {
    List<EnergyConsumptionEntity> findByFacilityIdAndTimestampBetween(Long facilityId, LocalDateTime from, LocalDateTime to);
    List<EnergyConsumptionEntity> findTop7ByFacilityIdOrderByTimestampDesc(Long facilityId);
    List<EnergyConsumptionEntity> findByFacilityIdOrderByTimestampDesc(Long facilityId, Pageable pageable);
}