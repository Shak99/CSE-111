--4. Create triggers that update the attribute o orderpriority to HIGH every time a new lineitem tuple
--is added to or deleted from that order. Delete all the line items corresponding to orders from November
--1996. Write a query that returns the number of HIGH priority orders in the fourth trimester of 1996.
--Put all the SQL statements in le test/4.sql.
/*
SELECT COUNT(o_orderkey)
FROM orders
WHERE
    o_orderpriority = 'HIGH' AND
    o_orderdate <= '1996-10-01' AND
    o_orderdate >='1996-12-31'
    --wrong
*/
/*
CREATE TRIGGER number4insert
  AFTER
  INSERT
  ON lineitem
  FOR EACH ROW
BEGIN
  UPDATE orders
  SET o_orderpriority = '2-HIGH'
  WHERE o_orderkey = old.l_orderkey;
END;

CREATE TRIGGER number4delete
  AFTER
  DELETE
  ON lineitem
  FOR EACH ROW
BEGIN
  UPDATE orders
  SET o_orderpriority = '2-HIGH'
  WHERE o_orderkey = old.l_orderkey;
END;


DELETE FROM lineitem
WHERE l_orderkey IN (SELECT o_orderkey
                    FROM orders
                    WHERE strftime('%m-%Y', o_orderdate) = '11-1996');


SELECT COUNT(o_orderkey)
FROM orders
WHERE o_orderpriority LIKE '2%' AND o_orderdate like '1996-11%';*/

update orders
set o_orderpriority = 'HIGH';

delete from lineitem
where l_orderkey in (select o_orderkey from orders where o_orderdate like '%1996-11%');

SELECT count(o_orderpriority)
from orders
where o_orderdate like '%1996-11%';
end;
