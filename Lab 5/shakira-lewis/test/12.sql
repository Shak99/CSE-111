--12. What is the total supply cost for parts less 
--expensive than $1000 (p_retailprice) shipped in 
--1996 (l shipdate) by suppliers who did not supply 
--any item with an extended price less than 2000 in
--1995?

SELECT SUM(ps_supplycost)
FROM part, lineitem, supplier, partsupp
WHERE
    p_retailprice < 1000 AND
    substr(l_shipdate, 1, 4) = '1996' AND
    l_partkey = p_partkey AND
    l_suppkey = s_suppkey AND
    s_suppkey = ps_suppkey AND
    ps_partkey = p_partkey AND


    s_suppkey NOT IN (SELECT l_suppkey 
                  FROM lineitem
                  WHERE 
                    l_extendedprice < 2000 AND
                    substr(l_shipdate, 1, 4) = '1995') 

