<%@ page import="java.sql.*, com.bank.database.DatabaseConnection" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <title>Retrieve Data from Database</title>
</head>
<body>
    <h2>Users List</h2>

    <%
        // Create a connection to the database
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            // Establish connection using the custom DatabaseConnection class
            conn = DatabaseConnection.getConnection();
            
            // Create a SQL query (example: retrieving data from 'users' table)
            String sql = "SELECT * FROM users";  // Modify as needed
            
            // Execute the query
            stmt = conn.createStatement();
            rs = stmt.executeQuery(sql);

            // Output the results as an HTML table
            out.println("<table border='1'>");
            out.println("<tr><th>ID</th><th>Name</th><th>Email</th></tr>"); // Modify columns as needed

            // Loop through the result set and display each row
            while (rs.next()) {
                out.println("<tr>");
                out.println("<td>" + rs.getInt("id") + "</td>");  // Modify based on your table structure
                out.println("<td>" + rs.getString("name") + "</td>");
                out.println("<td>" + rs.getString("email") + "</td>");
                out.println("</tr>");
            }

            out.println("</table>");

        } catch (SQLException e) {
            out.println("Error: " + e.getMessage());
        } finally {
            // Clean up and close the resources
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                out.println("Error closing resources: " + e.getMessage());
            }
        }
    %>
</body>
</html>
