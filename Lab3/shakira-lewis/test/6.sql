

--6. What are the countries of customers who ordered items between March 10-12, 1995?

SELECT DISTINCT nation.n_name as Country
FROM customer, nation, orders
WHERE 
    customer.c_nationkey = nation.n_nationkey AND
    customer.c_custkey = orders.o_custkey AND
    orders.o_orderdate >= '1995-03-10' AND
    orders.o_orderdate <= '1995-03-12';
