SELECT customers.name, r.rentals_date 
FROM 
    customers 
JOIN 
    (select * from rentals where EXTRACT(MONTH FROM rentals_date) = 9) AS r 
ON customers.id = r.id_customers;
