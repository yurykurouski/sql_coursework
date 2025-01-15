-- Enable CSV quote handling
SET standard_conforming_strings = OFF;

-- Load data from CSV files with TRIM option
-- NOTE: Change the path to the CSV files!
COPY countries FROM 'countries.csv' WITH (FORMAT csv, HEADER true);
COPY cities FROM 'cities.csv' WITH (FORMAT csv, HEADER true);
COPY clients FROM 'clients.csv' WITH (FORMAT csv, HEADER true);
COPY users FROM program 'cat users.csv | sed "s/[ \t]*$//"' WITH (FORMAT csv, HEADER true);
COPY vehicles FROM program 'cat vehicles.csv | sed "s/[ \t]*$//"' WITH (FORMAT csv, HEADER true);
COPY bicycles FROM 'bicycles.csv' WITH (FORMAT csv, HEADER true);
COPY scooters FROM 'scooters.csv' WITH (FORMAT csv, HEADER true);
COPY rides FROM 'rides.csv' WITH (FORMAT csv, HEADER true);

-- Reset CSV quote handling to default
SET standard_conforming_strings = ON;