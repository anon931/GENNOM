package com.gennom.infrastructure.adapter.output.persistence.mysql.repository;

import com.gennom.infrastructure.adapter.output.persistence.mysql.entity.RoleEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;

public interface JpaRoleRepository extends JpaRepository<RoleEntity, Long> {
    Optional<RoleEntity> findByName(String name);
}