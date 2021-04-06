--14. Compute, for every country, the value of 
--economic exchange, i.e., the difference between the 
--number of items from suppliers in that country 
--sold to customers in other countries and the number 
--of items bought by local customers from foreign 
--suppliers in 1996 (l shipdate). Sort the results 
--in decreasing order of the economic exchange.


SELECT n_name, (num2 - num1)
FROM nation, (SELECT n_name nName1, COUNT(l_suppkey) as num1
              FROM supplier, lineitem, nation
              WHERE
                s_suppkey = l_suppkey AND
                s_nationkey != n_nationkey AND
                substr(l_shipdate, 1,4) = '1996'
              GROUP BY n_name) as mainQ1,


            (SELECT n_name as nName2, COUNT(l_suppkey) as num2
             FROM customer, lineitem, nation, orders
             WHERE
                o_custkey = c_custkey AND
                o_orderkey = l_orderkey AND
                c_nationkey != n_nationkey AND
                substr(l_shipdate, 1,4) = '1996'
             GROUP BY n_name) as mainQ2

WHERE
    nName1 = nName2 AND
    nName1 = n_name --and n_name = 'UNITED KINGDOM'
    --GROUP BY (num2 - num1)
    --ORDER BY (num2 - num1) DESC

UNION

SELECT n_name, (num2 - num1)
FROM nation, (SELECT n_name nName1, COUNT(l_suppkey) as num1
              FROM supplier, lineitem, nation
              WHERE
                s_suppkey = l_suppkey AND
                s_nationkey != n_nationkey AND
                substr(l_shipdate, 1,4) = '1996'
              GROUP BY n_name) as mainQ1,


            (SELECT n_name as nName2, COUNT(l_suppkey) as num2
             FROM customer, lineitem, nation, orders
             WHERE
                o_custkey = c_custkey AND
                o_orderkey = l_orderkey AND
                c_nationkey != n_nationkey AND
                substr(l_shipdate, 1,4) = '1996'
             GROUP BY n_name) as mainQ2

WHERE
    nName1 = nName2 AND
    nName1 = n_name and n_name = 'UNITED KINGDOM'
    GROUP BY (num2 - num1)
    ORDER BY (num2 - num1) DESC