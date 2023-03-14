SELECT 
    dep.nome AS "Nome Departamento",
    COUNT(sal.salario) AS "Numero de Empregados",
    ROUND(AVG(sal.salario) ,2) AS "Media Salarial",
    MAX(sal.salario) AS "Maior Salario",
    MIN(sal.salario) AS "Menor Salario"
FROM 
( -- Salário líquido por pessoa.
    SELECT 
        sal_sum.matr,
        COALESCE((sal_sum.bruto - sal_desc.desconto),sal_sum.bruto) AS salario 
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
    select matr, lotacao, gerencia_cod_dep from empregado
) AS emp
ON sal.matr = emp.matr
JOIN
(
    select cod_dep, nome from departamento
) AS dep
ON dep.cod_dep IN ( emp.lotacao, emp.gerencia_cod_dep )
GROUP BY dep.nome
ORDER BY AVG(sal.salario)::decimal(10,2) desc;
