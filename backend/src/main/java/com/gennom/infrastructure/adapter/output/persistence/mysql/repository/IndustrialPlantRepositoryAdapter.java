package com.gennom.infrastructure.adapter.output.persistence.mysql.repository;

import com.gennom.application.ports.output.IndustrialPlantRepositoryPort;
import com.gennom.domain.model.IndustrialPlant;
import com.gennom.infrastructure.adapter.output.persistence.mysql.entity.IndustrialPlantEntity;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Component
@RequiredArgsConstructor
public class IndustrialPlantRepositoryAdapter implements IndustrialPlantRepositoryPort {

    private final JpaIndustrialPlantRepository jpaRepository;

    @Override
    public List<IndustrialPlant> findAll() {
        return jpaRepository.findAll().stream()
                .map(this::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public Optional<IndustrialPlant> findById(Long id) {
        return jpaRepository.findById(id).map(this::toDomain);
    }

    @Override
    public IndustrialPlant save(IndustrialPlant plant) {
        IndustrialPlantEntity entity = toEntity(plant);
        return toDomain(jpaRepository.save(entity));
    }

    private IndustrialPlant toDomain(IndustrialPlantEntity entity) {
        return IndustrialPlant.builder()
                .id(entity.getId())
                .name(entity.getName())
                .location(entity.getLocation())
                .voltageLevel(entity.getVoltageLevel())
                .maxPowerKw(entity.getMaxPowerKw())
                .active(entity.getActive())
                .build();
    }

    private IndustrialPlantEntity toEntity(IndustrialPlant domain) {
        IndustrialPlantEntity entity = new IndustrialPlantEntity();
        entity.setId(domain.getId());
        entity.setName(domain.getName());
        entity.setLocation(domain.getLocation());
        entity.setVoltageLevel(domain.getVoltageLevel());
        entity.setMaxPowerKw(domain.getMaxPowerKw());
        entity.setActive(domain.getActive());
        return entity;
    }
}