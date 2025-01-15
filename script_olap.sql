-- Create OLAP tables based on the OLTP schema

-- Dimension table for countries
CREATE TABLE dim_countries (
    country_id SERIAL PRIMARY KEY,
    name VARCHAR UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Dimension table for cities
CREATE TABLE dim_cities (
    city_id SERIAL PRIMARY KEY,
    city_name VARCHAR UNIQUE,
    country_id INT REFERENCES dim_countries(country_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Dimension table for clients with SCD Type 2
CREATE TABLE dim_clients (
    client_id SERIAL PRIMARY KEY,
    client_name VARCHAR UNIQUE,
    city_id INT REFERENCES dim_cities(city_id),
    effective_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    expiry_date TIMESTAMP,
    is_current BOOLEAN DEFAULT TRUE
);

-- Dimension table for users
CREATE TABLE dim_users (
    user_id SERIAL PRIMARY KEY,
    phone_number VARCHAR UNIQUE,
    user_name VARCHAR,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Dimension table for vehicles
CREATE TABLE dim_vehicles (
    vehicle_id SERIAL PRIMARY KEY,
    client_id INT REFERENCES dim_clients(client_id),
    model_name VARCHAR,
    public_id VARCHAR UNIQUE,
    unlock_cost DOUBLE PRECISION,
    minute_cost DOUBLE PRECISION,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Dimension table for bicycles
CREATE TABLE dim_bicycles (
    bicycle_id SERIAL PRIMARY KEY,
    vehicle_id INT REFERENCES dim_vehicles(vehicle_id),
    with_baggage BOOLEAN,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Dimension table for scooters
CREATE TABLE dim_scooters (
    scooter_id SERIAL PRIMARY KEY,
    vehicle_id INT REFERENCES dim_vehicles(vehicle_id),
    battery_status DOUBLE PRECISION,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Fact table for rides
CREATE TABLE fact_rides (
    ride_id SERIAL PRIMARY KEY,
    order_number INT UNIQUE,
    vehicle_id INT REFERENCES dim_vehicles(vehicle_id),
    user_id INT REFERENCES dim_users(user_id),
    total_cost DOUBLE PRECISION,
    duration DOUBLE PRECISION,
    client_id INT REFERENCES dim_clients(client_id),
    start_time TIMESTAMP,
    end_time TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
