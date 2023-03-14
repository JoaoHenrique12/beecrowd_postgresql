SELECT prod.id, prod.name FROM
(SELECT id FROM categories WHERE name LIKE 'super%') AS cat
INNER JOIN
(SELECT id,name,id_categories FROM products) AS prod
ON cat.id = prod.id_categories;
