<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="javax.servlet.*,javax.servlet.http.*" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete Item</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="style.css"/>
</head>
<body class="bg-black text-white d-flex flex-column justify-content-center align-items-center">
    <h2 class="p-4"> Delete Item </h2>

<form class="d-flex flex-column" action="delete.jsp" method="POST">

    <label class="py-2" for="itemName">Select Item to delete:</label>
    
    <select id="itemId" name="itemId" class="bg-dark text-white rounded" required>
        <% 
            String url = "jdbc:mysql://localhost:9316/inventory_db";
            String dbUser = "parth";
            String dbPassword = "root";

            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection connection = DriverManager.getConnection(url, dbUser, dbPassword);

                String sql = "SELECT id, name FROM inventory";
                Statement statement = connection.createStatement();
                ResultSet resultSet = statement.executeQuery(sql);

                while(resultSet.next()) {
                    int itemId = resultSet.getInt("id");
                    String itemName = resultSet.getString("name");
        %>
                    <option value="<%= itemId %>"><%= itemName %></option>
        <% 
                }
                resultSet.close();
                statement.close();
                connection.close();
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
            }
        %>
    </select>
    <button class="btn btn-primary m-2 mt-4"type="submit">Delete Item</button>
    <a class="btn btn-primary m-2" href="dashboard.jsp">Back to Dashboard</a>
</form>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

</body>
</html>
