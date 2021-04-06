--9. Find the parts (p name) ordered by customers 
--from AMERICA that are supplied by exactly 4 
--distinct suppliers from ASIA.

SELECT DISTINCT p_name
FROM part, partsupp, supplier, customer, orders,
     nation n1, nation n2
WHERE
    o_custkey = c_custkey AND
    s_suppkey = ps_suppkey AND
    p_partkey = ps_partkey AND
    c_nationkey = n1.n_nationkey AND
    n1.n_regionkey = 1 AND
    s_nationkey = n2.n_nationkey AND
    n2.n_regionkey = 2
    GROUP BY p_name
    HAVING COUNT( DISTINCT s_suppkey) = 4

    --CORRECT!!!!!!!!!