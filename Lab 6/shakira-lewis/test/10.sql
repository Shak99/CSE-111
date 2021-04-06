--10. Find the region where customers spend the 
--largest amount of money (l extendedprice) buying 
--items from suppliers in the same region.

SELECT r_name
FROM (SELECT DISTINCT r_name, max(total)
      FROM orders, customer, lineitem, supplier, nation, 
           region, (SELECT r_name as regName, SUM(l_extendedprice) as total
                    FROM orders, customer, lineitem, supplier, nation, region
                    WHERE
                        s_nationkey = c_nationkey AND
                        c_nationkey = n_nationkey AND
                        n_regionkey = r_regionkey AND
                        c_custkey = o_custkey AND
                        o_orderkey = l_orderkey
                    GROUP BY r_name
                    ) subQ1
      WHERE
        s_nationkey = c_nationkey AND
        c_nationkey = n_nationkey AND
        n_regionkey = r_regionkey AND
        c_custkey = o_custkey AND
        o_orderkey = l_orderkey AND
        r_name = regName
        ) as subQmain




