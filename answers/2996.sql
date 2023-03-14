WITH p AS (
    SELECT * FROM packages 
), u AS (
    SELECT * FROM users
)

(
    SELECT p.year, u.name, u2.name FROM
    (u JOIN p ON u.id  = p.id_user_sender)
    JOIN
    u AS u2 ON u2.id = p.id_user_receiver
    WHERE 
        u.address <> 'Taiwan' AND u2.address <> 'Taiwan'
        AND ( p.year = 2015 OR p.color = 'blue' )
)
