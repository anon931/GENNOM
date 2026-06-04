package com.gennom.application.ports.output;
import com.gennom.domain.model.Inventory;
import java.util.List;
public interface InventoryRepositoryPort {
    List<Inventory> findByFacilityId(Long facilityId);
    Inventory save(Inventory inventory);
    void deleteById(Long id);
}
