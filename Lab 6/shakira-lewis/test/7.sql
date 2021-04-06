---7. Find how many suppliers have less than 
--30 distinct orders from customers in GERMANY 
--and FRANCE together.

SELECT COUNT(lKey)
FROM (SELECT l_suppkey as lKey, COUNT(DISTINCT o_orderkey) as custCount
      FROM orders, customer, nation, lineitem --nation n1, nation n2, supplier
      WHERE
        o_custkey = c_custkey AND
        o_orderkey = l_orderkey AND
        (n_nationkey = 7 OR
        n_nationkey = 6) AND
        c_nationkey = n_nationkey
      GROUP BY l_suppkey ) as subQ

WHERE custCount < 30
