package com.gennom.domain.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
    import lombok.Data;
import lombok.NoArgsConstructor;
import java.time.LocalDateTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Company {
    private Long id;
    private String name;
    private String industry;
    private String contactEmail;
    private String phone;
    private LocalDateTime registeredAt;
    private Boolean active;
}