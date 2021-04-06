

--4. What is the average completion time in number 
--of days (from commit date to ship date) for an order 
--for which ship date is larger than or equal to commit 
--date? Check the julianday function from SQLite.

SELECT AVG(julianday(l_shipdate) - julianday(l_commitdate))
FROM lineitem
WHERE l_commitdate <= l_shipdate


