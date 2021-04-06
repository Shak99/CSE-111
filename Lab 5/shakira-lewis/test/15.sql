--15. The market share for a given nation within a 
--given region is defined as the fraction of the 
--revenue from the line items ordered by customers 
--in the given region that are supplied by suppliers from 
--the given nation. The revenue of a line item is 
--defined as l extendedprice*(1-l discount). 
--Determine the market share of UNITED STATES in 
--EUROPE in 1996 (l shipdate).


SELECT (numerator/denomintator)
FROM

    (SELECT SUM(l_extendedprice*(1-l_discount)) as numerator
    FROM lineitem, orders, customer, supplier,
         nation nat1, nation nat2
    WHERE
        l_orderkey = o_orderkey AND --
        c_custkey = o_custkey AND --
        l_suppkey = s_suppkey AND --
        c_nationkey = nat1.n_nationkey AND --
        nat1.n_regionkey = 3 AND --
        s_nationkey = nat2.n_nationkey AND
        nat2.n_name = "UNITED STATES" AND --
        substr(l_shipdate, 1, 4) = '1996' --
    ) as Q1,

    (SELECT SUM(l_extendedprice*(1-l_discount)) as denomintator
    FROM lineitem, orders, customer, nation, region
    WHERE
        l_orderkey = o_orderkey AND --
        c_custkey = o_custkey AND --
        substr(l_shipdate, 1, 4) = '1996' AND
        c_nationkey = n_nationkey AND
        n_regionkey = 3 AND
        n_regionkey = r_regionkey
    ) as Q2

