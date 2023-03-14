SELECT p.name, v.name, p.price 
FROM 
    (products AS p JOIN providers AS v ON p.id_providers = v.id) 
JOIN 
    categories AS cat 
ON cat.id = p.id_categories 
WHERE cat.name = 'Super Luxury' AND p.price > 1000;
