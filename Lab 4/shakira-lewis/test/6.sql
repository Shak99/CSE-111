
--6. How many parts produced by every supplier 
--in AMERICA are ordered at each priority? Print 
--the supplier name, the order priority, and the 
--number of orders.

SELECT s_name, o_orderpriority, COUNT(l_quantity)
FROM orders, lineitem, nation, region, supplier
WHERE
    s_nationkey = n_nationkey AND
    n_regionkey = r_regionkey AND
    r_name = 'AMERICA' AND
    s_suppkey = l_suppkey AND
    o_orderkey = l_orderkey
    GROUP BY s_name, o_orderpriority

    