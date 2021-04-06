--1. Find the total quantity (l quantity) of line 
--items shipped per month (l shipdate) in 1997. 
--Hint: check function strftime to extract the 
--month/year from a date.

SELECT DISTINCT strftime('%m', l_shipdate), SUM(l_quantity)
FROM lineitem
WHERE
    substr(l_shipdate, 1, 4) = '1997'
    GROUP by strftime('%m', l_shipdate)

    