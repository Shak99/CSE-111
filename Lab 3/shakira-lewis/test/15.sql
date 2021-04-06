

--Find the total number of 1-URGENT priority orders 
--supplied by suppliers in each region each year
--(from o orderdate). Print the year, region name, 
--and the count sorted by the year then the region in
--increasing order. Check the substr function in SQLite.

SELECT DISTINCT substr(orders.o_orderdate, 1,4), region.r_name, COUNT(orders.o_orderpriority)
FROM orders, region, nation, supplier, lineitem
WHERE 
    orders.o_orderpriority = '1-URGENT' AND --
    lineitem.l_orderkey = orders.o_orderkey AND --
    supplier.s_nationkey = nation.n_nationkey AND --
    nation.n_regionkey = region.r_regionkey AND --
    supplier.s_suppkey = lineitem.l_suppkey --
    GROUP BY substr(orders.o_orderdate, 1,4), region.r_name




