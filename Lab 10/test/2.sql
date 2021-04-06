--2. Create a trigger t2 that sets a warning Negative balance!!! in the comment attribute of the
--customer table every time c acctbal is updated to a negative value from a positive one. Write a
--SQL statement that sets the balance to -100 for all the customers in EUROPE. Write a query that
--returns the number of customers with negative balance from FRANCE. Put all the SQL statements in
--le test/2.sql.

/*
SELECT COUNT(c_custkey)
FROM customer, nation
WHERE
    c_nationkey = n_nationkey AND
    n_name = 'FRANCE' AND
    c_acctbal < 0
    */

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

SELECT COUNT(c_custkey)
FROM customer, nation
WHERE
    c_nationkey = n_nationkey AND
    n_name = 'FRANCE' AND
    c_acctbal < 0
