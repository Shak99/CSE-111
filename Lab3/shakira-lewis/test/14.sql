


--14. Find how many 1-URGENT priority orders have 
--been posted by customers from France between 1994
--and 1996, combined.

SELECT COUNT(orders.o_orderpriority) as "Priorities from France"
FROM orders, nation, customer
WHERE 
    orders.o_orderpriority =  '1-URGENT' AND
    orders.o_custkey = customer.c_custkey AND
    customer.c_nationkey = nation.n_nationkey AND
    orders.o_orderdate >= '1994-01-01' AND
    orders.o_orderdate <= '1996-12-31' AND
    nation.n_name = 'FRANCE';
