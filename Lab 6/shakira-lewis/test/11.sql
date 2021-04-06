--11. Find the nation(s) with the largest 
--number of customers.

SELECT DISTINCT n_name
FROM nation, customer,
(SELECT DISTINCT n_name as natName, COUNT(c_name) as count1
              FROM customer, nation
              WHERE c_nationkey = n_nationkey
              GROUP BY n_name) as MainSubQ1,

(SELECT MAX(count2) as maxCount
FROM nation, (SELECT DISTINCT COUNT(c_name) as count2
              FROM customer, nation
              WHERE c_nationkey = n_nationkey
              GROUP BY n_name) as subQ
              ) as MainSubQ2

WHERE
    n_nationkey = c_nationkey AND
    n_name = natName AND
    maxCount = count1
    GROUP by n_name