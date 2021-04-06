// STEP: Import required packages
import java.sql.*;
import java.io.FileWriter;
import java.io.PrintWriter;

public class Lab_9 {
    private Connection c = null;
    private String dbName;
    private boolean isConnected = false;

    private void openConnection(String _dbName) {
        dbName = _dbName;

        if (false == isConnected) {
            System.out.println("++++++++++++++++++++++++++++++++++");
            System.out.println("Open database: " + _dbName);

            try {
                String connStr = new String("jdbc:sqlite:");
                connStr = connStr + _dbName;

                // STEP: Register JDBC driver
                Class.forName("org.sqlite.JDBC");

                // STEP: Open a connection
                c = DriverManager.getConnection(connStr);

                // STEP: Diable auto transactions
                c.setAutoCommit(false);

                isConnected = true;
                System.out.println("success");
            } catch (Exception e) {
                System.err.println(e.getClass().getName() + ": " + e.getMessage());
                System.exit(0);
            }

            System.out.println("++++++++++++++++++++++++++++++++++");
        }
    }

    private void closeConnection() {
        if (true == isConnected) {
            System.out.println("++++++++++++++++++++++++++++++++++");
            System.out.println("Close database: " + dbName);

            try {
                // STEP: Close connection
                c.close();

                isConnected = false;
                dbName = "";
                System.out.println("success");
            } catch (Exception e) {
                System.err.println(e.getClass().getName() + ": " + e.getMessage());
                System.exit(0);
            }

            System.out.println("++++++++++++++++++++++++++++++++++");
        }
    }

    private void create_View1() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Create V1");

        try {
            Statement stmt = c.createStatement();

            //STEP: Execute Update Statement
            String sql = "CREATE VIEW V1(c_custkey, c_name, c_address, c_phone, c_acctbal, c_mktsegment, c_comment, c_nation, c_region) AS " +
            "SELECT c_custkey, c_name, c_address, c_phone, c_acctbal, c_mktsegment, c_comment, c_nationkey, n_regionkey " +
            "FROM customer, nation " +
            "WHERE " +
                "c_nationkey = n_nationkey;";
            stmt.execute(sql);

            //STEP: Commit Transaction
            c.commit();

            stmt.close();
            System.out.println("success");
        } catch(Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
            try {
                c.rollback();
            } catch (Exception e1) {
                System.err.println(e1.getClass().getName() + ": " + e1.getMessage());
            }
            
        }

        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    private void Q1() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Q1");

        try {
            FileWriter writer = new FileWriter("output/1.out", false);
            PrintWriter printer = new PrintWriter(writer);

            String sql = "select c_name as cName, sum(o_totalprice) as tot " +
            "from V1, orders, nation " +
            "where o_custkey = c_custkey and " +
                "n_nationkey = c_nation and " +
                "n_name = 'RUSSIA' AND " +
                "o_orderdate like '1996-__-__' " +
            "group by c_name;";

            PreparedStatement stmt = c.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
                
            //printer.printf("%10s %-40s\n", "cName", "tot");
            
            while(rs.next()){
                String name = rs.getString("cName");
                String totPrice = rs.getString("tot");
                printer.printf("%-40s|%-40s\n", name, totPrice);
            }

            rs.close();
            stmt.close(); 
            printer.close();
            writer.close();
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
        }

        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    private void create_View2() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Create V2");

        try {
            Statement stmt = c.createStatement();

            //STEP: Execute Update Statement
            String sql = "CREATE VIEW V2(s_suppkey, s_name, s_address, s_phone, s_acctbal, s_comment, s_nation, s_region) AS " +
            "SELECT s_suppkey, s_name, s_address, s_phone, s_acctbal, s_comment, s_nationkey, n_regionkey " +
            "FROM supplier, nation " +
            "WHERE " +
                "s_nationkey = n_nationkey;";
            stmt.execute(sql);

            //STEP: Commit Transaction
            c.commit();

            stmt.close();
            System.out.println("success");
        } catch(Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
            try {
                c.rollback();
            } catch (Exception e1) {
                System.err.println(e1.getClass().getName() + ": " + e1.getMessage());
            }
            
        }

        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    private void Q2() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Q2");

        try {
            FileWriter writer = new FileWriter("output/2.out", false);
            PrintWriter printer = new PrintWriter(writer);

            String sql = "select n_name as nName, count(*) as cnt " +
            "from V2, nation " +
            "where s_nation = n_nationkey " +
            "group by n_name;";

            PreparedStatement stmt = c.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
                
            //printer.printf("%40s %-10s\n", "nName", "cnt");

            
            while(rs.next()){
                String name = rs.getString("nName");
                int count = rs.getInt("cnt");
                printer.printf("%-40s|%10d\n", name, count);
            }
               
            rs.close();
            stmt.close();
            printer.close();
            writer.close();
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
        }

        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    private void Q3() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Q3");

        try {
            FileWriter writer = new FileWriter("output/3.out", false);
            PrintWriter printer = new PrintWriter(writer);

            String sql = "select n_name as nName, count(*) as cnt " +
            "from orders, nation, V1, region " +
            "where c_custkey = o_custkey and " +
                "c_nation = n_nationkey AND " +
                "n_regionkey = r_regionkey AND " +
                "r_name = 'ASIA' " +
            "group by n_name;";

            PreparedStatement stmt = c.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
                
            //printer.printf("%-40s %10s\n", "nName", "cnt");

            
            while(rs.next()){
                String name = rs.getString("nName");
                int count = rs.getInt("cnt");
                printer.printf("%-40s|%10d\n", name, count);
            }

            rs.close();
            stmt.close();
            printer.close();
            writer.close();
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
        }

        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    private void Q4() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Q4");

        try {
            FileWriter writer = new FileWriter("output/4.out", false);
            PrintWriter printer = new PrintWriter(writer);
            
            String sql = "select s_name as sName, count(*) as cnt " +
            "from partsupp, V2, nation, part " +
            "where p_partkey = ps_partkey " +
                "and p_size < 30 " +
                "and ps_suppkey = s_suppkey " +
                "and s_nation = n_nationkey " +
                "and n_name = 'CHINA' " +
            "group by s_name;";

            PreparedStatement stmt = c.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
                
            //printer.printf("%-40s %40s\n", "sName", "cnt");

            
            while(rs.next()){
                String name = rs.getString("sName");
                int count = rs.getInt("cnt");
                printer.printf("%-40s|%10d\n", name, count);
            }

            rs.close();
            stmt.close();
            printer.close();
            writer.close();
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
        }

        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    private void create_View5() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Create V5");
        try {
            Statement stmt = c.createStatement();

            String sql = "CREATE VIEW V5(o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderyear, o_orderpriority, o_clerk, o_shippriority, o_comment) AS " +
            "SELECT * FROM orders";
            stmt.execute(sql);

            //STEP: Commit Transaction
            c.commit();

            stmt.close();
            System.out.println("success");
        } catch(Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
            try {
                c.rollback();
            } catch (Exception e1) {
                System.err.println(e1.getClass().getName() + ": " + e1.getMessage());
            }
            
        }

        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    private void Q5() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Q5");

        try {
            FileWriter writer = new FileWriter("output/5.out", false);
            PrintWriter printer = new PrintWriter(writer);

            String sql = "select count(*) as cnt " +
            "from V5, V1, nation " +
            "where o_custkey = c_custkey " +
                "and c_nation = n_nationkey " +
                "and n_name = 'PERU' " +
                "and o_orderyear like '1996-__-__';";

            PreparedStatement stmt = c.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
                
            //printer.printf("%10s\n", "cnt");

            
            while(rs.next()){
                int count = rs.getInt("cnt");
                printer.printf("%-10d\n", count);
            }

            rs.close();
            stmt.close();
            printer.close();
            writer.close();
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
        }

        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    private void Q6() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Q6");

        try {
            FileWriter writer = new FileWriter("output/6.out", false);
            PrintWriter printer = new PrintWriter(writer);
            String sql = "select s_name as sName, o_orderpriority as prior, count(*) as cnt " +
            "from partsupp, V5, lineitem, supplier, region, nation  " +
            "where ps_partkey = l_partkey " +
                "and ps_suppkey = l_suppkey " +
                "and l_orderkey = o_orderkey " +
                "and ps_suppkey = s_suppkey " +
                "and s_nationkey = n_nationkey " +
                "and n_regionkey = r_regionkey " +
                "and r_name = 'AMERICA' " +
            "group by s_name, o_orderpriority;";

            PreparedStatement stmt = c.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
                
            //printer.printf("%-40s %-40s %10s\n", "sName", "prior", "cnt");

            
            while(rs.next()){
                String name = rs.getString("sName");
                String priority = rs.getString("prior");
                int count = rs.getInt("cnt");
                printer.printf("%-40s|%-40s|%10d\n", name, priority, count);
            }

            rs.close();
            stmt.close();
            printer.close();
            writer.close();
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
        }

        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    private void Q7() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Q7");

        try {
            FileWriter writer = new FileWriter("output/7.out", false);
            PrintWriter printer = new PrintWriter(writer);

            String sql = "select n_name as nName, o_orderstatus as stat, count(*) as cnt " +
            "from V5, V1, nation, region " +
            "where o_custkey = c_custkey " +
                "and c_nation = n_nationkey " +
                "and n_regionkey = r_regionkey " +
                "and r_name = 'EUROPE' " +
            "group by n_name, o_orderstatus;";

            PreparedStatement stmt = c.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
                
            //printer.printf("%-40s %10s\n", "nName", "cnt");

            
            while(rs.next()){
                String name = rs.getString("nName");
                String status = rs.getString("stat");
                int count = rs.getInt("cnt");
                printer.printf("%-40s|%40s|%10d\n", name, status, count);
            }

            rs.close();
            stmt.close();
            printer.close();
            writer.close();
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
        }

        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    private void Q8() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Q8");

        try {
            FileWriter writer = new FileWriter("output/8.out", false);
            PrintWriter printer = new PrintWriter(writer);

            String sql = "select n_name as nName, count(distinct o_orderkey) as tot_orders " +
            "from V5, nation, V2, lineitem " +
            "where o_orderyear like '1994%' " +
                "and o_orderstatus = 'F' " +
                "and o_orderkey = l_orderkey " +
                "and l_suppkey = s_suppkey " +
                "and s_nation = n_nationkey " +
            "group by n_name " +
            "having tot_orders > 300;";

            PreparedStatement stmt = c.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
                
            //printer.printf("%10s %-40s\n", "sName", "cnt");

            
            while(rs.next()){
                String name = rs.getString("nName");
                int tot = rs.getInt("tot_orders");
                printer.printf("%-40s|%10d\n", name, tot);
            }

            rs.close();
            stmt.close();
            printer.close();
            writer.close();
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
        }

        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    private void Q9() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Q9");

        try {
            FileWriter writer = new FileWriter("output/9.out", false);
            PrintWriter printer = new PrintWriter(writer);

            String sql = "select count(DISTINCT o_clerk) as cnt " +
            "from V5, V2, nation, lineitem " +
            "where o_orderkey = l_orderkey " +
                "and l_suppkey = s_suppkey " +
                "and s_nation = n_nationkey " +
                "and n_name = 'CANADA';";

            PreparedStatement stmt = c.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
                
            //printer.printf("%10s %-40s\n", "sName", "cnt");

            
            while(rs.next()){
                int count = rs.getInt("cnt");
                printer.printf("%-10d\n", count);
            }

            rs.close();
            stmt.close();
            printer.close();
            writer.close();
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
        }

        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    private void create_View10() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Create V10");

        try {
            Statement stmt = c.createStatement();

            String sql = "CREATE VIEW V10(p_type, avg_discount) AS " +
            "SELECT p_type, AVG(l_discount) " +
            "FROM part, lineitem " +
            "WHERE " +
                "p_partkey = l_partkey " +
                "GROUP BY p_type;";
            stmt.execute(sql);

            //STEP: Commit Transaction
            c.commit();

            stmt.close();
            System.out.println("success");
        } catch(Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
            try {
                c.rollback();
            } catch (Exception e1) {
                System.err.println(e1.getClass().getName() + ": " + e1.getMessage());
            }
            
        }

        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    private void Q10() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Q10");

        try {
            FileWriter writer = new FileWriter("output/10.out", false);
            PrintWriter printer = new PrintWriter(writer);

            String sql = "select p_type as type, avg_discount as dis " +
            "from V10 " +
            "where p_type like '%PROMO%' " +
            "group by p_type;";

            PreparedStatement stmt = c.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
                
            //printer.printf("%10s %-40s\n", "sName", "cnt");

            
            while(rs.next()){
                String type = rs.getString("type");
                String discount = rs.getString("dis");
                printer.printf("%-40s|%40s\n", type, discount);
            }

            rs.close();
            stmt.close();
            printer.close();
            writer.close();
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
        }

        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    private void Q11() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Q11");

        try {
            FileWriter writer = new FileWriter("output/11.out", false);
            PrintWriter printer = new PrintWriter(writer);

            String sql = "select n_name as nName, s_name as sName, s_acctbal as acct " +
            "from V2 s, nation n " +
            "where s_nation = n_nationkey " +
                "and s_acctbal = " +
                    "(select max(s_acctbal) " +
                    "from V2 s1 " +
                    "where s.s_nation = s1.s_nation " +
                    ")GROUP BY n_name;";

            PreparedStatement stmt = c.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
                
            //printer.printf("%-40s %-40s\n", "nName", "sName", "acct");

            
            while(rs.next()){
                String nation = rs.getString("nName");
                String supplier = rs.getString("sName");
                String account = rs.getString("acct");
                printer.printf("%-40s|%-40s|%-40s\n", nation, supplier, account);
            }

            rs.close();
            stmt.close();
            printer.close();
            writer.close();
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
        }

        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    private void Q12() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Q12");

        try {
            FileWriter writer = new FileWriter("output/12.out", false);
            PrintWriter printer = new PrintWriter(writer);

            String sql = "select n_name as nName, avg(s_acctbal) as bal " +
            "from V2, nation " +
            "where s_nation = n_nationkey " +
            "group by n_name;";

            PreparedStatement stmt = c.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
                
            //printer.printf("%10s %-40s\n", "sName", "cnt");

            
            while(rs.next()){
                String name = rs.getString("nName");
                String balance = rs.getString("bal");
                printer.printf("%-40s|%40s\n", name, balance);
            }

            rs.close();
            stmt.close();
            printer.close();
            writer.close();
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
        }

        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    private void Q13() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Q13");

        try {
            FileWriter writer = new FileWriter("output/13.out", false);
            PrintWriter printer = new PrintWriter(writer);

            String sql = "select count(*) as cnt " +
            "from orders, lineitem, V1 " +
            "where o_orderkey = l_orderkey " +
                "and o_custkey = c_custkey " +
                "and l_suppkey in ( " +
                    "select s_suppkey " +
                    "from V2, nation, region " +
                    "where s_nation = n_nationkey " +
                        "and n_regionkey = r_regionkey " +
                        "and r_name = 'ASIA' " +
                    ") " +
                "and c_custkey in ( " +
                    "select c_custkey " +
                    "from V1, nation " +
                    "where c_nation = n_nationkey " +
                        "and n_name = 'ARGENTINA' " +
                    ");";

            PreparedStatement stmt = c.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
                
            //printer.printf("%-10d\n", "cnt");

            
            while(rs.next()){
                int count = rs.getInt("cnt");
                printer.printf("%-10d\n", count);
            }

            rs.close();
            stmt.close();
            printer.close();
            writer.close();
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
        }

        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    private void Q14() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Q14");

        try {
            FileWriter writer = new FileWriter("output/14.out", false);
            PrintWriter printer = new PrintWriter(writer);

            String sql = "select custRegion as cRegion, suppRegion as sRegion, count(*) as no " +
            "from " +
                "orders " +
                "join " +
                "(select o_orderkey as custOrder, r_name as custRegion " +
                "from orders, nation, region, V1 " +
                "where o_custkey = c_custkey " +
                    "and c_nation = n_nationkey " +
                    "and n_regionkey = r_regionkey " +
                ") on o_orderkey = custOrder " +
                "join " +
                "(select l_orderkey as suppOrder, r_name as suppRegion " +
                "from lineitem, region, nation, V2 " +
                "where l_suppkey = s_suppkey " +
                    "and s_nation = n_nationkey " +
                    "and n_regionkey = r_regionkey " +
                ") on o_orderkey = suppOrder " +
            "group by custRegion, suppRegion;";

            PreparedStatement stmt = c.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
                
            //printer.printf("%10s %-40s\n", "sName", "cnt");

            
            while(rs.next()){
                String cust = rs.getString("cRegion");
                String supp = rs.getString("sRegion");
                int count = rs.getInt("no");
                printer.printf("%-40s|%40s|%10d\n", cust, supp, count);
            }

            rs.close();
            stmt.close();
            printer.close();
            writer.close();
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
        }

        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    private void create_View151() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Create V151");

        try {
            Statement stmt = c.createStatement();

            //STEP: Execute Update Statement
            String sql = "CREATE VIEW V151(c_custkey, c_name, c_nationkey, c_acctbal) AS " +
            "SELECT c_custkey, c_name, c_nationkey, c_acctbal " +
            "FROM customer;";
            stmt.execute(sql);

            //STEP: Commit Transaction
            c.commit();

            stmt.close();
            System.out.println("success");
        } catch(Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
            try {
                c.rollback();
            } catch (Exception e1) {
                System.err.println(e1.getClass().getName() + ": " + e1.getMessage());
            }
            
        }

        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    private void create_View152() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Create V152");

        try {
            Statement stmt = c.createStatement();

            //STEP: Execute Update Statement
            String sql = "CREATE VIEW V152(s_suppkey, s_name, s_nationkey, s_acctbal) AS " +
            "SELECT s_suppkey, s_name, s_nationkey, s_acctbal " +
            "FROM supplier;";
            stmt.execute(sql);

            //STEP: Commit Transaction
            c.commit();

            stmt.close();
            System.out.println("success");
        } catch(Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
            try {
                c.rollback();
            } catch (Exception e1) {
                System.err.println(e1.getClass().getName() + ": " + e1.getMessage());
            }
            
        }

        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    private void Q15() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Q15");

        try {
            FileWriter writer = new FileWriter("output/15.out", false);
            PrintWriter printer = new PrintWriter(writer);

            String sql = "select count(DISTINCT o_orderkey) as cnt " +
            "from orders, lineitem " +
            "where o_orderkey = l_orderkey " +
                "and o_custkey in " +
                    "(select c_custkey " +
                    "from customer " +
                    "where c_acctbal < 0) " +
                "and l_suppkey in " +
                    "(select s_suppkey " +
                    "from V152 " +
                    "where s_acctbal < 0);";

            PreparedStatement stmt = c.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
                
            //printer.printf("%10s %-40s\n", "sName", "cnt");

            
            while(rs.next()){
                int count = rs.getInt("cnt");
                printer.printf("%-10d\n", count);
            }

            rs.close();
            stmt.close();
            printer.close();
            writer.close();
        } catch (Exception e) {
            System.err.println(e.getClass().getName() + ": " + e.getMessage());
        }

        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    public static void main(String args[]) {
        Lab_9 sj = new Lab_9();
        
        sj.openConnection("data/tpch.sqlite");

        sj.create_View1();
        sj.Q1();

        sj.create_View2();
        sj.Q2();

        sj.Q3();
        sj.Q4();

        sj.create_View5();
        sj.Q5();

        sj.Q6();
        sj.Q7();
        sj.Q8();
        sj.Q9();

        sj.create_View10();
        sj.Q10();

        sj.Q11();
        sj.Q12();
        sj.Q13();
        sj.Q14();

        sj.create_View151();
        sj.create_View152();
        sj.Q15();

        sj.closeConnection();
    }
}
