--9. Count the number of supplied parts that have total value 
--(ps supplycost*ps availqty) in the top 3% values across all 
--the supplied parts and are supplied by suppliers from CANADA. 
--Hint: Use the LIMIT keyword.

SELECT COUNT()
FROM supplier, nation, (SELECT (ps_supplycost*ps_availqty) as totVal, ps_partkey, ps_suppkey
                        FROM partsupp
                        LIMIT 0.03 * (SELECT COUNT(ps_partkey)
                                      FROM partsupp)
                        ) subQ_total
WHERE
    s_nationkey = n_nationkey AND
    n_name = 'CANADA' AND
    ps_suppkey = s_suppkey AND
    ps_suppkey = subQ_total.ps_suppkey


