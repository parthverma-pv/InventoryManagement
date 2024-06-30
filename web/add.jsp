<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="javax.servlet.*,javax.servlet.http.*" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Item</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="style.css"/>
</head>
<body class="d-flex flex-column bg-black text-white justify-content-center align-items-center">

<%
    session = request.getSession();
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp");
    } else {
        if (request.getMethod().equals("POST")) {
            String itemName = request.getParameter("itemName");
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            double price = Double.parseDouble(request.getParameter("price"));

            String url = "jdbc:mysql://localhost:9316/inventory_db";
            String dbUser = "parth";
            String dbPassword = "root";

            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection connection = DriverManager.getConnection(url, dbUser, dbPassword);

                String sql = "INSERT INTO inventory (name, quantity, price) VALUES (?, ?, ?)";
                PreparedStatement statement = connection.prepareStatement(sql);
                statement.setString(1, itemName);
                statement.setInt(2, quantity);
                statement.setDouble(3, price);
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

<h2 class="p-4">Add New Item</h2>
<form class="d-flex flex-column" action="add.jsp" method="POST">
    <label for="itemName" class="py-2">Item Name:</label>
    <input type="text" id="itemName" name="itemName" class="rounded bg-dark text-white" required>
    <label for="quantity" class="py-2">Quantity:</label>
    <input type="number" id="quantity" name="quantity" min="1" class="rounded bg-dark text-white" required>
    <label for="price" class="py-2">Price:</label>
    <input type="number" id="price" name="price" min="0.01" step="0.01" class="rounded bg-dark text-white" required>
    <button class="btn btn-primary m-2 mt-5" type="submit">Add Item</button>
    <a href="dashboard.jsp" class="btn btn-primary m-2">Back to Dashboard</a>
</form>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

</body>
</html>
