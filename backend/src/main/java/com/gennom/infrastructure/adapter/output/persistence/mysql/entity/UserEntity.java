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
