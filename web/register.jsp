<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="javax.servlet.*,javax.servlet.http.*" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

    <link rel="stylesheet" href="style.css"/>
</head>
<body class="d-flex flex-column justify-content-center align-items-center bg-black text-white">

<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    if (username != null && password != null) {
        String url = "jdbc:mysql://localhost:9316/inventory_db";
        String dbUser = "parth";
        String dbPassword = "root";

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection connection = DriverManager.getConnection(url, dbUser, dbPassword);

            String checkUserQuery = "SELECT * FROM users WHERE username=?";
            PreparedStatement checkUserStatement = connection.prepareStatement(checkUserQuery);
            checkUserStatement.setString(1, username);
            ResultSet userResultSet = checkUserStatement.executeQuery();

            if (userResultSet.next()) {
                out.println("<p>Username already exists. Please choose a different username.</p>");
            } else {
                String insertUserQuery = "INSERT INTO users (username, password) VALUES (?, ?)";
                PreparedStatement insertUserStatement = connection.prepareStatement(insertUserQuery);
                insertUserStatement.setString(1, username);
                insertUserStatement.setString(2, password);
                insertUserStatement.executeUpdate();

                out.println("<p>Registration successful. You can now <a href=\"login.jsp\">login</a>.</p>");
            }

            userResultSet.close();
            checkUserStatement.close();
            connection.close();
        } catch (ClassNotFoundException | SQLException e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
            e.printStackTrace();
        }
    }
%>

<h2>Register</h2>
<form class="d-flex flex-column" action="register.jsp" method="POST">
    <label class="py-2" for="username">Username:</label>
    <input type="text" id="username" name="username" required>
    <label class="py-2" for="password">Password:</label>
    <input type="password" id="password" name="password" required>
    <button class="btn btn-primary m-2"type="submit">Register</button>
</form>
<p>Already have an account? <a href="index.html">Login here</a></p>

</body>
</html>
