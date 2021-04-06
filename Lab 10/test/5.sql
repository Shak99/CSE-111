--5. Create a trigger t5 that removes all the tuples from partsupp and lineitem corresponding to a part
--being deleted. Delete all the parts supplied by suppliers from FRANCE or GERMANY. Write a query that
--returns the number of parts supplied by every supplier in EUROPE grouped by their country in increasing
--order. Put all the SQL statements in le test/5.sql. (3 points)

CREATE TRIGGER t5 AFTER DELETE ON part
FOR EACH ROW
BEGIN
  DELETE
  FROM lineitem
  WHERE l_partkey = old.p_partkey;
  DELETE
  FROM partsupp
  WHERE ps_partkey = old.p_partkey;
END;


DELETE
FROM part
WHERE p_partkey in (SELECT p_partkey
                    FROM nation, part, supplier, partsupp
                    WHERE 
                        ps_suppkey = s_suppkey AND 
                        s_nationkey = n_nationkey AND 
                        p_partkey = ps_partkey AND 
                        (n_nationkey = 6 OR n_nationkey = 7));


SELECT n_name, COUNT(s_suppkey)
FROM partsupp, supplier, nation, region
WHERE 
    r_name = 'EUROPE' AND 
    s_nationkey = n_nationkey AND 
    r_regionkey = n_regionkey AND 
    ps_suppkey = s_suppkey
GROUP BY n_name ;
