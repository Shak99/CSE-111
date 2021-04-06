
--2. How many suppliers in every region have 
--more balance in their account than the average 
--account balance of their own region?

SELECT r_name, COUNT(DISTINCT s_suppkey)
FROM supplier, nation, region, (SELECT r_name as region, AVG(s_acctbal) as regionAvg
                                FROM supplier, nation, region
                                WHERE
                                    s_nationkey = n_nationkey AND
                                    n_regionkey = r_regionkey
                                    GROUP BY r_name) as subQ
WHERE
    s_nationkey = n_nationkey AND
    n_regionkey = r_regionkey AND
    s_acctbal > subQ.regionAvg AND
    subQ.region = r_name
    GROUP BY r_name