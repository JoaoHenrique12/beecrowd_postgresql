SELECT et.cpf, et.enome, d.dnome 
FROM 
    (select e.cpf, e.enome, e.dnumero from trabalha as t right join empregados as e on e.cpf = t.cpf_emp where t.cpf_emp is NULL) AS et 
JOIN 
    departamentos AS d 
ON d.dnumero = et.dnumero 
ORDER BY et.cpf;
