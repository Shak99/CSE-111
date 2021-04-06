--Q1
SELECT w_warehousekey, w_name, w_capacity, w_suppkey, w_nationkey
FROM warehouse

--Q2
SELECT n_name, COUNT(w_warehousekey), SUM(w_capacity)
FROM nation, warehouse
WHERE
    w_nationkey = n_nationkey
GROUP BY n_name
ORDER BY SUM(w_capacity) DESC

--Q3
SELECT s_name, n2.n_name, w_name
FROM supplier, nation n1, nation n2, warehouse
WHERE
    w_nationkey = n1.n_nationkey AND
    n1.n_name = 'JAPAN' AND
    s_nationkey = n2.n_nationkey AND
    substr(w_name, 1,18) = s_name
    GROUP BY s_name

--Another way of doing 3
SELECT s_name, n_name, w_name
FROM supplier, nation, warehouse
WHERE
    w_nationkey = 12 AND
    w_suppkey = s_suppkey AND
    s_nationkey = n_nationkey
    GROUP BY s_name

--Q4
SELECT w_name, w_capacity
FROM nation, warehouse, region
WHERE
    w_nationkey = n_nationkey AND
    n_regionkey = r_regionkey AND
    r_name = 'ASIA'
    GROUP BY w_name
    HAVING w_capacity > 2000
    ORDER BY w_capacity DESC

--Q5
SELECT DISTINCT r_name, SUM(w_capacity)
FROM region, warehouse, nation n1, nation n2, supplier
WHERE
    s_nationkey = n1.n_nationkey AND
    n1.n_name = 'UNITED STATES' AND
    w_nationkey = n2.n_nationkey AND
    n2.n_regionkey = r_regionkey AND
    s_suppkey = w_suppkey
    GROUP BY r_name
UNION
SELECT DISTINCT r_name, (w_capacity*0) 
FROM region, warehouse
WHERE
    r_name = 'ASIA'






SELECT * FROM testTable



