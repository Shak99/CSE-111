
--How many different order clerks did the suppliers 
--in CANADA work with?

SELECT COUNT(DISTINCT o_clerk)
FROM orders, nation, supplier, lineitem
WHERE 
    s_suppkey = l_suppkey AND
    s_nationkey = n_nationkey AND
    n_name = 'CANADA' AND
    l_orderkey = o_orderkey


    