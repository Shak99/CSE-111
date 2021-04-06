--13. Count the number of orders made in the fourth 
--quarter of 1996 in which at least one item was 
--received by a customer later than its commit date. 
--List the count of such orders for every order 
--priority sorted in ascending priority order.

SELECT o_orderpriority, COUNT(DISTINCT l_orderkey)
FROM orders, customer, lineitem, (SELECT COUNT(DISTINCT l_orderkey) as received
                                  FROM lineitem, orders
                                  WHERE
                                    o_orderkey = l_orderkey AND
                                    o_orderdate >= '1996-10-01' AND
                                    o_orderdate <= '1996-12-31' AND
                                    l_receiptdate > l_commitdate) as subQ
WHERE
    o_orderkey = l_orderkey AND
    c_custkey = o_custkey AND
    o_orderdate >= '1996-10-01' AND
    o_orderdate <= '1996-12-31' AND
    l_receiptdate > l_commitdate AND
    subQ.received >= 1
    GROUP BY o_orderpriority