SELECT movies.id,movies.name 
FROM 
    movies 
JOIN 
    (select id, categorie from prices where value < 2) AS p 
ON movies.id_prices = p.id;
