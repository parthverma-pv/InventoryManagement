<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="javax.servlet.*,javax.servlet.http.*" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="style.css"/>
        <style>
            button{
                width: 150px;
            }
        </style>
</head>
<body class="bg-black text-white d-flex flex-column align-items-center position-relative">
    
<%
    session = request.getSession();
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp");
    } else {
        String url = "jdbc:mysql://localhost:9316/inventory_db";
        String dbUser = "parth";
        String dbPassword = "root";

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection connection = DriverManager.getConnection(url, dbUser, dbPassword);

            Statement statement = connection.createStatement();
            String sql = "SELECT * FROM inventory";
            ResultSet resultSet = statement.executeQuery(sql);

            out.println("<div class='d-flex justify-content-between bg-dark pt-4 px-5 w-100'>");
            out.println("<h2>Welcome, " + username + "!</h2>");
            out.println("<p><a href='logout.jsp' class='btn btn-primary m-2'>Logout</a></p>");
            out.println("</div>");
            
            out.println("<div class='w-75'>");
            out.println("<h3 class='text-center p-4 mt-5'>Current Inventory</h3>");
            out.println("<table class='table table-bordered table-dark'");
            out.println("<tr><th>Item ID</th><th>Item Name</th><th>Quantity</th><th>Price</th><th>Amount</th></tr>");
            while (resultSet.next()) {
                int itemId = resultSet.getInt("id");
                String itemName = resultSet.getString("name");
                int quantity = resultSet.getInt("quantity");
                double price = resultSet.getDouble("price");
                double amount = quantity*price;
                out.println("<tr><td>" + itemId + "</td><td>" + itemName + "</td><td>" + quantity + "</td><td>" + price + "</td><td>" + amount + "</td></tr>");
            }
            out.println("</table>");
            out.println("</div>");
            resultSet.close();
            statement.close();
            connection.close();
        } catch (ClassNotFoundException | SQLException e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
            e.printStackTrace();
        }
    }
%>

<div>
<a href='add.jsp'><button type='button' class="btn btn-primary m-2">Add Item</button></a>
<a href='updateForm.jsp'><button type='button' class="btn btn-primary m-2">Update Item</button></a>
<a href='deleteForm.jsp'><button type='button' class="btn btn-primary m-2">Delete Item</button></a>
</div>
<footer class="bottom">
    <div class="date-space p-3 me-auto left"></div>
</footer>
<script>
    
const date = new Date();
const options = { weekday: 'long', year: 'numeric', month:'long', day: 'numeric' };
let currentDate = date.toLocaleDateString('en-US', options);
document.getElementsByClassName('date-space')[0].innerHTML = currentDate;


</script>
</body>
</html>
