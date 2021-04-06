--13. Find the nation(s) with the most developed 
--industry, i.e., selling items totaling the largest 
--amount of money (l extendedprice) in 1996 
--(l shipdate).

SELECT nName
FROM (SELECT nName, MAX(large)
      FROM (SELECT n_name as nName, SUM(l_extendedprice) as large
            FROM nation, lineitem, supplier
            WHERE
                substr(l_shipdate, 1,4) = '1996' AND
                s_nationkey = n_nationkey AND
                s_suppkey = l_suppkey
            GROUP BY n_name) as sub1
    ) as subQ