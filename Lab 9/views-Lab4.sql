-- SQLite

--1. Create a view V1(c custkey, c name, c address, c phone, c acctbal, c mktsegment, c comment, c nation,
--c region) that appends the country and region name to every customer. Rewrite Q1 from Lab 4 with
--view V1.
DROP VIEW V1;
DROP VIEW V2;
DROP VIEW V5;
DROP VIEW V10;
DROP VIEW V151;
DROP VIEW V152;


CREATE VIEW V1(c_custkey, c_name, c_address, c_phone, c_acctbal, c_mktsegment, c_comment, c_nation, c_region) AS
	SELECT c_custkey, c_name, c_address, c_phone, c_acctbal, c_mktsegment, c_comment, c_nationkey, n_regionkey
	FROM customer, nation
	WHERE
		c_nationkey = n_nationkey;

--1
select c_name, sum(o_totalprice)
from V1, orders, nation
where o_custkey = c_custkey and
	n_nationkey = c_nation and
	n_name = 'RUSSIA' AND
	o_orderdate like '1996-__-__'
group by c_name;

--2. Create a view V2(s suppkey, s name, s address, s phone, s acctbal, s comment, s nation, s region) that
--appends the country and region name to every supplier. Rewrite Q2 from Lab 4 with view V2.
CREATE VIEW V2(s_suppkey, s_name, s_address, s_phone, s_acctbal, s_comment, s_nation, s_region) AS
	SELECT s_suppkey, s_name, s_address, s_phone, s_acctbal, s_comment, s_nationkey, n_regionkey 
	FROM supplier, nation
	WHERE
		s_nationkey = n_nationkey;

--2
select n_name, count(*)
from V2, nation
where s_nation = n_nationkey
group by n_name;

--3. Rewrite Q3 from Lab 4 with view V1.
select n_name, count(*)
from orders, nation, V1, region
where c_custkey = o_custkey and
	c_nation = n_nationkey AND
	n_regionkey = r_regionkey AND
	r_name = 'ASIA'
group by n_name;

--4. Rewrite Q4 from Lab 4 with view V2.
select s_name, count(*)
from partsupp, V2, nation, part
where p_partkey = ps_partkey
	and p_size < 30 
	and ps_suppkey = s_suppkey 
	and s_nation = n_nationkey 
	and n_name = 'CHINA'
group by s_name;


--5. Create a view V5(o orderkey, o custkey, o orderstatus, o totalprice, o orderyear, o orderpriority, o clerk,
--o shippriority, o comment) that replaces o orderdate with the year o orderyear and contains all the
--other attributes in orders. Rewrite Q5 from Lab 4 with views V1 and V5.
CREATE VIEW V5(o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderyear, o_orderpriority, o_clerk, o_shippriority, o_comment) AS
	SELECT * FROM orders

--5
select count(*)
from V5, V1, nation
where o_custkey = c_custkey 
	and c_nation = n_nationkey
	and n_name = 'PERU' 
	and o_orderyear like '1996-__-__';

--6. Rewrite Q6 from Lab 4 with view V5.
select s_name, o_orderpriority, count(*)
from partsupp, V5, lineitem, supplier, region, nation
where ps_partkey = l_partkey 
	and ps_suppkey = l_suppkey
	and l_orderkey = o_orderkey
	and ps_suppkey = s_suppkey
	and s_nationkey = n_nationkey
	and n_regionkey = r_regionkey
	and r_name = 'AMERICA'
group by s_name, o_orderpriority;

--7. Rewrite Q7 from Lab 4 with views V1 and V5.
select n_name, o_orderstatus, count(*)
from V5, V1, nation, region
where o_custkey = c_custkey 
	and c_nation = n_nationkey
	and n_regionkey = r_regionkey
	and r_name = 'EUROPE'
group by n_name, o_orderstatus;

--8. Rewrite Q8 from Lab 4 with views V2 and V5.
select n_name, count(distinct o_orderkey) as tot_orders
from V5, nation, V2, lineitem
where o_orderyear like '1994%'
	and o_orderstatus = 'F'
	and o_orderkey = l_orderkey 
	and l_suppkey = s_suppkey
	and s_nation = n_nationkey
group by n_name
having tot_orders > 300;

--9. Rewrite Q9 from Lab 4 with views V2 and V5.
select count(DISTINCT o_clerk)
from V5, V2, nation, lineitem
where o_orderkey = l_orderkey 
	and l_suppkey = s_suppkey 
	and s_nation = n_nationkey 
	and n_name = 'CANADA';

--10. Create a view V10(p type, avg discount) that computes the average discount for every type of part.
CREATE VIEW V10(p_type, avg_discount) AS
	SELECT p_type, AVG(l_discount)
	FROM part, lineitem
	WHERE
		p_partkey = l_partkey
		GROUP BY p_type;
--Rewrite Q10 from Lab 4 with view V10.
select p_type, avg_discount
from V10
where p_type like '%PROMO%'
group by p_type;


--11. Rewrite Q11 from Lab 4 with view V2.
select n_name, s_name, s_acctbal
from V2 s, nation n
where s_nation = n_nationkey
	and s_acctbal = 
		(select max(s_acctbal)
		from V2 s1
		where s.s_nation = s1.s_nation
		)GROUP BY n_name;

--12. Rewrite Q12 from Lab 4 with view V2.
select n_name, avg(s_acctbal)
from V2, nation
where s_nation = n_nationkey
group by n_name;

--13. Rewrite Q13 from Lab 4 with views V1 and V2.
select count(*)
from orders, lineitem, V1
where o_orderkey = l_orderkey
	and o_custkey = c_custkey
	and l_suppkey in (
		select s_suppkey
		from V2, nation, region
		where s_nation = n_nationkey
			and n_regionkey = r_regionkey
			and r_name = 'ASIA'
		)
	and c_custkey in (
		select c_custkey
		from V1, nation
		where c_nation = n_nationkey
			and n_name = 'ARGENTINA'
		);

--14. Rewrite Q14 from Lab 4 with views V1 and V2.
select custRegion, suppRegion, count(*) as no
from
	orders
	join
	(select o_orderkey as custOrder, r_name as custRegion
	from orders, nation, region, V1
	where o_custkey = c_custkey
		and c_nation = n_nationkey
		and n_regionkey = r_regionkey
	) on o_orderkey = custOrder
	join
	(select l_orderkey as suppOrder, r_name as suppRegion
	from lineitem, region, nation, V2
	where l_suppkey = s_suppkey
		and s_nation = n_nationkey
		and n_regionkey = r_regionkey
	) on o_orderkey = suppOrder
group by custRegion, suppRegion;

--15. Create two views V151(c custkey, c name, c nationkey, c acctbal) and V152(s suppkey, s name, s nationkey,
--s acctbal) that contain the customers and suppliers with negative balance, respectively. Rewrite Q15
--from Lab 4 with views V151 and V152.
CREATE VIEW V151(c_custkey, c_name, c_nationkey, c_acctbal) AS
	SELECT c_custkey, c_name, c_nationkey, c_acctbal
	FROM customer;

CREATE VIEW V152(s_suppkey, s_name, s_nationkey, s_acctbal) AS
	SELECT s_suppkey, s_name, s_nationkey, s_acctbal
	FROM supplier;

select count(DISTINCT o_orderkey)
from orders, lineitem
where o_orderkey = l_orderkey
	and o_custkey in
		(select c_custkey
		from customer
		where c_acctbal < 0)
	and l_suppkey in
		(select s_suppkey
		from V152
		where s_acctbal < 0);



