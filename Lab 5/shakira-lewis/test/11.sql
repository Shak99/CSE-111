
--11. Find the highest value items 
--(l extendedprice*(1-l discount)) not shipped as 
--of October 2, 1994. Print the name of the part 
--corresponding to these items.


SELECT DISTINCT p_name
FROM lineitem, part, (SELECT p_partkey as pKey, MAX(l_extendedprice*(1-l_discount)) as highVal
                      FROM lineitem, part
                      WHERE
                        p_partkey = l_partkey AND
                        --ps_suppkey = l_suppkey AND
                        l_shipdate > '1994-10-02') as subQ
WHERE
    pKey = p_partkey