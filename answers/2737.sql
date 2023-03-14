(select name, customers_number FROM lawyers ORDER BY customers_number DESC limit 1 )

UNION ALL

(select name, customers_number FROM lawyers ORDER BY customers_number ASC limit 1 ) 

UNION ALL

(select 'Average' AS name ,AVG(customers_number)::int FROM lawyers);
