
--14. List the total number of orders between any 
--two regions, i.e., the suppliers are from one 
--region and the customers are from another region.

SELECT DISTINCT reg2.r_name, reg1.r_name, COUNT(o_orderkey)
FROM nation nat1, nation nat2, region reg1, region reg2,--2 duplicate/separate tables for both nation and region
     lineitem, orders, supplier, customer
WHERE
    l_suppkey = s_suppkey AND
    l_orderkey = o_orderkey AND
    o_custkey = c_custkey AND
    --s_nationkey = c_nationkey AND

    s_nationkey = nat1.n_nationkey AND--supplier
    nat1.n_regionkey = reg1.r_regionkey AND

    c_nationkey = nat2.n_nationkey AND --customer
    nat2.n_regionkey = reg2.r_regionkey

    GROUP BY reg2.r_name, reg1.r_name
