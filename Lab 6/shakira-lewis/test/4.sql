--4. Find how many suppliers from CANADA 
--supply at least 4 different parts.

SELECT DISTINCT COUNT(s_name)
FROM (SELECT s_name, COUNT(p_partkey) as numSupp
      FROM part, partsupp, supplier
      WHERE
        p_partkey = ps_partkey AND
        s_suppkey = ps_suppkey AND
        s_nationkey = 3
        GROUP BY s_name) as subQ
