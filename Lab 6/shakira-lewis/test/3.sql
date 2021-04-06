--3. Find how many parts are supplied by 
--more than one supplier from CANADA.


SELECT COUNT(DISTINCT p_partkey)
FROM supplier, part, partsupp, nation, (SELECT p_partkey as part,COUNT(s_suppkey) as suppCount
                                        FROM part, partsupp, nation, supplier
                                        WHERE
                                            s_suppkey = ps_suppkey AND
                                            ps_partkey = p_partkey AND
                                            s_nationkey = n_nationkey AND
                                            n_name = 'CANADA'
                                            GROUP BY p_partkey) as subQ
WHERE
    s_suppkey = ps_suppkey AND
    ps_partkey = p_partkey AND
    s_nationkey = n_nationkey AND
    n_name = 'CANADA' AND
    part = p_partkey AND
    suppCount > 1
