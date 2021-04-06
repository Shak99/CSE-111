.eqp ON
--.timer ON
--.output out.res.index

--.expert


--1
create index customer_idx_c_name on customer(c_name);

--2 
create index supplier_idx_s_acctbal on supplier(s_acctbal);

--3 
create index lineitem_idx_l_returnflag_l_receiptdate on lineitem(l_returnflag, l_receiptdate);

--4 
create index customer_idx_c_mktsegment on customer(c_mktsegment);

--5 
create index orders_idx_o_orderdate on orders(o_orderdate);
create index customer_idx_c_custkey on customer(c_custkey);

--6 
create index orders_idx_o_custkey_o_orderkey on orders(o_custkey, o_orderkey);
create index customer_idx_c_name_c_custkey on customer(c_name, c_custkey);

--7 
create index region_idx_r_name_r_regionkey on region(r_name, r_regionkey);
create index supplier_idx_s_nationkey_s_acctbal on supplier(s_nationkey, s_acctbal);
create index nation_idx_n_regionkey_n_nationkey on nation(n_regionkey, n_nationkey);

--8 
create index nation_idx_n_name_n_nationkey on nation(n_name, n_nationkey);

--9 
create index customer_idx_c_nationkey_c_custkey on customer(c_nationkey, c_custkey);

--10 
create index lineitem_idx_l_orderkey_l_discount on lineitem(l_orderkey, l_discount);

--11
create index lineitem_idx_l_orderkey_l_receiptdate on lineitem(l_orderkey, l_receiptdate);

--12 
create index orders_idx_o_orderstatus on orders(o_orderstatus);

--13
create index region_idx_r_regionkey_r_name on region(r_regionkey, r_name);

--14 
create index orders_idx_o_orderpriority_o_orderkey on orders(o_orderpriority, o_custkey);

--15 
create index supplier_idx_s_suppkey on supplier(s_suppkey);
create index nation_idx_n_nationkey on nation(n_nationkey);