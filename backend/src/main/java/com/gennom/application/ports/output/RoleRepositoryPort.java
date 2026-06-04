package com.gennom.application.ports.output;
import com.gennom.domain.model.Role;
import java.util.Optional;
public interface RoleRepositoryPort {
    Optional<Role> findByName(String name);
}
