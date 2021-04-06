

--8. Find the name of the suppliers from ASIA 
--who have less than $1000 on account balance.

SELECT supplier.s_name as "Suppliers from Asia"
FROM supplier, nation, region
WHERE
    supplier.s_acctbal < 1000 AND
    supplier.s_nationkey = nation.n_nationkey AND
    nation.n_regionkey = region.r_regionkey AND
    region.r_name = 'ASIA'
    GROUP BY supplier.s_name;


  
