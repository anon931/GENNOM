package com.gennom.infrastructure.adapter.output.persistence.mysql.repository;
import com.gennom.infrastructure.adapter.output.persistence.mysql.entity.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;
public interface JpaUserRepository extends JpaRepository<UserEntity, Long> {
    Optional<UserEntity> findByUsername(String username);
    Optional<UserEntity> findByEmail(String email);
}
