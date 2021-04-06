


--9. Find the minimum account balance of the suppliers 
--from countries with less than 3 suppliers. Print
--the country and the minimum account balance.

SELECT DISTINCT nation.n_name, MIN(supplier.s_acctbal)
FROM nation, supplier
WHERE 
    supplier.s_nationkey = nation.n_nationkey AND
    3 > (SELECT COUNT(supplier.s_nationkey)
        FROM supplier
        WHERE supplier.s_nationkey = nation.n_nationkey)
GROUP BY nation.n_name;
