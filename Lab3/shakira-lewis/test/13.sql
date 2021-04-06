


--13. Find the average account balance of all the 
--customers from AFRICA in the MACHINERY market segment.

SELECT AVG(customer.c_acctbal) as "Avg of Africa"
FROM customer, nation, region
WHERE 
    customer.c_mktsegment = 'MACHINERY' AND
    customer.c_nationkey = nation.n_nationkey AND
    nation.n_regionkey = region.r_regionkey AND
    region.r_name = 'AFRICA';