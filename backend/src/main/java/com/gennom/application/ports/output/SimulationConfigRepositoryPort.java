package com.gennom.application.ports.output;
import com.gennom.domain.model.SimulationConfig;
import java.util.Optional;
public interface SimulationConfigRepositoryPort {
    Optional<SimulationConfig> findByFacilityId(Long facilityId);
    SimulationConfig save(SimulationConfig config);
}
