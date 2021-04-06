
--1. Find the total price paid on orders by 
--every customer from RUSSIA in 1996. Print 
--the customer name and the total price.

SELECT c_name, SUM(o_totalprice) as Total
FROM orders, customer, nation
WHERE
    o_custkey = c_custkey AND
    c_nationkey = n_nationkey AND
    n_name = 'RUSSIA' AND
    --o_orderdate >= '1996-01-01' AND
    --o_orderdate <= '1996-12-31'
    substr(o_orderdate, 1,4) = '1996'
GROUP BY c_name
