package com.gennom.infrastructure.adapter.input.rest;

import com.gennom.application.ports.output.IndustrialPlantRepositoryPort;
import com.gennom.domain.model.IndustrialPlant;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/facilities")
@RequiredArgsConstructor
@CrossOrigin(origins = "http://localhost:3000")
public class FacilityController {

    private final IndustrialPlantRepositoryPort plantRepository;

    @GetMapping
    public List<IndustrialPlant> getAllPlants() {
        return plantRepository.findAll();
    }

    @GetMapping("/{id}")
    public IndustrialPlant getPlantById(@PathVariable Long id) {
        return plantRepository.findById(id).orElse(null);
    }
}