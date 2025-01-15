# SQL Coursework

## Overview

This project involves setting up an OLTP (Online Transaction Processing) and OLAP (Online Analytical Processing) database system. The OLTP schema is designed to handle day-to-day transaction data, while the OLAP schema is optimized for analytical queries.

### OLTP Schema

- **Tables:**
  - `countries`: Stores country names.
  - `cities`: Stores city names and references the `countries` table.
  - `clients`: Stores client information and references the `cities` and `countries` tables.
  - `users`: Stores user information, including phone numbers and current balance, and references the `clients` table.
  - `vehicles`: Stores vehicle information, including model names and booking status, and references the `clients` table.
  - `bicycles`: Stores bicycle-specific information and references the `vehicles` table.
  - `scooters`: Stores scooter-specific information and references the `vehicles` table.
  - `rides`: Stores ride information, including order numbers and total cost, and references the `vehicles`, `users`, and `clients` tables.

- **Keys and Constraints:**
  - Primary keys are defined for each table.
  - Foreign keys are used to establish relationships between tables.
  - Constraints ensure data integrity, such as the `booking_status` check in the `vehicles` table.

### OLAP Schema

- **Tables:**
  - `dim_countries`: Dimension table for countries.
  - `dim_cities`: Dimension table for cities, referencing `dim_countries`.
  - `dim_clients`: Dimension table for clients with Slowly Changing Dimension (SCD) Type 2.
  - `dim_users`: Dimension table for users.
  - `dim_vehicles`: Dimension table for vehicles, referencing `dim_clients`.
  - `dim_bicycles`: Dimension table for bicycles, referencing `dim_vehicles`.
  - `dim_scooters`: Dimension table for scooters, referencing `dim_vehicles`.
  - `fact_rides`: Fact table for rides, referencing `dim_vehicles`, `dim_users`, and `dim_clients`.

- **Keys and Constraints:**
  - Primary keys are defined for each table.
  - Foreign keys are used to establish relationships between tables.

## Instructions

### Setting Up the Database

1. **Create the OLTP Schema:**
   - Run the `script_oltp.sql` script to create the OLTP tables.

2. **Load Data into OLTP:**
   - Use the `upload_data.sql` script to load data from CSV files into the OLTP tables. **NOTE: Ensure the path to the CSV files is correct in the `upload_data.sql` script.**

3. **Create the OLAP Schema:**
   - Run the `script_olap.sql` script to create the OLAP tables.

4. **Run the ETL Process:**
   - Execute the `etl_process.sql` script to extract data from the OLTP database and load it into the OLAP database.

### Running Queries

- Use the `queries/oltp_queries.sql` and `queries/olap_queries.sql` scripts to run analytical queries on the OLTP and OLAP databases, respectively.

## Notes

- Ensure that the PostgreSQL server is running and accessible.
- Modify the connection details in the `dblink` function within the `etl_process.sql` script to match your database configuration.
- The `dblink` extension must be enabled in your PostgreSQL instance to perform cross-database queries.
