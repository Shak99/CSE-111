--8. Find how many distinct customers have at least 
--one order supplied exclusively by suppliers from 
--ASIA.

SELECT COUNT( DISTINCT c_custkey)
FROM orders, customer
WHERE
    o_custkey = c_custkey AND
    o_orderkey NOT IN (SELECT DISTINCT o_orderkey
                       FROM lineitem, supplier, orders, nation, region
                       WHERE
                        o_orderkey = l_orderkey AND
                        s_nationkey = n_nationkey AND
                        s_suppkey = l_suppkey AND
                        n_regionkey = r_regionkey AND
                        r_regionkey != 2)
