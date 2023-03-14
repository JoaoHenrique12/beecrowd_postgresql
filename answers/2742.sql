SELECT l.name, ((l.omega * 1.618)::DECIMAL(10,3)) as "Fator N"  FROM 
(
    SELECT id FROM dimensions  WHERE name IN ('C875', 'C774')
) AS d
JOIN 
(
    SELECT name, omega, dimensions_id 
    FROM life_registry 
    WHERE starts_with(LOWER(name),'richard')
)AS l

ON d.id = l.dimensions_id

ORDER BY l.omega;

