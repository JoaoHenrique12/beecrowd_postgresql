SELECT pro.name 
FROM 
    providers AS ov 
JOIN 
    products AS pro 
ON ov.id = pro.id_providers 
WHERE pro.amount >= 10 AND pro.amount <= 20 AND starts_with(ov.name,'P');
