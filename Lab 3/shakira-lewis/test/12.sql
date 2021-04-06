


--12. Find the number of orders having status F for each 
--customer region and display them in descending order. 
--Print the region name and the number of status F orders.

SELECT region.r_name as Region, COUNT(orders.o_orderstatus)
FROM region, orders, customer, nation
WHERE 
    orders.o_custkey = customer.c_custkey AND
    customer.c_nationkey = nation.n_nationkey AND
    nation.n_regionkey = region.r_regionkey AND
    orders.o_orderstatus = 'F'
    GROUP BY region.r_name;