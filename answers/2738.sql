SELECT c.name, s.avg 
FROM 
    (select ((math*2 + specific*3 + project_plan*5)/10)::decimal(10,2) as avg, candidate_id from score) AS s 
JOIN 
    candidate AS c 
ON c.id = s.candidate_id 
ORDER BY s.avg DESC;
