CREATE TABLE IF NOT EXISTS industrial_facility (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    location VARCHAR(500),
    voltage_level VARCHAR(20),
    max_power_kw DECIMAL(10,2),
    active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS energy_consumption (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    facility_id BIGINT NOT NULL,
    timestamp DATETIME NOT NULL,
    power_kw DECIMAL(10,2) NOT NULL,
    voltage_v DECIMAL(10,2),
    current_a DECIMAL(10,2),
    power_factor DECIMAL(5,3),
    temperature_c DECIMAL(5,2),
    cost_per_kwh DECIMAL(8,4),
    day_of_week TINYINT,
    month TINYINT,
    year SMALLINT,
    is_holiday BOOLEAN,
    INDEX idx_facility_time (facility_id, timestamp)
);