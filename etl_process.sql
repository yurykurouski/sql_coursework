-- Enable the dblink extension
CREATE EXTENSION IF NOT EXISTS dblink;

-- Extract data from OLTP and load into OLAP

-- Extract and load countries
INSERT INTO dim_countries (name)
SELECT country_name
FROM dblink('dbname=OLTP user=admin password=password host=localhost port=5432',
            'SELECT country_name FROM countries') AS t(country_name VARCHAR);

-- Extract and load cities
INSERT INTO dim_cities (city_name, country_id)
SELECT c.city_name, dc.country_id
FROM dblink('dbname=OLTP user=admin password=password host=localhost port=5432',
            'SELECT city_name, country_name FROM cities') AS c(city_name VARCHAR, country_name VARCHAR)
JOIN dim_countries dc ON c.country_name = dc.name;

-- Extract and load clients
INSERT INTO dim_clients (client_name, city_id, effective_date, is_current)
SELECT cl.client_name, dci.city_id, CURRENT_TIMESTAMP, TRUE
FROM dblink('dbname=OLTP user=admin password=password host=localhost port=5432',
            'SELECT client_name, city_name FROM clients') AS cl(client_name VARCHAR, city_name VARCHAR)
JOIN dim_cities dci ON cl.city_name = dci.city_name;

-- Extract and load users
INSERT INTO dim_users (phone_number, user_name)
SELECT phone_number, user_name
FROM dblink('dbname=OLTP user=admin password=password host=localhost port=5432',
            'SELECT phone_number, user_name FROM users') AS u(phone_number VARCHAR, user_name VARCHAR);

-- Extract and load vehicles
INSERT INTO dim_vehicles (model_name, public_id, unlock_cost, minute_cost, client_id)
SELECT v.model_name, v.public_id, v.unlock_cost, v.minute_cost, dc.client_id
FROM dblink('dbname=OLTP user=admin password=password host=localhost port=5432',
            'SELECT model_name, public_id, unlock_cost, minute_cost, client_name FROM vehicles') AS v(model_name VARCHAR, public_id VARCHAR, unlock_cost DOUBLE PRECISION, minute_cost DOUBLE PRECISION, client_name VARCHAR)
JOIN dim_clients dc ON v.client_name = dc.client_name;

-- Extract and load bicycles
INSERT INTO dim_bicycles (vehicle_id, with_baggage)
SELECT dv.vehicle_id, b.with_baggage
FROM dblink('dbname=OLTP user=admin password=password host=localhost port=5432',
            'SELECT model_name, with_baggage FROM bicycles') AS b(model_name VARCHAR, with_baggage BOOLEAN)
JOIN dim_vehicles dv ON b.model_name = dv.model_name;

-- Extract and load scooters
INSERT INTO dim_scooters (vehicle_id, battery_status)
SELECT dv.vehicle_id, s.battery_status
FROM dblink('dbname=OLTP user=admin password=password host=localhost port=5432',
            'SELECT model_name, battery_status FROM scooters') AS s(model_name VARCHAR, battery_status DOUBLE PRECISION)
JOIN dim_vehicles dv ON s.model_name = dv.model_name;

-- Extract and load rides
INSERT INTO fact_rides (order_number, vehicle_id, user_id, total_cost, duration, client_id, start_time, end_time)
SELECT r.order_number, dv.vehicle_id, du.user_id, r.total_cost, r.duration, dc.client_id, r.start_time, r.end_time
FROM dblink('dbname=OLTP user=admin password=password host=localhost port=5432',
            'SELECT order_number, vehicle, user_name, total_cost, duration, client_name, start_time, end_time FROM rides') AS r(order_number INT, vehicle VARCHAR, user_name VARCHAR, total_cost DOUBLE PRECISION, duration DOUBLE PRECISION, client_name VARCHAR, start_time TIMESTAMP, end_time TIMESTAMP)
JOIN dim_vehicles dv ON r.vehicle = dv.model_name
JOIN dim_users du ON r.user_name = du.phone_number
JOIN dim_clients dc ON r.client_name = dc.client_name;
