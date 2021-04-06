
--7. How many orders do customers in every country 
--in EUROPE have in each status? Print the country
--name, the order status, and the count.

SELECT n_name, o_orderstatus, COUNT(o_orderkey)
FROM nation, orders, customer, region
WHERE
    o_custkey = c_custkey AND --
    --o_orderkey = l_orderkey AND 
    c_nationkey = n_nationkey AND
    n_regionkey = r_regionkey AND
    r_name = 'EUROPE'
    GROUP BY n_name, o_orderstatus
    

