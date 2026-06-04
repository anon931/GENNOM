package com.gennom.application.ports.output;
import com.gennom.domain.model.User;
import java.util.Optional;
public interface UserRepositoryPort {
    Optional<User> findByUsername(String username);
    Optional<User> findByEmail(String email);
    User save(User user);
}
