--3. Create a trigger t3 that resets the comment to Positive balance if the balance goes back positive
--from negative. Write a SQL statement that sets the balance to 100 for all the customers in ROMANIA.
--Write a query that returns the number of customers with negative balance from EUROPE. Put all the
--SQL statements in le test/3.sql.
/*
CREATE TRIGGER number2negbal AFTER UPDATE ON customer
FOR EACH ROW
BEGIN
UPDATE customer
SET c_comment = 'Negative balance!!!'
WHERE 
    old.c_acctbal >= 0 AND 
    new.c_acctbal < 0 AND 
    c_acctbal = new.c_acctbal;
END;


CREATE TRIGGER number2posbal
AFTER UPDATE ON customer
BEGIN
UPDATE customer
SET c_comment = ''
WHERE 
    old.c_acctbal < 0 AND 
    new.c_acctbal >= 0 AND 
    c_acctbal = new.c_acctbal;
END;



UPDATE customer
SET c_acctbal = -100
WHERE c_nationkey IN (SELECT n_nationkey
                      FROM nation,
                           region
                      WHERE n_regionkey = r_regionkey
                        AND r_regionkey = 3);





SELECT COUNT(DISTINCT c_custkey)
FROM customer, nation, region
WHERE
    c_nationkey = n_nationkey AND
    n_regionkey = 3 AND
    c_acctbal < 0

    */
UPDATE customer
SET c_comment = 'Positive Balance. You are good to go';

select *
from customer, nation
where c_nationkey = n_nationkey and n_name = 'EUROPE' and c_acctbal < 0;

UPDATE customer
SET c_acctbal = 100
WHERE c_nationkey IN (select n_nationkey from nation where n_name = 'ROMANIA');

SELECT count(c_name)
from customer, nation, region
where c_nationkey = n_nationkey and n_regionkey = r_regionkey and r_name = 'EUROPE' and c_acctbal < 0;
