SELECT m.id, m.name 
FROM movies AS m 
JOIN genres AS g
ON m.id_genres = g.id
WHERE g.description = 'Action';
