// STEP: Import required packages
import java.sql.*;
//import java.text.Normalizer.Form;

//import org.graalvm.compiler.core.common.type.ArithmeticOpTable.BinaryOp.And;

//import sun.jvm.hotspot.code.Location.Where;

import java.io.FileWriter;
import java.io.FileReader;
import java.io.BufferedReader;
import java.io.PrintWriter;
import java.io.File;

public class Lab_7 {
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

    private void createTable() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Create table");

        try {
            Statement stmt = c.createStatement();

            //STEP: Execute Update Statement
            String sql = "CREATE TABLE testTable (" +
                    "w_warehousekey decimal(9,0) not null," +
                    "w_name char(100) not null," +
                    "w_capacity decimal(6,0) not null," +
                    "w_suppkey decimal(9,0) not null," +
                    "w_nationkey decimal(2,0) not null)";
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

    private void populateTable() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Populate table");
//warehouseKey, w_name, capacity
        try {            
            String sql = "INSERT INTO testTable VALUES(?, ?, ?, ?, ?)"; 
            PreparedStatement stmt = c.prepareStatement(sql); 

            stmt.setInt(1, 1); stmt.setString(2, "Supplier#000000001___EGYPT"); stmt.setInt(3, 2044); stmt.setInt(4, 1); stmt.setInt(5, 4); stmt.addBatch();
            stmt.setInt(1, 2); stmt.setString(2, "Supplier#000000001___ROMANIA"); stmt.setInt(3, 2044);	stmt.setInt(4, 1); stmt.setInt(5, 19); stmt.addBatch();
            stmt.setInt(1, 3); stmt.setString(2, "Supplier#000000002___VIETNAM"); stmt.setInt(3, 1876); stmt.setInt(4, 2); stmt.setInt(5, 21); stmt.addBatch();
            stmt.setInt(1, 4); stmt.setString(2, "Supplier#000000002___SAUDI ARABIA"); stmt.setInt(3, 1876); stmt.setInt(4, 2); stmt.setInt(5, 20); stmt.addBatch();
            stmt.setInt(1, 5); stmt.setString(2, "Supplier#000000003___ALGERIA"); stmt.setInt(3, 2006);	stmt.setInt(4, 3); stmt.setInt(5, 0); stmt.addBatch();
            stmt.setInt(1, 6); stmt.setString(2, "Supplier#000000003___JAPAN"); stmt.setInt(3, 2006); stmt.setInt(4, 3); stmt.setInt(5, 12); stmt.addBatch();
            stmt.setInt(1, 7); stmt.setString(2, "Supplier#000000004___CANADA"); stmt.setInt(3, 2246); stmt.setInt(4, 4); stmt.setInt(5, 3); stmt.addBatch();
            stmt.setInt(1, 8); stmt.setString(2, "Supplier#000000004___IRAN"); stmt.setInt(3, 2246); stmt.setInt(4, 4);	stmt.setInt(5, 10); stmt.addBatch();
            stmt.setInt(1, 9); stmt.setString(2, "Supplier#000000005___CANADA"); stmt.setInt(3, 1730); stmt.setInt(4, 5); stmt.setInt(5, 3); stmt.addBatch();
            stmt.setInt(1, 10);	stmt.setString(2, "Supplier#000000005___EGYPT"); stmt.setInt(3, 1730); stmt.setInt(4, 5); stmt.setInt(5, 4); stmt.addBatch();
            stmt.setInt(1, 11);	stmt.setString(2, "Supplier#000000006___IRAN)"); stmt.setInt(3, 1732); stmt.setInt(4, 6); stmt.setInt(5, 10); stmt.addBatch();
            stmt.setInt(1, 12);	stmt.setString(2, "Supplier#000000006___CANADA"); stmt.setInt(3, 1732);	stmt.setInt(4, 6); stmt.setInt(5, 3); stmt.addBatch();
            stmt.setInt(1, 13);	stmt.setString(2, "Supplier#000000007___CANADA"); stmt.setInt(3, 1894);	stmt.setInt(4, 7); stmt.setInt(5, 3); stmt.addBatch();
            stmt.setInt(1, 14);	stmt.setString(2, "Supplier#000000007___ROMANIA"); stmt.setInt(3, 1894); stmt.setInt(4, 7); stmt.setInt(5, 19); stmt.addBatch();
            stmt.setInt(1, 15);	stmt.setString(2, "Supplier#000000008___CANADA"); stmt.setInt(3, 2088);	stmt.setInt(4, 8); stmt.setInt(5, 3); stmt.addBatch();
            stmt.setInt(1, 16);	stmt.setString(2, "Supplier#000000008___EGYPT"); stmt.setInt(3, 2088); stmt.setInt(4, 8); stmt.setInt(5, 4); stmt.addBatch();
            stmt.setInt(1, 17);	stmt.setString(2, "Supplier#000000009___EGYPT"); stmt.setInt(3, 1794); stmt.setInt(4, 9); stmt.setInt(5, 4); stmt.addBatch();
            stmt.setInt(1, 18);	stmt.setString(2, "Supplier#000000009___IRAQ"); stmt.setInt(3, 1794); stmt.setInt(4, 9); stmt.setInt(5, 11); stmt.addBatch();
            stmt.setInt(1, 19);	stmt.setString(2, "Supplier#000000010___GERMANY"); stmt.setInt(3, 1928); stmt.setInt(4, 10); stmt.setInt(5, 7); stmt.addBatch();
            stmt.setInt(1, 20);	stmt.setString(2, "Supplier#000000010___CANADA"); stmt.setInt(3, 1928);	stmt.setInt(4, 10); stmt.setInt(5, 3); stmt.addBatch();
            stmt.setInt(1, 21);	stmt.setString(2, "Supplier#000000011___EGYPT"); stmt.setInt(3, 1840); stmt.setInt(4, 11); stmt.setInt(5, 4); stmt.addBatch();
            stmt.setInt(1, 22);	stmt.setString(2, "Supplier#000000011___ROMANIA"); stmt.setInt(3, 1840); stmt.setInt(4, 11); stmt.setInt(5, 19); stmt.addBatch();
            stmt.setInt(1, 23);	stmt.setString(2, "Supplier#000000012___SAUDI ARABIA"); stmt.setInt(3, 1618); stmt.setInt(4, 12); stmt.setInt(5, 20); stmt.addBatch();
            stmt.setInt(1, 24);	stmt.setString(2, "Supplier#000000012___INDONESIA"); stmt.setInt(3, 1618); stmt.setInt(4, 12); stmt.setInt(5, 9); stmt.addBatch();
            stmt.setInt(1, 25);	stmt.setString(2, "Supplier#000000013___EGYPT"); stmt.setInt(3, 1872); stmt.setInt(4, 13); stmt.setInt(5, 4); stmt.addBatch();
            stmt.setInt(1, 26);	stmt.setString(2, "Supplier#000000013___MOZAMBIQUE"); stmt.setInt(3, 1872);	stmt.setInt(4, 13); stmt.setInt(5, 16); stmt.addBatch();
            stmt.setInt(1, 27);	stmt.setString(2, "Supplier#000000014___CANADA"); stmt.setInt(3, 2130);	stmt.setInt(4, 14); stmt.setInt(5, 3); stmt.addBatch();
            stmt.setInt(1, 28);	stmt.setString(2, "Supplier#000000014___EGYPT"); stmt.setInt(3, 2130); stmt.setInt(4, 14); stmt.setInt(5, 4); stmt.addBatch();
            stmt.setInt(1, 29);	stmt.setString(2, "Supplier#000000015___SAUDI ARABIA");	stmt.setInt(3, 2256); stmt.setInt(4, 15); stmt.setInt(5, 20); stmt.addBatch();
            stmt.setInt(1, 30);	stmt.setString(2, "Supplier#000000015___EGYPT"); stmt.setInt(3, 2256); stmt.setInt(4, 15); stmt.setInt(5, 4); stmt.addBatch();
            stmt.setInt(1, 31);	stmt.setString(2, "Supplier#000000016___SAUDI ARABIA"); stmt.setInt(3, 1972); stmt.setInt(4, 16); stmt.setInt(5, 20); stmt.addBatch();
            stmt.setInt(1, 32);	stmt.setString(2, "Supplier#000000016___CANADA"); stmt.setInt(3, 1972);	stmt.setInt(4, 16); stmt.setInt(5, 3); stmt.addBatch();
            stmt.setInt(1, 33);	stmt.setString(2, "Supplier#000000017___INDONESIA"); stmt.setInt(3, 1740); stmt.setInt(4, 17); stmt.setInt(5, 9); stmt.addBatch();
            stmt.setInt(1, 34);	stmt.setString(2, "Supplier#000000017___ROMANIA"); stmt.setInt(3, 1740); stmt.setInt(4, 17); stmt.setInt(5, 19); stmt.addBatch();
            stmt.setInt(1, 35);	stmt.setString(2, "Supplier#000000018___ROMANIA"); stmt.setInt(3, 2046); stmt.setInt(4, 18); stmt.setInt(5, 19); stmt.addBatch();
            stmt.setInt(1, 36);	stmt.setString(2, "Supplier#000000018___CANADA"); stmt.setInt(3, 2046);	stmt.setInt(4, 18); stmt.setInt(5, 3); stmt.addBatch();
            stmt.setInt(1, 37);	stmt.setString(2, "Supplier#000000019___ROMANIA"); stmt.setInt(3, 2436); stmt.setInt(4, 19); stmt.setInt(5, 19); stmt.addBatch();
            stmt.setInt(1, 38);	stmt.setString(2, "Supplier#000000019___EGYPT"); stmt.setInt(3, 2436); stmt.setInt(4, 19); stmt.setInt(5, 4); stmt.addBatch();
            stmt.setInt(1, 39);	stmt.setString(2, "Supplier#000000020___BRAZIL"); stmt.setInt(3, 1908);	stmt.setInt(4, 20); stmt.setInt(5, 2); stmt.addBatch();
            stmt.setInt(1, 40);	stmt.setString(2, "Supplier#000000020___UNITED STATES"); stmt.setInt(3, 1908); stmt.setInt(4, 20); stmt.setInt(5, 24); stmt.addBatch();
            stmt.setInt(1, 41);	stmt.setString(2, "Supplier#000000021___CANADA"); stmt.setInt(3, 1924);	stmt.setInt(4, 21); stmt.setInt(5, 3); stmt.addBatch();
            stmt.setInt(1, 42);	stmt.setString(2, "Supplier#000000021___BRAZIL"); stmt.setInt(3, 1924);	stmt.setInt(4, 21); stmt.setInt(5, 2); stmt.addBatch();
            stmt.setInt(1, 43);	stmt.setString(2, "Supplier#000000022___KENYA"); stmt.setInt(3, 2174); stmt.setInt(4, 22); stmt.setInt(5, 14); stmt.addBatch();
            stmt.setInt(1, 44);	stmt.setString(2, "Supplier#000000022___VIETNAM"); stmt.setInt(3, 2174); stmt.setInt(4, 22); stmt.setInt(5, 21); stmt.addBatch();
            stmt.setInt(1, 45);	stmt.setString(2, "Supplier#000000023___EGYPT"); stmt.setInt(3, 1726); stmt.setInt(4, 23); stmt.setInt(5, 4); stmt.addBatch();
            stmt.setInt(1, 46);	stmt.setString(2, "Supplier#000000023___IRAN"); stmt.setInt(3, 1726); stmt.setInt(4, 23); stmt.setInt(5, 10); stmt.addBatch();
            stmt.setInt(1, 47);	stmt.setString(2, "Supplier#000000024___INDONESIA"); stmt.setInt(3, 1788); stmt.setInt(4, 24); stmt.setInt(5, 9); stmt.addBatch();
            stmt.setInt(1, 48);	stmt.setString(2, "Supplier#000000024___ALGERIA"); stmt.setInt(3, 1788); stmt.setInt(4, 24); stmt.setInt(5, 0); stmt.addBatch();
            stmt.setInt(1, 49);	stmt.setString(2, "Supplier#000000025___BRAZIL"); stmt.setInt(3, 1882);	stmt.setInt(4, 25); stmt.setInt(5, 2); stmt.addBatch();
            stmt.setInt(1, 50);	stmt.setString(2, "Supplier#000000025___ALGERIA"); stmt.setInt(3, 1882); stmt.setInt(4, 25); stmt.setInt(5, 0); stmt.addBatch();

            //STEP: Commit transaction            
            c.commit();    

            stmt.close();            
            System.out.println("success");        
        } catch (Exception e) {            
            System.err.println(e.getClass().getName() + ": " + e.getMessage());            
            try {                
                c.rollback();            
            } catch (Exception e1) {                
                System.err.println(e1.getClass().getName() + ": " + e1.getMessage());            
            }        
        }


        System.out.println("++++++++++++++++++++++++++++++++++");
    }

    private void dropTable() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Drop table");

        try{
            Statement stmt = c.createStatement();

            //STEP: Execute update statement
            String sql = "DROP TABLE testTable";
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
///////////////////////////////////////////////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////////////////////////////////////////
    private void Q1() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Q1");

    //Q1 displays the entire content of the warehouse table sorted on w warehousekey by performing a SQL query.


        try {
            FileWriter writer = new FileWriter("output/1.out", false);
            PrintWriter printer = new PrintWriter(writer);

            String sql = "SELECT w_warehousekey as wId, w_name as wName, w_capacity as wCapacity, w_suppkey as wSuppkey, w_nationkey as wNationkey " +
                         "FROM warehouse";

            PreparedStatement stmt = c.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
                
            printer.printf("%10s %-40s %10s %10s %10s\n", "wId", "wName", "wCap", "sId", "nId");

            
            while(rs.next()){
                int key = rs.getInt("wId");
                String name = rs.getString("wName");
                int capacity = rs.getInt("wCapacity");
                int suppkey = rs.getInt("wSuppkey");
                int nation = rs.getInt("wNationkey");
                printer.printf("%10d %-40s %10d %10d %10d\n", key, name, capacity, suppkey, nation);
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

    private void Q2() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Q2");

        //Q2 computes the number of warehouses and the total capacity for the warehouses in every nation. The
        //result is sorted in decreasing order of the number of warehouses and of the capacity, then alphabetical
        //order of the nation name.

        try {
            FileWriter writer = new FileWriter("output/2.out", false);
            PrintWriter printer = new PrintWriter(writer);

            String sql = "SELECT n_name as nation, COUNT(w_warehousekey) as wCount, SUM(w_capacity) as capSum " +
                         "FROM nation, warehouse " +
                         "WHERE " +
                            "w_nationkey = n_nationkey " +
                         "GROUP BY n_name " +
                         "ORDER BY SUM(w_capacity) DESC";
            
            PreparedStatement stmt = c.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            printer.printf("%-40s %10s %10s\n", "nation", "numW", "totCap");

            while(rs.next()){
                String name = rs.getString("nation");
                int warehouseCount = rs.getInt("wCount");
                int capacitySum = rs.getInt("capSum");
                printer.printf("%-40s %10d %10d\n", name, warehouseCount, capacitySum);
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

        //Q3 computes the suppliers that have a warehouse in a given nation taken as input parameter. The
        //nation where warehouses are located is read from the input le input/3.in. Q3 prints the name of the
        //supplier, the nation of the supplier, and the name of the warehouse|sorted in alphabetical order by
        //supplier name.

        try {
            File fn = new File("input/3.in");
            FileReader reader = new FileReader(fn);
            BufferedReader in = new BufferedReader(reader);
            String nation = in.readLine();
            in.close();

            FileWriter writer = new FileWriter("output/3.out", false);
            PrintWriter printer = new PrintWriter(writer);


            String sql = "SELECT s_name as sName, n2.n_name as nName, w_name as wName " +
                         "FROM supplier, nation n1, nation n2, warehouse " +
                         "WHERE " +
                            "w_nationkey = n1.n_nationkey AND " +
                            "n1.n_name = ? AND " +                        // " + nation + "    'JAPAN'
                            "s_nationkey = n2.n_nationkey AND " +
                            "substr(w_name, 1,18) = s_name " +
                         "GROUP BY s_name";

            PreparedStatement stmt = c.prepareStatement(sql);
            stmt.setString(1, nation);
            ResultSet rs = stmt.executeQuery();

            printer.printf("%-20s %-20s %-40s\n", "supplier", "nation", "warehouse");

            while(rs.next()){
                String supp = rs.getString("sName");
                String nat = rs.getString("nName");
                String warehouse = rs.getString("wName");
                printer.printf("%-20s %-20s %-40s\n", supp, nat, warehouse);
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

        //Q4 finds the warehouses from a given region that have capacity larger than a given threshold. The
        //region name and the minimum capacity are parameters stored in the le input/4.in. Q4 prints the
        //warehouse name and its capacity in decreasing order of the capacity.

        try {
            File fn = new File("input/4.in");
            FileReader reader = new FileReader(fn);
            BufferedReader in = new BufferedReader(reader);
            String region = in.readLine();
            int cap = Integer.parseInt(in.readLine());
            in.close();

            FileWriter writer = new FileWriter("output/4.out", false);
            PrintWriter printer = new PrintWriter(writer);

            String sql = "SELECT w_name as wName, w_capacity as wCap " +
                         "FROM nation, warehouse, region " +
                         "WHERE " +
                            "w_nationkey = n_nationkey AND " +
                            "n_regionkey = r_regionkey AND " +
                            "r_name = ? " +                                       //'ASIA' " +        + region +   
                         " GROUP BY w_name " +
                         "HAVING w_capacity > ? " +                                   //2000 " +         + cap +
                         "ORDER BY w_capacity DESC";

            PreparedStatement stmt = c.prepareStatement(sql);
            stmt.setString(1, region);
            stmt.setInt(2, cap);
            ResultSet rs = stmt.executeQuery();

            printer.printf("%-40s %10s\n", "warehouse", "capacity");
            
            while(rs.next()){
                String name = rs.getString("wName");
                int warehouseCap = rs.getInt("wCap");
                printer.printf("%-40s %10d\n", name, warehouseCap);
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

    private void Q5() {
        System.out.println("++++++++++++++++++++++++++++++++++");
        System.out.println("Q5");

        //Q5 determines the total capacity of the warehouses belonging to suppliers from a given nation in every
        //region. The suppliers' nation is a parameter stored in the le input/5.in. If there are no warehouses
        //in a region, then value 0 is printed for that region. Q5 prints the region and the capacity sorted
        //alphabetically by region.

        try {
            File fn = new File("input/5.in");
            FileReader reader = new FileReader(fn);
            BufferedReader in = new BufferedReader(reader);
            String nation = in.readLine();
            in.close();

            FileWriter writer = new FileWriter("output/5.out", false);
            PrintWriter printer = new PrintWriter(writer);

            String sql = "SELECT DISTINCT r_name as region, SUM(w_capacity) as sum " +
                         "FROM region, warehouse, nation n1, nation n2, supplier " +
                         "WHERE " +
                            "s_nationkey = n1.n_nationkey AND " +
                            "n1.n_name = ? AND " +                                      //'UNITED STATES' AND             nation +
                            "w_nationkey = n2.n_nationkey AND " +
                            "n2.n_regionkey = r_regionkey AND " +
                            "s_suppkey = w_suppkey " +
                         "GROUP BY r_name " +
                         "UNION " +
                         "SELECT DISTINCT r_name as region, (w_capacity*0) as sum " +
                         "FROM region, warehouse " +
                         "WHERE " +
                            "r_name = 'ASIA'";

            PreparedStatement stmt = c.prepareStatement(sql);
            stmt.setString(1, nation);
            ResultSet rs = stmt.executeQuery();

            printer.printf("%-20s %20s\n", "region", "capacity");

            while(rs.next()){
                String region = rs.getString("region");
                int sum = rs.getInt("sum");
                printer.printf("%-20s %20d\n", region, sum);
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
        Lab_7 sj = new Lab_7();
        
        sj.openConnection("data/tpch.sqlite");

        sj.dropTable();
        sj.createTable();
        sj.populateTable();

        sj.Q1();
        sj.Q2();
        sj.Q3();
        sj.Q4();
        sj.Q5();

        sj.closeConnection();
    }
}
