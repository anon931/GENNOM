package com.gennom.infrastructure.adapter.output.persistence.mysql.repository;

import com.gennom.application.ports.output.RoleRepositoryPort;
import com.gennom.domain.model.Role;
import com.gennom.infrastructure.adapter.output.persistence.mysql.entity.RoleEntity;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import java.util.Optional;

@Component
@RequiredArgsConstructor
public class RoleRepositoryAdapter implements RoleRepositoryPort {

    private final JpaRoleRepository jpaRepository;

    @Override
    public Optional<Role> findByName(String name) {
        return jpaRepository.findByName(name).map(this::toDomain);
    }

    private Role toDomain(RoleEntity entity) {
        Role role = new Role();
        role.setId(entity.getId());
        role.setName(entity.getName());
        return role;
    }
}