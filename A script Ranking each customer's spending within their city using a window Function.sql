WITH CustomerSpending AS (
    SELECT 
        c.customer_id,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        ci.city,
        SUM(p.amount) AS total_spent
    FROM 
        customer c
    JOIN 
        payment p ON c.customer_id = p.customer_id
    JOIN 
        address a ON c.address_id = a.address_id
    JOIN 
        city ci ON a.city_id = ci.city_id
    GROUP BY 
        c.customer_id, c.first_name, c.last_name, ci.city
)

SELECT 
    customer_id,
    customer_name,
    city,
    total_spent,
    RANK() OVER (PARTITION BY city ORDER BY total_spent DESC) AS city_spending_rank,
    DENSE_RANK() OVER (PARTITION BY city ORDER BY total_spent DESC) AS city_spending_dense_rank,
    PERCENT_RANK() OVER (PARTITION BY city ORDER BY total_spent DESC) AS city_spending_percentile
FROM 
    CustomerSpending
ORDER BY 
    city, city_spending_rank;