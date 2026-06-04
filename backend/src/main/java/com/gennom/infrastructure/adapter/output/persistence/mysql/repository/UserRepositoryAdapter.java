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
