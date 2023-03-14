SELECT format AS name 
FROM
    (SELECT FORMAT('Podium: %s',team) FROM league ORDER BY position limit 3) AS q1
UNION ALL 
    (SELECT tmp.format FROM (SELECT position, FORMAT('Demoted: %s', team) FROM league ORDER BY position DESC limit 2) AS tmp ORDER BY tmp.position ASC);
