--7. For every order priority, count the number of 
--parts ordered in 1996 and received later 
--(l receiptdate) than the commit date 
--(l commitdate). List the results in descending 
--priority order."

SELECT o_orderpriority, COUNT(p_partkey)
FROM orders, lineitem, part
WHERE
    o_orderkey = l_orderkey AND --
    p_partkey = l_partkey AND
    substr(o_orderdate, 1, 4) = '1996' AND --
    l_receiptdate > l_commitdate --
    GROUP BY o_orderpriority --
    ORDER BY o_orderpriority DESC --
