

--11. Find the customers that received at least a 5% 
--discount for at least 70 items. Print the custkey and
--the number of discounted items.

SELECT customer.c_custkey as Customers, COUNT(lineitem.l_quantity)
FROM customer, lineitem, orders
WHERE 
    lineitem.l_discount >= 0.05 AND
    orders.o_custkey = customer.c_custkey AND
    orders.o_orderkey = lineitem.l_orderkey
    GROUP BY customer.c_custkey
    HAVING COUNT(l_quantity) >= 70

