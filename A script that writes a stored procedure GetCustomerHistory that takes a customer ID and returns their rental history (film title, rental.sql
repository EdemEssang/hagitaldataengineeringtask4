DELIMITER //

CREATE PROCEDURE GetCustomerHistory(IN customer_id_param INT)
BEGIN
    SELECT 
        f.title AS film_title,
        r.rental_date
    FROM 
        rental r
    JOIN 
        inventory i ON r.inventory_id = i.inventory_id
    JOIN 
        film f ON i.film_id = f.film_id
    WHERE 
        r.customer_id = customer_id_param
    ORDER BY 
        r.rental_date DESC;
END //

DELIMITER ;