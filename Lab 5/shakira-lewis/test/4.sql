--4. How many customers and suppliers are in 
--every country from EUROPE?

SELECT n_name, COUNT(DISTINCT c_custkey), COUNT(DISTINCT s_suppkey)
FROM customer, supplier, nation
WHERE
    c_nationkey = n_nationkey AND
    s_nationkey = n_nationkey AND
    n_regionkey = 3
    GROUP BY n_name
