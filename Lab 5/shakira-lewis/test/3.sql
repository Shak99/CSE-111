
--3. For the line items ordered in May 1995 
--(o_orderdate), and the largest discount that 
--is less than the average discount among all the orders.

SELECT MAX(l_discount)
FROM orders, lineitem, (SELECT AVG(l_discount) as avg1
                        FROM orders, lineitem
                        WHERE
                            o_orderkey = l_orderkey AND
                            o_orderdate >= '1995-05-01' AND
                            o_orderdate <= '1995-05-31') as subQ
WHERE
    o_orderkey = l_orderkey AND
    subQ.avg1 > l_discount 



