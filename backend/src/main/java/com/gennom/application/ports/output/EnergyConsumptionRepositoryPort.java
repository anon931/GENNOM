package com.gennom.application.ports.output;

import com.gennom.domain.model.EnergyConsumption;
import java.time.LocalDateTime;
import java.util.List;

public interface EnergyConsumptionRepositoryPort {
    EnergyConsumption save(EnergyConsumption consumption);
    List<EnergyConsumption> findByFacilityIdAndTimestampBetween(Long facilityId, LocalDateTime from, LocalDateTime to);
    List<EnergyConsumption> findLastNDays(Long facilityId, int days);
}