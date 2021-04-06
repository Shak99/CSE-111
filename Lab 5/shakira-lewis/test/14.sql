--14.For any two regions, and the gross discounted revenue 
--(l extendedprice*(1-l discount)) derived from line items 
--in which parts are shipped from a supplier in the first region 
--to a customer in the second region in 1995 and 1996. List 
--the supplier region, the customer region, the year 
--(l shipdate), and the revenue from shipments that took place 
--in that year. Order the answers by supplier region, customer 
--region, and year.

SELECT reg1.r_name, reg2.r_name, substr(l_shipdate, 1, 4), SUM(l_extendedprice*(1-l_discount))
FROM nation nat1, nation nat2, region reg1, region reg2,
     lineitem, supplier, customer, orders
WHERE
    (substr(l_shipdate, 1, 4) = '1995' OR
    substr(l_shipdate, 1, 4) = '1996') AND
    l_suppkey = s_suppkey AND
    o_custkey = c_custkey AND
    o_orderkey = l_orderkey AND

     s_nationkey = nat1.n_nationkey AND--supplier
    nat1.n_regionkey = reg1.r_regionkey AND

    c_nationkey = nat2.n_nationkey AND --customer
    nat2.n_regionkey = reg2.r_regionkey

    GROUP BY reg1.r_name, reg2.r_name, substr(l_shipdate, 1, 4)
    ORDER BY reg1.r_name, reg2.r_name, substr(l_shipdate, 1, 4) ASC

