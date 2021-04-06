
--15. How many distinct orders are between customers 
--and suppliers with negative account balance?

SELECT COUNT(DISTINCT o_orderkey)
FROM orders, supplier, lineitem, customer
WHERE
    o_orderkey = l_orderkey AND --
    l_suppkey = s_suppkey AND --
    o_custkey = c_custkey AND --
    --c_nationkey = s_nationkey AND
    c_acctbal < 0 AND
    s_acctbal < '0'
