-- Query to get users with the most rides
SELECT 
    u.phone_number,
    u.user_name,
    COUNT(r.ride_id) AS ride_count
FROM 
    dim_users u
LEFT JOIN 
    fact_rides r ON u.user_id = r.user_id
GROUP BY 
    u.phone_number, u.user_name
ORDER BY 
    ride_count DESC;

-- Query to get clients with the most revenue
SELECT 
    c.client_name,
    SUM(r.total_cost) AS total_revenue
FROM 
    dim_clients c
JOIN 
    fact_rides r ON c.client_id = r.client_id
GROUP BY 
    c.client_name
ORDER BY 
    total_revenue DESC;