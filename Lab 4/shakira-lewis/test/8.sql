
--8. Find the number of distinct orders completed 
--in 1994 by the suppliers in every country. An order
--status of F stands for complete. Print only those 
--countries for which the number of orders is larger
--than 300.


SELECT n_name, COUNT(DISTINCT l_orderkey)
FROM nation, orders, supplier, lineitem
WHERE
    substr(o_orderdate, 1,4) = '1994' AND --
    s_suppkey = l_suppkey AND --
    s_nationkey = n_nationkey AND
    l_orderkey = o_orderkey AND --
    o_orderstatus = 'F'
    GROUP BY n_name
    HAVING COUNT(DISTINCT l_orderkey) > 300

    