
--4. How many parts with size below 30 does every 
--supplier from CHINA offer? Print the name of the
--supplier and the number of parts.


SELECT DISTINCT s_name, COUNT(p_size)
FROM part, partsupp,supplier, nation
WHERE
    p_size < 30 AND
    p_partkey = ps_partkey AND
    ps_suppkey = s_suppkey AND
    s_nationkey = n_nationkey AND
    n_name = 'CHINA'
    GROUP BY s_name