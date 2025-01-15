-- Create tables in correct order
CREATE TABLE countries (
    country_name VARCHAR PRIMARY KEY
);

CREATE TABLE cities (
    city_name VARCHAR PRIMARY KEY,
    country_name VARCHAR REFERENCES countries(country_name)
);

CREATE TABLE clients (
    client_name VARCHAR PRIMARY KEY,
    city_name VARCHAR REFERENCES cities (city_name),
    country_name VARCHAR REFERENCES countries(country_name)
);

CREATE TABLE users (
    phone_number VARCHAR PRIMARY KEY,
    curr_balance DOUBLE PRECISION,
    user_name VARCHAR, 
    client_name VARCHAR REFERENCES clients(client_name)
);

CREATE TABLE vehicles (
    model_name VARCHAR PRIMARY KEY,
    public_id VARCHAR,
    location_lng DOUBLE PRECISION,
    location_lgt DOUBLE PRECISION,
    booking_status VARCHAR CHECK (booking_status IN ('Booked', 'Free', 'In Ride')),
    unlock_cost DOUBLE PRECISION,
    minute_cost DOUBLE PRECISION,
    client_name VARCHAR REFERENCES clients(client_name)
);

CREATE TABLE bicycles (
    model_name VARCHAR PRIMARY KEY REFERENCES vehicles(model_name),
    with_baggage BOOLEAN
);

CREATE TABLE scooters (
    model_name VARCHAR PRIMARY KEY REFERENCES vehicles(model_name),
    battery_status DOUBLE PRECISION
);

CREATE TABLE rides (
    order_number INT PRIMARY KEY,
    vehicle VARCHAR REFERENCES vehicles(model_name),
    user_name VARCHAR REFERENCES users(phone_number),
    total_cost DOUBLE PRECISION,
    duration DOUBLE PRECISION,
    client_name VARCHAR REFERENCES clients(client_name),
    start_time TIMESTAMP,
    end_time TIMESTAMP
);