package com.gennom.application.ports.output;
import com.gennom.domain.model.AnomalyDetection;
import java.util.List;
public interface AnomalyDetectionRepositoryPort {
    List<AnomalyDetection> findByFacilityIdAndResolvedFalse(Long facilityId);
    AnomalyDetection save(AnomalyDetection anomaly);
}
