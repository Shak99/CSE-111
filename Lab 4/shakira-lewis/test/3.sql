
--3. How many orders are made by customers in 
--each country in ASIA?

SELECT n_name, COUNT(*)
FROM nation, customer, orders, region
WHERE
    o_custkey = c_custkey AND
    c_nationkey = n_nationkey AND
    n_regionkey = r_regionkey AND
    r_name = 'ASIA'
    GROUP BY n_name 
