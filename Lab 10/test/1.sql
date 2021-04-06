SELECT COUNT(o_orderkey)
FROM orders
WHERE
    o_orderdate >= '2020-01-01' AND 
    o_orderdate <= '2020-12-31';
