-- Games


SELECT 
    q1.name,
    COUNT(q1.games) as matches,
    COUNT(q1.games = '+' OR NULL) as victories,
    COUNT(q1.games = '-' OR NULL) as defeats,
    COUNT(q1.games = '=' OR NULL) as draws,
    (COUNT(q1.games = '+' OR NULL) * 3 + COUNT(q1.games = '=' OR NULL)) as score
    FROM 
( 
    (-- When Team is Team 1
        SELECT t.name, 

    CASE 
        WHEN team_1_goals > team_2_goals THEN '+'
        WHEN team_2_goals > team_1_goals THEN '-'
        ELSE '='
    END AS games

    FROM teams AS t JOIN matches AS m

    ON t.id = team_1)

    
    UNION ALL

    (-- When Team is Team 2
        SElECT t.name, 

    CASE 
        WHEN team_1_goals < team_2_goals THEN '+'
        WHEN team_2_goals < team_1_goals THEN '-'
        ELSE '='
    END AS games

    FROM 

    teams AS t JOIN matches AS m

    ON t.id = team_2)
) AS q1

GROUP BY q1.name
ORDER BY score DESC, name ASC;
