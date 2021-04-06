


--10. Find the total price of orders made 
--by customers from EUROPE in 1996.

SELECT SUM(orders.o_totalprice)
FROM orders, customer, nation, region
WHERE 
    customer.c_nationkey = nation.n_nationkey AND
    customer.c_custkey = orders.o_custkey AND
    nation.n_regionkey = region.r_regionkey AND
    region.r_name = 'EUROPE' AND
    orders.o_orderdate >= '1996-01-01' AND
    orders.o_orderdate <= '1996-12-31';