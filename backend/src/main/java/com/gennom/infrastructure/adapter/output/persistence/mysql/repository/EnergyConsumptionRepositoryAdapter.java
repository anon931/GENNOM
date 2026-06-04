package com.gennom.infrastructure.adapter.output.persistence.mysql.repository;

import com.gennom.application.ports.output.EnergyConsumptionRepositoryPort;
import com.gennom.domain.model.EnergyConsumption;
import com.gennom.infrastructure.adapter.output.persistence.mysql.entity.EnergyConsumptionEntity;
import java.time.LocalDateTime;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import org.springframework.data.domain.PageRequest;
import java.util.List;
import java.util.stream.Collectors;

@Component
@RequiredArgsConstructor
public class EnergyConsumptionRepositoryAdapter implements EnergyConsumptionRepositoryPort {

    private final JpaEnergyConsumptionRepository jpaRepository;

    @Override
    public EnergyConsumption save(EnergyConsumption consumption) {
        EnergyConsumptionEntity entity = toEntity(consumption);
        return toDomain(jpaRepository.save(entity));
    }

    @Override
    public List<EnergyConsumption> findByFacilityIdAndTimestampBetween(Long facilityId, LocalDateTime from, LocalDateTime to) {
        return jpaRepository.findByFacilityIdAndTimestampBetween(facilityId, from, to)
                .stream().map(this::toDomain).collect(Collectors.toList());
    }

    @Override
    public List<EnergyConsumption> findLastNDays(Long facilityId, int days) {
        int limit = Math.max(1, days);
        return jpaRepository.findByFacilityIdOrderByTimestampDesc(facilityId, PageRequest.of(0, limit))
                .stream().map(this::toDomain).collect(Collectors.toList());
    }

    private EnergyConsumptionEntity toEntity(EnergyConsumption d) {
        EnergyConsumptionEntity e = new EnergyConsumptionEntity();
        e.setId(d.getId());
        e.setFacilityId(d.getFacilityId());
        e.setTimestamp(d.getTimestamp());
        e.setPowerKw(d.getPowerKw());
        e.setVoltageV(d.getVoltageV());
        e.setCurrentA(d.getCurrentA());
        e.setPowerFactor(d.getPowerFactor());
        e.setTemperatureC(d.getTemperatureC());
        e.setCostPerKwh(d.getCostPerKwh());
        e.setDayOfWeek(d.getDayOfWeek());
        e.setMonth(d.getMonth());
        e.setYear(d.getYear());
        e.setIsHoliday(d.getIsHoliday());
        return e;
    }

    private EnergyConsumption toDomain(EnergyConsumptionEntity e) {
        EnergyConsumption d = new EnergyConsumption();
        d.setId(e.getId());
        d.setFacilityId(e.getFacilityId());
        d.setTimestamp(e.getTimestamp());
        d.setPowerKw(e.getPowerKw());
        d.setVoltageV(e.getVoltageV());
        d.setCurrentA(e.getCurrentA());
        d.setPowerFactor(e.getPowerFactor());
        d.setTemperatureC(e.getTemperatureC());
        d.setCostPerKwh(e.getCostPerKwh());
        d.setDayOfWeek(e.getDayOfWeek());
        d.setMonth(e.getMonth());
        d.setYear(e.getYear());
        d.setIsHoliday(e.getIsHoliday());
        return d;
    }
}