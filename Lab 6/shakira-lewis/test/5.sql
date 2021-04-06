--5. Find how many distinct suppliers supply 
--the least expensive part (p retailprice).

SELECT COUNT(s_suppkey)
FROM part, partsupp, supplier, (SELECT MIN(p_retailprice) as minPart
                                FROM part,partsupp, supplier
                                WHERE
                                    p_partkey = ps_partkey AND
                                    s_suppkey = ps_suppkey
                                ) as subQ
WHERE
    p_partkey = ps_partkey AND
    s_suppkey = ps_suppkey AND
    p_retailprice = minPart