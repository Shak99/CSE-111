--6. Find the supplier-customer pair(s) with 
--the most expensive (o totalprice) completed 
--(F in o orderstatus) order(s).

SELECT s_name, c_name
FROM supplier, customer, lineitem, 
      orders,(SELECT Max(expensive) as Exp2
              FROM (SELECT o_orderkey as oKey, o_custkey as cKey, o_totalprice as expensive
                    FROM orders
                    WHERE
                    o_orderstatus = 'F'
                    GROUP BY o_orderkey) as sub1
            ) as sub2
WHERE
  s_suppkey = l_suppkey AND
  Exp2 = o_totalprice AND
  o_orderkey = l_orderkey AND
  o_custkey = c_custkey


