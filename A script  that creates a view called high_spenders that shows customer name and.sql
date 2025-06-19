-- Create the high_spenders view
CREATE OR REPLACE VIEW high_spenders AS
SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    SUM(p.amount) AS total_spent
FROM 
    customer c
INNER JOIN 
    payment p ON c.customer_id = p.customer_id
GROUP BY 
    c.customer_id, c.first_name, c.last_name
HAVING 
    SUM(p.amount) > 150
ORDER BY 
    total_spent DESC;

-- Query the view to see results
SELECT * FROM high_spenders;