
--7. What is the receipt date and the total number of 
--ordered items per receipt date by Customer#000000106?

SELECT lineitem.l_receiptdate as RecieptDate, COUNT(lineitem.l_linenumber) as NumOfItems
FROM customer, orders, lineitem
WHERE 
    customer.c_name = 'Customer#000000106' AND
    customer.c_custkey = orders.o_custkey AND
    orders.o_orderkey = lineitem.l_orderkey
GROUP BY lineitem.l_receiptdate

