
--8. Count the number of distinct suppliers that 
--supply parts whom type contains MEDIUM POLISHED 
--and have size equal to any of 3, 23, 36, and 49.

SELECT COUNT(DISTINCT s_suppkey)
FROM supplier, part, partsupp
WHERE
    s_suppkey = ps_suppkey AND
    ps_partkey = p_partkey AND
    (p_size = 3 OR p_size = 23 OR 
     p_size = 36 OR p_size = 49) AND
     p_type LIKE "%MEDIUM%" AND
     p_type LIKE "%POLISHED%"
