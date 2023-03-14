SELECT name, EXTRACT(DAY FROM payday)::integer AS day FROM loan;
