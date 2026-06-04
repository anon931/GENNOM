package com.gennom.application.ports.output;

import com.gennom.domain.model.IndustrialPlant;
import java.util.List;
import java.util.Optional;

public interface IndustrialPlantRepositoryPort {
    List<IndustrialPlant> findAll();
    Optional<IndustrialPlant> findById(Long id);
    IndustrialPlant save(IndustrialPlant plant);
}