
--10. Find the average discount for every part 
--having PROMO in its type.

SELECT DISTINCT p_type, AVG(l_discount)
FROM lineitem, part
WHERE
    substr(p_type, 1,5) = 'PROMO' AND
    p_partkey = l_partkey
GROUP BY p_type