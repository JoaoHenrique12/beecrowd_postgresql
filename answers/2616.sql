SELECT DISTINCT ON (c.id) 
c.id, c.name 
FROM 
    customers AS c 
LEFT OUTER JOIN 
    locations AS l 
ON c.id = l.id_customers 
WHERE l.id_customers IS NULL 
ORDER BY c.id;
