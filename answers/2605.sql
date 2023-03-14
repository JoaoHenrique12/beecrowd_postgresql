SELECT produto.name,vendedor.name 
FROM (SELECT name, id_providers FROM products WHERE id_categories = 6) AS produto 
INNER JOIN (SELECT name, id FROM providers) AS vendedor 
ON produto.id_providers = vendedor.id;
