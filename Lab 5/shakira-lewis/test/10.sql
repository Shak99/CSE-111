--10. How many customers from every region have never 
--placed an order and have more than the average
--account balance?

SELECT r_name, COUNT(c_custkey)
FROM customer, region, nation
WHERE 
    c_nationkey = n_nationkey AND
    n_regionkey = r_regionkey AND 
    c_custkey NOT IN (SELECT c_custkey 
                      FROM orders, customer 
                      WHERE c_custkey = o_custkey) AND 
    c_acctbal > (SELECT AVG(c_acctbal) FROM customer)
GROUP BY r_name;