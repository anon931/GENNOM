package com.gennom.infrastructure.adapter.output.persistence.mysql.repository;
import com.gennom.infrastructure.adapter.output.persistence.mysql.entity.AnomalyDetectionEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
public interface JpaAnomalyDetectionRepository extends JpaRepository<AnomalyDetectionEntity, Long> {
    List<AnomalyDetectionEntity> findByFacilityIdAndResolvedFalse(Long facilityId);
}
