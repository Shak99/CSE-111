--2. Find the number of customers that had at most 
--two orders in August 1996 (o orderdate).


SELECT DISTINCT COUNT(c_custkey)
FROM customer,

(SELECT DISTINCT c_custkey as cKey, COUNT(o_orderdate) as oDate
FROM customer, orders
WHERE
    c_custkey = o_custkey AND
    substr(o_orderdate, 1,7) = '1996-08'
    GROUP BY c_custkey) as sub1

WHERE
    c_custkey = cKey AND
    oDate <=2