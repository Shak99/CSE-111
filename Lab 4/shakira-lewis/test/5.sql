
--5. Find the number of orders made by customers from 
--PERU in 1996.

SELECT COUNT(*)
FROM orders, customer, nation
WHERE 
    n_name = 'PERU' AND
    substr(o_orderdate, 1,4) = '1996' AND
    c_custkey = o_custkey AND
    c_nationkey = n_nationkey 
    ORDER BY n_name

