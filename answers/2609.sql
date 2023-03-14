SELECT c.name,p.sum FROM 
(select SUM(amount),id_categories from products group by id_categories) AS p 
JOIN 
categories AS c 
ON c.id = p.id_categories;
