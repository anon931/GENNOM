package com.gennom.application.ports.input;
import com.gennom.application.dto.LoginRequest;
import com.gennom.application.dto.RegisterRequest;
import com.gennom.application.dto.AuthResponse;
public interface AuthUseCase {
    AuthResponse login(LoginRequest request);
    AuthResponse register(RegisterRequest request);
}
