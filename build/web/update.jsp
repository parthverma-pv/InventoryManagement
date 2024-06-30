<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="javax.servlet.*,javax.servlet.http.*" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Item</title>
</head>
<body>

<%
    session = request.getSession();
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp");
    } else {
        if (request.getMethod().equals("POST")) {
            int itemId = Integer.parseInt(request.getParameter("itemId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            double price = Double.parseDouble(request.getParameter("price"));

            String url = "jdbc:mysql://localhost:9316/inventory_db";
            String dbUser = "parth";
            String dbPassword = "root";

            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection connection = DriverManager.getConnection(url, dbUser, dbPassword);

                String sql = "UPDATE inventory SET  quantity=?, price=? WHERE id=?";
                PreparedStatement statement = connection.prepareStatement(sql);
                statement.setInt(1, quantity);
                statement.setDouble(2, price);
                statement.setInt(3, itemId);
                statement.executeUpdate();

                statement.close();
                connection.close();

                response.sendRedirect("dashboard.jsp");
            } catch (ClassNotFoundException | SQLException e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
                e.printStackTrace();
            }
        }
    }
%>

</body>
</html>
