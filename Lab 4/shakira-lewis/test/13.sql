
--13. How many items are supplied by suppliers 
--in ASIA for orders made by customers in ARGENTINA?
  
SELECT COUNT(l_orderkey)
FROM supplier, lineitem, customer, 
     orders, nation, region
WHERE
    l_suppkey = s_suppkey AND
    o_orderkey = l_orderkey AND
    s_nationkey = n_nationkey AND
    n_regionkey = r_regionkey AND
    r_name = 'ASIA' AND
    c_custkey = o_custkey AND
    c_nationkey = 1
    
