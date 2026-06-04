package com.gennom.infrastructure.adapter.output.persistence.mysql.repository;
import com.gennom.infrastructure.adapter.output.persistence.mysql.entity.SimulationConfigEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;
public interface JpaSimulationConfigRepository extends JpaRepository<SimulationConfigEntity, Long> {
    Optional<SimulationConfigEntity> findByFacilityId(Long facilityId);
}
