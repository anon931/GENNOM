package com.gennom.infrastructure.adapter.output.persistence.mysql.repository;
import com.gennom.infrastructure.adapter.output.persistence.mysql.entity.InventoryEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
public interface JpaInventoryRepository extends JpaRepository<InventoryEntity, Long> {
    List<InventoryEntity> findByFacilityId(Long facilityId);
}
