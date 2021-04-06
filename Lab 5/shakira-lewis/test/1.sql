
--1. How many customers are not from EUROPE or AFRICA?

SELECT COUNT(c_name)
FROM customer, nation, region
WHERE
    c_nationkey = n_nationkey AND
    n_regionkey = r_regionkey AND
    --(r_name != 'EUROPE' AND r_name != 'AFRICA')
    (n_regionkey NOT IN ('0') AND
    n_regionkey NOT IN ('3'))

