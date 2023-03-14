SELECT da.name, SUM((da.hours * 150 *(1 + ws.bonus/100) ))::decimal(10,1) AS salary 
FROM 
    ( doctors AS d JOIN attendances AS a ON d.id = a.id_doctor ) AS da 
JOIN 
    work_shifts as ws 
ON ws.id = da.id_work_shift 
GROUP BY da.id_doctor, da.name 
ORDER BY salary DESC;
