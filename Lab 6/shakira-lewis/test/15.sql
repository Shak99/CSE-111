--15. Compute the change in the economic exchange 
--for every country between 1994 and 1996. There 
--should be two columns in the output for every 
--country: 1995 and 1996. Hint: use CASE to select 
--the values in the result.

SELECT DISTINCT nName1, ((num2_95 - num1_95) - (num2_94 - num1_94)) as '1995', ((num2_96 - num1_96) - (num2_95 - num1_95)) as '1996'
FROM nation, (SELECT n_name nName1, COUNT(l_suppkey) as num1_94
              FROM supplier, lineitem, nation
              WHERE
                s_suppkey = l_suppkey AND
                s_nationkey != n_nationkey AND
                substr(l_shipdate, 1,4) = '1994'
              GROUP BY n_name) as mainQ1_94,


            (SELECT n_name as nName2, COUNT(l_suppkey) as num2_94
             FROM customer, lineitem, nation, orders
             WHERE
                o_custkey = c_custkey AND
                o_orderkey = l_orderkey AND
                c_nationkey != n_nationkey AND
                substr(l_shipdate, 1,4) = '1994'
             GROUP BY n_name) as mainQ2_94,
------------------------------------------------------------------
             (SELECT n_name nName3, COUNT(l_suppkey) as num1_95
              FROM supplier, lineitem, nation
              WHERE
                s_suppkey = l_suppkey AND
                s_nationkey != n_nationkey AND
                substr(l_shipdate, 1,4) = '1996'
              GROUP BY n_name) as mainQ1_95,


            (SELECT n_name as nName4, COUNT(l_suppkey) as num2_95
             FROM customer, lineitem, nation, orders
             WHERE
                o_custkey = c_custkey AND
                o_orderkey = l_orderkey AND
                c_nationkey != n_nationkey AND
                substr(l_shipdate, 1,4) = '1996'
             GROUP BY n_name) as mainQ2_95,

             ------------------------------------------------------------------
             (SELECT n_name nName5, COUNT(l_suppkey) as num1_96
              FROM supplier, lineitem, nation
              WHERE
                s_suppkey = l_suppkey AND
                s_nationkey != n_nationkey AND
                substr(l_shipdate, 1,4) = '1996'
              GROUP BY n_name) as mainQ1_96,


            (SELECT n_name as nName6, COUNT(l_suppkey) as num2_96
             FROM customer, lineitem, nation, orders
             WHERE
                o_custkey = c_custkey AND
                o_orderkey = l_orderkey AND
                c_nationkey != n_nationkey AND
                substr(l_shipdate, 1,4) = '1996'
             GROUP BY n_name) as mainQ2_96
WHERE
    nName1 = nName2 AND
    nName2 = nName3 AND
    nName4 = nName5 AND
    nName5 = nName6 AND
    nName6 = n_name
    GROUP BY ((num2_95 - num1_95) - (num2_94 - num1_94))
    ORDER BY ((num2_95 - num1_95) - (num2_94 - num1_94)) DESC



--|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
--|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

--SELECT n_name, ((num2_95 - num1_95) - (num2_94 - num1_94)) as '1995', ((num2_96 - num1_96) - (num2_95 - num1_95)) as '1996'
--FROM nation,


--CASE
--    WHEN
--        s_suppkey = l_suppkey AND
--        s_nationkey = c_nationkey AND
--        s_nationkey != n_nationkey AND
--        substr(l_shipdate, 1,4) = '1994'
--        THEN COUNT(l_suppkey)
--    END AS Query94,
--CASE
--    WHEN
--        s_suppkey = l_suppkey AND
--        s_nationkey = c_nationkey AND
--        s_nationkey != n_nationkey AND
--        substr(l_shipdate, 1,4) = '1995'
--        THEN COUNT(l_suppkey)
--    END AS Query95,
--CASE
--    WHEN
--        s_suppkey = l_suppkey AND
--        s_nationkey = c_nationkey AND
--        s_nationkey != n_nationkey AND
--        substr(l_shipdate, 1,4) = '1996'
--        THEN COUNT(l_suppkey)
--    END AS Query96
