package com.gennom.application.usecase;
import com.gennom.application.dto.LoginRequest;
import com.gennom.application.dto.RegisterRequest;
import com.gennom.application.dto.AuthResponse;
import com.gennom.application.ports.input.AuthUseCase;
import com.gennom.application.ports.output.*;
import com.gennom.domain.model.User;
import com.gennom.domain.model.Role;
import com.gennom.domain.model.IndustrialPlant;
import com.gennom.infrastructure.config.JwtUtils;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import java.time.LocalDateTime;
@Service @RequiredArgsConstructor
public class AuthService implements AuthUseCase {
    private final UserRepositoryPort userRepository;
    private final RoleRepositoryPort roleRepository;
    private final IndustrialPlantRepositoryPort plantRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtUtils jwtUtils;
    @Override
    public AuthResponse login(LoginRequest request) {
        User user = userRepository.findByUsername(request.getUsername()).orElseThrow(() -> new RuntimeException("Credenciales invÃ¡lidas"));
        if (!passwordEncoder.matches(request.getPassword(), user.getPassword())) throw new RuntimeException("Credenciales invÃ¡lidas");
        String role = user.getRoleId() == 1 ? "ADMIN" : "USER";
        String token = jwtUtils.generateToken(user.getUsername(), user.getId(), role);
        return new AuthResponse(token, role, user.getId(), user.getFacilityId());
    }
    @Override
    public AuthResponse register(RegisterRequest request) {
        if (userRepository.findByUsername(request.getUsername()).isPresent()) throw new RuntimeException("El usuario ya existe");
        Role role = roleRepository.findByName("USER").orElseThrow(() -> new RuntimeException("Rol no encontrado"));
        IndustrialPlant plant = IndustrialPlant.builder()
                .name(request.getCompanyName())
                .location("No especificada")
                .voltageLevel("MEDIUM")
                .maxPowerKw(1000.0)
                .active(true)
                .build();
        plant = plantRepository.save(plant);
        User user = User.builder()
                .username(request.getUsername())
                .password(passwordEncoder.encode(request.getPassword()))
                .email(request.getEmail())
                .companyName(request.getCompanyName())
                .roleId(role.getId())
                .facilityId(plant.getId())
                .createdAt(LocalDateTime.now())
                .build();
        user = userRepository.save(user);
        String token = jwtUtils.generateToken(user.getUsername(), user.getId(), "USER");
        return new AuthResponse(token, "USER", user.getId(), user.getFacilityId());
    }
}
