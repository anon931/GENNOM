# ======================================================
# SCRIPT WINDOWS PowerShell - CREAR ARCHIVOS G-ENNOM
# Ejecutar desde: C:\GENNOM
# ======================================================

Write-Host "=== Creando estructura de archivos faltantes para G-ENNOM ===" -ForegroundColor Cyan

# -------------------------------
# BACKEND: entidades JPA
# -------------------------------
$entities = @{
    "backend/src/main/java/com/gennom/infrastructure/adapter/output/persistence/mysql/entity/InventoryEntity.java" = @'
package com.gennom.infrastructure.adapter.output.persistence.mysql.entity;
import jakarta.persistence.*;
import lombok.Data;
@Entity @Table(name = "inventory") @Data
public class InventoryEntity {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY) private Long id;
    private Long facilityId;
    private String equipmentName;
    private Double ratedPowerKw;
    private Integer quantity;
    private Integer estimatedAnnualHours;
}
'@
    "backend/src/main/java/com/gennom/infrastructure/adapter/output/persistence/mysql/entity/SimulationConfigEntity.java" = @'
package com.gennom.infrastructure.adapter.output.persistence.mysql.entity;
import jakarta.persistence.*;
import lombok.Data;
@Entity @Table(name = "simulation_config") @Data
public class SimulationConfigEntity {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY) private Long id;
    private Long facilityId;
    private Boolean active;
    private Double baseConsumption;
    private Double variability;
}
'@
    "backend/src/main/java/com/gennom/infrastructure/adapter/output/persistence/mysql/entity/AnomalyDetectionEntity.java" = @'
package com.gennom.infrastructure.adapter.output.persistence.mysql.entity;
import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDateTime;
@Entity @Table(name = "anomaly_detection") @Data
public class AnomalyDetectionEntity {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY) private Long id;
    private Long facilityId;
    private LocalDateTime detectedAt;
    private Double consumptionValue;
    private Double expectedValue;
    private Double deviationPercent;
    private Boolean resolved;
}
'@
    "backend/src/main/java/com/gennom/infrastructure/adapter/output/persistence/mysql/entity/UserEntity.java" = @'
package com.gennom.infrastructure.adapter.output.persistence.mysql.entity;
import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDateTime;
@Entity @Table(name = "users") @Data
public class UserEntity {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY) private Long id;
    private String username;
    private String password;
    private String email;
    private String companyName;
    private Long roleId;
    private Long facilityId;
    private LocalDateTime createdAt;
}
'@
    "backend/src/main/java/com/gennom/infrastructure/adapter/output/persistence/mysql/entity/RoleEntity.java" = @'
package com.gennom.infrastructure.adapter.output.persistence.mysql.entity;
import jakarta.persistence.*;
import lombok.Data;
@Entity @Table(name = "roles") @Data
public class RoleEntity {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY) private Long id;
    private String name;
}
'@
}

foreach ($file in $entities.Keys) {
    $dir = Split-Path $file -Parent
    if (!(Test-Path $dir)) { New-Item -ItemType Directory -Force -Path $dir | Out-Null }
    Set-Content -Path $file -Value $entities[$file] -Encoding UTF8
    Write-Host "  Creado: $file" -ForegroundColor Green
}

# -------------------------------
# BACKEND: repositorios JPA
# -------------------------------
$repos = @{
    "backend/src/main/java/com/gennom/infrastructure/adapter/output/persistence/mysql/repository/JpaInventoryRepository.java" = @'
package com.gennom.infrastructure.adapter.output.persistence.mysql.repository;
import com.gennom.infrastructure.adapter.output.persistence.mysql.entity.InventoryEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
public interface JpaInventoryRepository extends JpaRepository<InventoryEntity, Long> {
    List<InventoryEntity> findByFacilityId(Long facilityId);
}
'@
    "backend/src/main/java/com/gennom/infrastructure/adapter/output/persistence/mysql/repository/JpaSimulationConfigRepository.java" = @'
package com.gennom.infrastructure.adapter.output.persistence.mysql.repository;
import com.gennom.infrastructure.adapter.output.persistence.mysql.entity.SimulationConfigEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;
public interface JpaSimulationConfigRepository extends JpaRepository<SimulationConfigEntity, Long> {
    Optional<SimulationConfigEntity> findByFacilityId(Long facilityId);
}
'@
    "backend/src/main/java/com/gennom/infrastructure/adapter/output/persistence/mysql/repository/JpaAnomalyDetectionRepository.java" = @'
package com.gennom.infrastructure.adapter.output.persistence.mysql.repository;
import com.gennom.infrastructure.adapter.output.persistence.mysql.entity.AnomalyDetectionEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
public interface JpaAnomalyDetectionRepository extends JpaRepository<AnomalyDetectionEntity, Long> {
    List<AnomalyDetectionEntity> findByFacilityIdAndResolvedFalse(Long facilityId);
}
'@
    "backend/src/main/java/com/gennom/infrastructure/adapter/output/persistence/mysql/repository/JpaUserRepository.java" = @'
package com.gennom.infrastructure.adapter.output.persistence.mysql.repository;
import com.gennom.infrastructure.adapter.output.persistence.mysql.entity.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;
public interface JpaUserRepository extends JpaRepository<UserEntity, Long> {
    Optional<UserEntity> findByUsername(String username);
    Optional<UserEntity> findByEmail(String email);
}
'@
    "backend/src/main/java/com/gennom/infrastructure/adapter/output/persistence/mysql/repository/JpaRoleRepository.java" = @'
package com.gennom.infrastructure.adapter.output.persistence.mysql.repository;
import com.gennom.infrastructure.adapter.output.persistence.mysql.entity.RoleEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;
public interface JpaRoleRepository extends JpaRepository<RoleEntity, Long> {
    Optional<RoleEntity> findByName(String name);
}
'@
}

foreach ($file in $repos.Keys) {
    $dir = Split-Path $file -Parent
    if (!(Test-Path $dir)) { New-Item -ItemType Directory -Force -Path $dir | Out-Null }
    Set-Content -Path $file -Value $repos[$file] -Encoding UTF8
    Write-Host "  Creado: $file" -ForegroundColor Green
}

# -------------------------------
# BACKEND: modelos de dominio
# -------------------------------
$domains = @{
    "backend/src/main/java/com/gennom/domain/model/User.java" = @'
package com.gennom.domain.model;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.time.LocalDateTime;
@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class User {
    private Long id;
    private String username;
    private String password;
    private String email;
    private String companyName;
    private Long roleId;
    private Long facilityId;
    private LocalDateTime createdAt;
}
'@
    "backend/src/main/java/com/gennom/domain/model/Role.java" = @'
package com.gennom.domain.model;
import lombok.Data;
@Data
public class Role {
    private Long id;
    private String name;
}
'@
    "backend/src/main/java/com/gennom/domain/model/Inventory.java" = @'
package com.gennom.domain.model;
import lombok.Data;
@Data
public class Inventory {
    private Long id;
    private Long facilityId;
    private String equipmentName;
    private Double ratedPowerKw;
    private Integer quantity;
    private Integer estimatedAnnualHours;
}
'@
    "backend/src/main/java/com/gennom/domain/model/SimulationConfig.java" = @'
package com.gennom.domain.model;
import lombok.Data;
@Data
public class SimulationConfig {
    private Long id;
    private Long facilityId;
    private Boolean active;
    private Double baseConsumption;
    private Double variability;
}
'@
    "backend/src/main/java/com/gennom/domain/model/AnomalyDetection.java" = @'
package com.gennom.domain.model;
import lombok.Data;
import java.time.LocalDateTime;
@Data
public class AnomalyDetection {
    private Long id;
    private Long facilityId;
    private LocalDateTime detectedAt;
    private Double consumptionValue;
    private Double expectedValue;
    private Double deviationPercent;
    private Boolean resolved;
}
'@
}

foreach ($file in $domains.Keys) {
    $dir = Split-Path $file -Parent
    if (!(Test-Path $dir)) { New-Item -ItemType Directory -Force -Path $dir | Out-Null }
    Set-Content -Path $file -Value $domains[$file] -Encoding UTF8
    Write-Host "  Creado: $file" -ForegroundColor Green
}

# -------------------------------
# BACKEND: puertos de salida
# -------------------------------
$ports = @{
    "backend/src/main/java/com/gennom/application/ports/output/UserRepositoryPort.java" = @'
package com.gennom.application.ports.output;
import com.gennom.domain.model.User;
import java.util.Optional;
public interface UserRepositoryPort {
    Optional<User> findByUsername(String username);
    Optional<User> findByEmail(String email);
    User save(User user);
}
'@
    "backend/src/main/java/com/gennom/application/ports/output/RoleRepositoryPort.java" = @'
package com.gennom.application.ports.output;
import com.gennom.domain.model.Role;
import java.util.Optional;
public interface RoleRepositoryPort {
    Optional<Role> findByName(String name);
}
'@
    "backend/src/main/java/com/gennom/application/ports/output/InventoryRepositoryPort.java" = @'
package com.gennom.application.ports.output;
import com.gennom.domain.model.Inventory;
import java.util.List;
public interface InventoryRepositoryPort {
    List<Inventory> findByFacilityId(Long facilityId);
    Inventory save(Inventory inventory);
    void deleteById(Long id);
}
'@
    "backend/src/main/java/com/gennom/application/ports/output/SimulationConfigRepositoryPort.java" = @'
package com.gennom.application.ports.output;
import com.gennom.domain.model.SimulationConfig;
import java.util.Optional;
public interface SimulationConfigRepositoryPort {
    Optional<SimulationConfig> findByFacilityId(Long facilityId);
    SimulationConfig save(SimulationConfig config);
}
'@
    "backend/src/main/java/com/gennom/application/ports/output/AnomalyDetectionRepositoryPort.java" = @'
package com.gennom.application.ports.output;
import com.gennom.domain.model.AnomalyDetection;
import java.util.List;
public interface AnomalyDetectionRepositoryPort {
    List<AnomalyDetection> findByFacilityIdAndResolvedFalse(Long facilityId);
    AnomalyDetection save(AnomalyDetection anomaly);
}
'@
}

foreach ($file in $ports.Keys) {
    $dir = Split-Path $file -Parent
    if (!(Test-Path $dir)) { New-Item -ItemType Directory -Force -Path $dir | Out-Null }
    Set-Content -Path $file -Value $ports[$file] -Encoding UTF8
    Write-Host "  Creado: $file" -ForegroundColor Green
}

# -------------------------------
# BACKEND: adaptadores de repositorio (solo UserRepositoryAdapter como ejemplo; puedes agregar los demás)
# -------------------------------
$adapters = @{
    "backend/src/main/java/com/gennom/infrastructure/adapter/output/persistence/mysql/repository/UserRepositoryAdapter.java" = @'
package com.gennom.infrastructure.adapter.output.persistence.mysql.repository;
import com.gennom.application.ports.output.UserRepositoryPort;
import com.gennom.domain.model.User;
import com.gennom.infrastructure.adapter.output.persistence.mysql.entity.UserEntity;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import java.util.Optional;
@Component @RequiredArgsConstructor
public class UserRepositoryAdapter implements UserRepositoryPort {
    private final JpaUserRepository jpaRepository;
    @Override public Optional<User> findByUsername(String username) {
        return jpaRepository.findByUsername(username).map(this::toDomain);
    }
    @Override public Optional<User> findByEmail(String email) {
        return jpaRepository.findByEmail(email).map(this::toDomain);
    }
    @Override public User save(User user) {
        return toDomain(jpaRepository.save(toEntity(user)));
    }
    private User toDomain(UserEntity entity) {
        return User.builder()
                .id(entity.getId())
                .username(entity.getUsername())
                .password(entity.getPassword())
                .email(entity.getEmail())
                .companyName(entity.getCompanyName())
                .roleId(entity.getRoleId())
                .facilityId(entity.getFacilityId())
                .createdAt(entity.getCreatedAt())
                .build();
    }
    private UserEntity toEntity(User domain) {
        UserEntity entity = new UserEntity();
        entity.setId(domain.getId());
        entity.setUsername(domain.getUsername());
        entity.setPassword(domain.getPassword());
        entity.setEmail(domain.getEmail());
        entity.setCompanyName(domain.getCompanyName());
        entity.setRoleId(domain.getRoleId());
        entity.setFacilityId(domain.getFacilityId());
        entity.setCreatedAt(domain.getCreatedAt());
        return entity;
    }
}
'@
}

foreach ($file in $adapters.Keys) {
    $dir = Split-Path $file -Parent
    if (!(Test-Path $dir)) { New-Item -ItemType Directory -Force -Path $dir | Out-Null }
    Set-Content -Path $file -Value $adapters[$file] -Encoding UTF8
    Write-Host "  Creado: $file" -ForegroundColor Green
}

# -------------------------------
# BACKEND: DTOs y utilidades JWT
# -------------------------------
$dtos = @{
    "backend/src/main/java/com/gennom/application/dto/LoginRequest.java" = @'
package com.gennom.application.dto;
import lombok.Data;
@Data
public class LoginRequest {
    private String username;
    private String password;
}
'@
    "backend/src/main/java/com/gennom/application/dto/RegisterRequest.java" = @'
package com.gennom.application.dto;
import lombok.Data;
@Data
public class RegisterRequest {
    private String username;
    private String password;
    private String email;
    private String companyName;
}
'@
    "backend/src/main/java/com/gennom/application/dto/AuthResponse.java" = @'
package com.gennom.application.dto;
import lombok.AllArgsConstructor;
import lombok.Data;
@Data @AllArgsConstructor
public class AuthResponse {
    private String token;
    private String role;
    private Long userId;
    private Long facilityId;
}
'@
}

foreach ($file in $dtos.Keys) {
    $dir = Split-Path $file -Parent
    if (!(Test-Path $dir)) { New-Item -ItemType Directory -Force -Path $dir | Out-Null }
    Set-Content -Path $file -Value $dtos[$file] -Encoding UTF8
    Write-Host "  Creado: $file" -ForegroundColor Green
}

# --------------------------------------
# BACKEND: JwtUtils, JwtAuthenticationFilter, CustomUserDetailsService, SecurityConfig, AuthUseCase, AuthService, AuthController
# --------------------------------------
$securityFiles = @{
    "backend/src/main/java/com/gennom/infrastructure/config/JwtUtils.java" = @'
package com.gennom.infrastructure.config;
import io.jsonwebtoken.*;
import io.jsonwebtoken.security.Keys;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import java.security.Key;
import java.util.Date;
@Component
public class JwtUtils {
    @Value("${jwt.secret}") private String jwtSecret;
    @Value("${jwt.expiration}") private int jwtExpirationMs;
    private Key key() { return Keys.hmacShaKeyFor(jwtSecret.getBytes()); }
    public String generateToken(String username, Long userId, String role) {
        return Jwts.builder()
                .setSubject(username)
                .claim("userId", userId)
                .claim("role", role)
                .setIssuedAt(new Date())
                .setExpiration(new Date((new Date()).getTime() + jwtExpirationMs))
                .signWith(key(), SignatureAlgorithm.HS512)
                .compact();
    }
    public String getUsernameFromToken(String token) {
        return Jwts.parserBuilder().setSigningKey(key()).build().parseClaimsJws(token).getBody().getSubject();
    }
    public boolean validateToken(String token) {
        try { Jwts.parserBuilder().setSigningKey(key()).build().parseClaimsJws(token); return true; }
        catch (JwtException | IllegalArgumentException e) { return false; }
    }
}
'@
    "backend/src/main/java/com/gennom/infrastructure/config/JwtAuthenticationFilter.java" = @'
package com.gennom.infrastructure.config;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;
import java.io.IOException;
@Component @RequiredArgsConstructor
public class JwtAuthenticationFilter extends OncePerRequestFilter {
    private final JwtUtils jwtUtils;
    private final UserDetailsService userDetailsService;
    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain chain) throws ServletException, IOException {
        String authHeader = request.getHeader("Authorization");
        if (authHeader == null || !authHeader.startsWith("Bearer ")) { chain.doFilter(request, response); return; }
        String token = authHeader.substring(7);
        String username = jwtUtils.getUsernameFromToken(token);
        if (username != null && SecurityContextHolder.getContext().getAuthentication() == null) {
            UserDetails userDetails = userDetailsService.loadUserByUsername(username);
            if (jwtUtils.validateToken(token)) {
                UsernamePasswordAuthenticationToken authToken = new UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities());
                authToken.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
                SecurityContextHolder.getContext().setAuthentication(authToken);
            }
        }
        chain.doFilter(request, response);
    }
}
'@
    "backend/src/main/java/com/gennom/infrastructure/config/CustomUserDetailsService.java" = @'
package com.gennom.infrastructure.config;
import com.gennom.application.ports.output.UserRepositoryPort;
import com.gennom.domain.model.User;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import java.util.Collections;
@Service @RequiredArgsConstructor
public class CustomUserDetailsService implements UserDetailsService {
    private final UserRepositoryPort userRepository;
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = userRepository.findByUsername(username).orElseThrow(() -> new UsernameNotFoundException("Usuario no encontrado"));
        String roleName = user.getRoleId() == 1 ? "ADMIN" : "USER";
        return new org.springframework.security.core.userdetails.User(user.getUsername(), user.getPassword(), Collections.singletonList(new SimpleGrantedAuthority("ROLE_" + roleName)));
    }
}
'@
    "backend/src/main/java/com/gennom/infrastructure/config/SecurityConfig.java" = @'
package com.gennom.infrastructure.config;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;
import java.util.Arrays;
@Configuration @EnableWebSecurity @RequiredArgsConstructor
public class SecurityConfig {
    private final JwtAuthenticationFilter jwtAuthenticationFilter;
    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http.csrf(csrf -> csrf.disable())
            .cors(cors -> cors.configurationSource(corsConfigurationSource()))
            .sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
            .authorizeHttpRequests(auth -> auth
                .requestMatchers("/api/auth/**", "/api/facilities/**", "/api/predictions/**", "/api/consumptions/**").permitAll()
                .anyRequest().authenticated()
            )
            .addFilterBefore(jwtAuthenticationFilter, UsernamePasswordAuthenticationFilter.class);
        return http.build();
    }
    @Bean public CorsConfigurationSource corsConfigurationSource() {
        CorsConfiguration configuration = new CorsConfiguration();
        configuration.setAllowedOrigins(Arrays.asList("http://localhost:3000"));
        configuration.setAllowedMethods(Arrays.asList("GET","POST","PUT","DELETE","OPTIONS"));
        configuration.setAllowedHeaders(Arrays.asList("*"));
        configuration.setAllowCredentials(true);
        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", configuration);
        return source;
    }
    @Bean public PasswordEncoder passwordEncoder() { return new BCryptPasswordEncoder(); }
    @Bean public AuthenticationManager authenticationManager(AuthenticationConfiguration config) throws Exception { return config.getAuthenticationManager(); }
}
'@
    "backend/src/main/java/com/gennom/application/ports/input/AuthUseCase.java" = @'
package com.gennom.application.ports.input;
import com.gennom.application.dto.LoginRequest;
import com.gennom.application.dto.RegisterRequest;
import com.gennom.application.dto.AuthResponse;
public interface AuthUseCase {
    AuthResponse login(LoginRequest request);
    AuthResponse register(RegisterRequest request);
}
'@
    "backend/src/main/java/com/gennom/application/usecase/AuthService.java" = @'
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
        User user = userRepository.findByUsername(request.getUsername()).orElseThrow(() -> new RuntimeException("Credenciales inválidas"));
        if (!passwordEncoder.matches(request.getPassword(), user.getPassword())) throw new RuntimeException("Credenciales inválidas");
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
'@
    "backend/src/main/java/com/gennom/infrastructure/adapter/input/rest/AuthController.java" = @'
package com.gennom.infrastructure.adapter.input.rest;
import com.gennom.application.dto.LoginRequest;
import com.gennom.application.dto.RegisterRequest;
import com.gennom.application.dto.AuthResponse;
import com.gennom.application.ports.input.AuthUseCase;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
@RestController @RequestMapping("/api/auth") @RequiredArgsConstructor @CrossOrigin(origins = "http://localhost:3000")
public class AuthController {
    private final AuthUseCase authUseCase;
    @PostMapping("/login") public AuthResponse login(@RequestBody LoginRequest request) { return authUseCase.login(request); }
    @PostMapping("/register") public AuthResponse register(@RequestBody RegisterRequest request) { return authUseCase.register(request); }
}
'@
}

foreach ($file in $securityFiles.Keys) {
    $dir = Split-Path $file -Parent
    if (!(Test-Path $dir)) { New-Item -ItemType Directory -Force -Path $dir | Out-Null }
    Set-Content -Path $file -Value $securityFiles[$file] -Encoding UTF8
    Write-Host "  Creado: $file" -ForegroundColor Green
}

# -------------------------------
# FRONTEND: páginas y actualizaciones
# -------------------------------
$frontendFiles = @{
    "frontend/src/pages/Auth/LoginPage.tsx" = @'
import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { login } from '../../services/api';

export default function LoginPage() {
    const [username, setUsername] = useState('');
    const [password, setPassword] = useState('');
    const navigate = useNavigate();

    const handleSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        try {
            const res = await login(username, password);
            localStorage.setItem('token', res.data.token);
            localStorage.setItem('role', res.data.role);
            navigate('/dashboard');
        } catch (err) {
            alert('Credenciales inválidas');
        }
    };

    return (
        <div className="min-h-screen bg-gradient-to-br from-slate-900 to-slate-800 flex items-center justify-center">
            <form onSubmit={handleSubmit} className="bg-slate-800 p-8 rounded-2xl shadow-xl w-96">
                <h1 className="text-3xl font-bold text-white mb-6">G-ENNOM</h1>
                <input type="text" placeholder="Usuario" className="w-full p-3 rounded bg-slate-700 text-white mb-4" value={username} onChange={e => setUsername(e.target.value)} />
                <input type="password" placeholder="Contraseña" className="w-full p-3 rounded bg-slate-700 text-white mb-6" value={password} onChange={e => setPassword(e.target.value)} />
                <button type="submit" className="w-full bg-blue-600 py-3 rounded-xl text-white font-bold">Ingresar</button>
                <p className="text-center text-slate-400 mt-4">Demo: admin / admin123</p>
            </form>
        </div>
    );
}
'@
    "frontend/src/pages/Auth/RegisterPage.tsx" = @'
import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { register } from '../../services/api';

export default function RegisterPage() {
    const [form, setForm] = useState({ username: '', password: '', email: '', companyName: '' });
    const navigate = useNavigate();

    const handleSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        try {
            const res = await register(form);
            localStorage.setItem('token', res.data.token);
            localStorage.setItem('role', res.data.role);
            navigate('/dashboard');
        } catch (err) {
            alert('Error al registrar');
        }
    };

    return (
        <div className="min-h-screen bg-gradient-to-br from-slate-900 to-slate-800 flex items-center justify-center">
            <form onSubmit={handleSubmit} className="bg-slate-800 p-8 rounded-2xl shadow-xl w-96">
                <h1 className="text-3xl font-bold text-white mb-6">Registro Empresa</h1>
                <input type="text" placeholder="Usuario" className="w-full p-3 rounded bg-slate-700 text-white mb-4" onChange={e => setForm({...form, username: e.target.value})} />
                <input type="password" placeholder="Contraseña" className="w-full p-3 rounded bg-slate-700 text-white mb-4" onChange={e => setForm({...form, password: e.target.value})} />
                <input type="email" placeholder="Email" className="w-full p-3 rounded bg-slate-700 text-white mb-4" onChange={e => setForm({...form, email: e.target.value})} />
                <input type="text" placeholder="Nombre de empresa" className="w-full p-3 rounded bg-slate-700 text-white mb-6" onChange={e => setForm({...form, companyName: e.target.value})} />
                <button type="submit" className="w-full bg-green-600 py-3 rounded-xl text-white font-bold">Registrar</button>
            </form>
        </div>
    );
}
'@
    "frontend/src/pages/Admin/AdminPanel.tsx" = @'
import { useEffect, useState } from 'react';
import { getSimulationConfig, updateSimulationConfig, runSimulation, getPlants, getAnomalies } from '../../services/api';

export default function AdminPanel() {
    const [config, setConfig] = useState({ active: false, baseConsumption: 100, variability: 15 });
    const [plants, setPlants] = useState([]);
    const [anomalies, setAnomalies] = useState([]);
    const [loading, setLoading] = useState(false);

    useEffect(() => { loadData(); }, []);
    const loadData = async () => {
        const cfg = await getSimulationConfig(); setConfig(cfg.data);
        const pl = await getPlants(); setPlants(pl.data);
        const anom = await getAnomalies(); setAnomalies(anom.data);
    };
    const handleSaveConfig = async () => { await updateSimulationConfig(config); alert('Guardado'); };
    const handleRunSimulation = async () => { setLoading(true); await runSimulation(); alert('Simulación ejecutada'); setLoading(false); };

    return (
        <div className="min-h-screen bg-slate-900 p-6">
            <h1 className="text-3xl font-bold text-white mb-6">Panel de Administración</h1>
            <div className="bg-slate-800 rounded-2xl p-6 mb-6">
                <h2 className="text-xl text-white mb-4">Configuración simulación</h2>
                <label className="flex items-center gap-2 text-white mb-4"><input type="checkbox" checked={config.active} onChange={e => setConfig({...config, active: e.target.checked})} /> Activar</label>
                <div className="grid grid-cols-2 gap-4 mb-4">
                    <div><label className="text-slate-400">Consumo base (kW)</label><input type="number" className="w-full p-2 rounded bg-slate-700 text-white" value={config.baseConsumption} onChange={e => setConfig({...config, baseConsumption: +e.target.value})} /></div>
                    <div><label className="text-slate-400">Variabilidad (%)</label><input type="number" className="w-full p-2 rounded bg-slate-700 text-white" value={config.variability} onChange={e => setConfig({...config, variability: +e.target.value})} /></div>
                </div>
                <button onClick={handleSaveConfig} className="bg-blue-600 px-4 py-2 rounded text-white mr-2">Guardar</button>
                <button onClick={handleRunSimulation} className="bg-green-600 px-4 py-2 rounded text-white">Ejecutar simulación</button>
                {loading && <p className="text-yellow-400 mt-2">Generando...</p>}
            </div>
            <div className="bg-slate-800 rounded-2xl p-6">
                <h2 className="text-xl text-white mb-4">Anomalías detectadas</h2>
                {anomalies.length === 0 ? <p className="text-slate-400">No hay anomalías</p> : (
                    <table className="w-full text-white"><thead><tr><th>Fecha</th><th>Consumo real</th><th>Esperado</th><th>Desviación</th></tr></thead>
                    <tbody>{anomalies.map(a => <tr key={a.id}><td>{new Date(a.detectedAt).toLocaleString()}</td><td>{a.consumptionValue} kW</td><td>{a.expectedValue} kW</td><td>{a.deviationPercent}%</td></tr>)}</tbody></table>
                )}
            </div>
        </div>
    );
}
'@
    "frontend/src/services/api.ts" = @'
import axios from 'axios';
const API = axios.create({ baseURL: 'http://localhost:8080/api' });
API.interceptors.request.use((config) => {
    const token = localStorage.getItem('token');
    if (token) config.headers.Authorization = `Bearer ${token}`;
    return config;
});
export const login = (username: string, password: string) => API.post('/auth/login', { username, password });
export const register = (userData: any) => API.post('/auth/register', userData);
export const getPlants = () => API.get('/facilities');
export const getConsumptions = (facilityId: number, from: string, to: string) => API.get(`/consumptions/${facilityId}`, { params: { from, to } });
export const predict = (facilityId: number, datetime: string) => API.post('/predictions', null, { params: { facilityId, datetime } });
export const getMyPlant = () => API.get('/facilities/my');
export const getSimulationConfig = () => API.get('/admin/simulation/config');
export const updateSimulationConfig = (config: any) => API.post('/admin/simulation/config', config);
export const runSimulation = () => API.post('/admin/simulation/run');
export const getAnomalies = () => API.get('/anomalies');
export default API;
'@
    "frontend/src/App.tsx" = @'
import { BrowserRouter, Routes, Route, Navigate } from 'react-router-dom';
import LoginPage from './pages/Auth/LoginPage';
import RegisterPage from './pages/Auth/RegisterPage';
import DashboardPage from './pages/Dashboard/DashboardPage';
import AdminPanel from './pages/Admin/AdminPanel';

const PrivateRoute = ({ children, adminOnly = false }) => {
    const token = localStorage.getItem('token');
    const role = localStorage.getItem('role');
    if (!token) return <Navigate to="/login" />;
    if (adminOnly && role !== 'ADMIN') return <Navigate to="/dashboard" />;
    return children;
};

function App() {
    return (
        <BrowserRouter>
            <Routes>
                <Route path="/login" element={<LoginPage />} />
                <Route path="/register" element={<RegisterPage />} />
                <Route path="/dashboard" element={<PrivateRoute><DashboardPage /></PrivateRoute>} />
                <Route path="/admin" element={<PrivateRoute adminOnly><AdminPanel /></PrivateRoute>} />
                <Route path="*" element={<Navigate to="/dashboard" />} />
            </Routes>
        </BrowserRouter>
    );
}

export default App;
'@
}

foreach ($file in $frontendFiles.Keys) {
    $dir = Split-Path $file -Parent
    if (!(Test-Path $dir)) { New-Item -ItemType Directory -Force -Path $dir | Out-Null }
    Set-Content -Path $file -Value $frontendFiles[$file] -Encoding UTF8
    Write-Host "  Creado: $file" -ForegroundColor Green
}

Write-Host "`n================================================" -ForegroundColor Cyan
Write-Host "ESTRUCTURA COMPLETADA EXITOSAMENTE" -ForegroundColor Green
Write-Host "================================================" -ForegroundColor Cyan
Write-Host "Ahora ejecuta los siguientes comandos:" -ForegroundColor Yellow
Write-Host ""
Write-Host "  # 1. INSTALAR DEPENDENCIA DE ROUTER (si no está)" -ForegroundColor White
Write-Host "  cd frontend" -ForegroundColor White
Write-Host "  npm install react-router-dom" -ForegroundColor White
Write-Host ""
Write-Host "  # 2. RECONSTRUIR BACKEND" -ForegroundColor White
Write-Host "  cd ../backend" -ForegroundColor White
Write-Host "  .\mvnw clean package -DskipTests" -ForegroundColor White
Write-Host "  java -jar target/gennom-backend-0.0.1-SNAPSHOT.jar" -ForegroundColor White
Write-Host ""
Write-Host "  # 3. EJECUTAR FRONTEND (en otra terminal)" -ForegroundColor White
Write-Host "  cd frontend" -ForegroundColor White
Write-Host "  npm run dev" -ForegroundColor White
Write-Host ""
Write-Host "  # 4. ABRIR NAVEGADOR en http://localhost:3000" -ForegroundColor White
Write-Host "     Credenciales: admin / admin123 (debes insertar el usuario admin en la BD con rol 1)" -ForegroundColor Yellow
Write-Host ""
Write-Host "¡BUENA SUERTE, ÁNGEL!" -ForegroundColor Magenta