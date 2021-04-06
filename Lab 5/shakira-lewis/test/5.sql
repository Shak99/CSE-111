--5. For parts whom type contains STEEL, return the name 
--of the supplier from AMERICA that can supply them at 
--minimum cost (ps supplycost), for every part size. 
--Print the supplier name together withthe part size 
--and the minimum cost.

SELECT DISTINCT s_name, p_size, MIN(ps_supplycost)
FROM supplier, part, partsupp, nation
WHERE
    p_partkey = ps_partkey AND
    s_suppkey = ps_suppkey AND

    p_type LIKE "%STEEL%" AND
    s_nationkey = n_nationkey AND
    n_regionkey = 1
    GROUP BY p_size

