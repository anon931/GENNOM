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
