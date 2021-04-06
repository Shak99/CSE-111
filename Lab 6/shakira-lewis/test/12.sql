--12. Find the nation(s) having customers that spend 
--the largest amount of money (o totalprice).

SELECT DISTINCT n_name
FROM orders, customer, nation,


(SELECT n_name as natName, MAX(largest) maxNum
FROM orders, customer, nation, (SELECT n_name as natName0, SUM(o_totalprice) as largest
                               FROM orders, customer, nation
                               WHERE
                                o_custkey = c_custkey AND
                                c_nationkey = n_nationkey
                                GROUP BY n_name) as dub1
WHERE
    o_custkey = c_custkey AND
    c_nationkey = n_nationkey AND
    natName0 = n_name
) subQ1,

(SELECT SUM(o_totalprice) as mainLargest
 FROM orders, customer, nation
 WHERE
    o_custkey = c_custkey AND
    c_nationkey = n_nationkey
    GROUP BY n_name
) subQ2


WHERE
    o_custkey = c_custkey AND
    c_nationkey = n_nationkey AND
    n_name = natName AND
    maxNum = mainLargest
