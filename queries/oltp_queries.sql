-- Get clients with the most median earnings for a ride
SELECT 
    c.client_name,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY r.total_cost) AS median_earning
FROM 
    clients c
JOIN 
    rides r ON c.client_name = r.client_name
GROUP BY 
    c.client_name
ORDER BY 
    median_earning DESC;

-- Get clients with the most total battery level
SELECT 
    c.client_name,
    SUM(s.battery_status) AS total_battery_level
FROM 
    clients c
JOIN 
    rides r ON c.client_name = r.client_name
JOIN 
    vehicles v ON r.vehicle = v.model_name
JOIN 
    scooters s ON v.model_name = s.model_name
GROUP BY 
    c.client_name
ORDER BY 
    total_battery_level DESC;