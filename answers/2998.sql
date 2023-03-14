( 
    SELECT DISTINCT 
    c.name, c.investment,  
    (MIN(o.month) OVER( PARTITION BY c.id )) AS month_of_payback,
    (MIN((o.profit_amount - c.investment)) OVER( PARTITION BY c.id )) AS "return"
    FROM 
    ( 
        SELECT * FROM clients
    ) AS c
    JOIN
    ( -- Profit amount until month X.
        SELECT client_id, month,
            SUM(profit) 
                OVER (partition by client_id order by client_id 
                    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS profit_amount
        FROM operations 
    ) AS o

    ON o.client_id = c.id
    WHERE c.investment <= o.profit_amount 
    ORDER BY "return" DESC
)
