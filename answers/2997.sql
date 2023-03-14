(
    SELECT 
        dep.nome AS Departamento,
        emp.nome AS Empregado,
        sal.sal_bruto AS "Salario Bruto",
        COALESCE(sal.sal_desc, 0) AS "Total Desconto",
        sal.sal_li AS "Salario Liquido"
    FROM 
    ( -- Salário líquido por pessoa.
        SELECT 
            sal_sum.matr,
            sal_sum.bruto AS sal_bruto,
            sal_desc.desconto AS sal_desc,
            COALESCE((sal_sum.bruto - sal_desc.desconto),sal_sum.bruto) AS sal_li
        FROM
        ( -- Salário Bruto por pessoa. 
            /* O left join está sendo usado porque podem existir
             * funcionários que não recebem salário.
             * Em seguida a função COALESCE adiciona o valor 0.00 para
             * quem não recebe salário.
             */
            SELECT e.matr,  COALESCE(SUM(v.valor), 0) AS bruto 
            FROM 
                empregado AS e
            LEFT JOIN
                emp_venc AS ev
            ON e.matr = ev.matr
            LEFT JOIN
                vencimento AS v
            ON v.cod_venc = ev.cod_venc

            GROUP BY e.matr
        ) AS sal_sum
        LEFT JOIN
        ( -- Soma de Descontos salariais por pessoa.
            SELECT e.matr, SUM(d.valor) as desconto FROM
                empregado AS e
            JOIN
                emp_desc AS ed
            ON e.matr = ed.matr

            JOIN
                desconto AS d
            ON d.cod_desc = ed.cod_desc

            GROUP BY e.matr
        ) AS sal_desc

        ON sal_sum.matr = sal_desc.matr
    ) AS sal
    JOIN
    (
        SELECT nome, matr, lotacao, gerencia_cod_dep FROM empregado
    ) AS emp
    ON sal.matr = emp.matr
    -------------
    JOIN
    (
        SELECT cod_dep, nome FROM departamento
    ) AS dep
    ON dep.cod_dep IN ( emp.lotacao, emp.gerencia_cod_dep )
    ORDER BY sal.sal_li desc
)

