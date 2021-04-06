--6. Based on the available quantity of items, who is 
--the manufacturer p_mfgr of the most popular item
--(the more popular an item is, the less available it 
--is in ps availqty) from Supplier#000000053?

SELECT p_mfgr
FROM part, partsupp, supplier, (SELECT MIN(ps_availqty) as popular
                                FROM partsupp, part, supplier
                                WHERE
                                    p_partkey = ps_partkey AND
                                    s_suppkey = ps_suppkey AND
                                    --s_suppkey = p_partkey AND
                                    s_name = "Supplier#000000053") as subQ
WHERE
    ps_availqty = popular AND
    p_partkey = ps_partkey AND
    s_suppkey = ps_suppkey AND
    --s_suppkey = p_partkey AND
    s_name = "Supplier#000000053"
