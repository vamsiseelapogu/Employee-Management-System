<%@ page import="com.dao.MovieDAO,com.dto.MovieDTO, java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    // ===== User Session Management =====
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");

    if (username == null || !"user".equalsIgnoreCase(role)) {
        response.sendRedirect("mlogin.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Homepage - SNR Movies</title>
<style>
    body {
        font-family: Arial, Helvetica, sans-serif;
        margin: 0;
        height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
        background-color: #f7f7f7;
    }

    .home-card {
        background-color: #fff;
        padding: 40px 50px;
        border-radius: 12px;
        box-shadow: 0 8px 20px rgba(0,0,0,0.2);
        width: 400px;
        text-align: center;
    }

    .home-card h1 {
        color: #ff4e50;
        font-size: 32px;
        margin-bottom: 20px;
        text-shadow: 1px 1px 3px rgba(0,0,0,0.3);
    }

    .home-card h3 {
        color: #555;
        margin-bottom: 20px;
    }

    .home-card input[type="submit"] {
        width: 80%;
        padding: 12px;
        margin: 10px 0;
        font-size: 16px;
        font-weight: bold;
        border: none;
        border-radius: 8px;
        cursor: pointer;
        transition: 0.3s;
    }

    .home-card input[type="submit"]:first-of-type {
        background-color: #ff4e50;
        color: #fff;
    }

    .home-card input[type="submit"]:first-of-type:hover {
        background-color: #f9d423;
        color: #333;
    }

    .home-card input[type="submit"]:last-of-type {
        background-color: #555;
        color: #fff;
    }

    .home-card input[type="submit"]:last-of-type:hover {
        background-color: #777;
    }
</style>
</head>
<body>

<div class="home-card">
    <h1>Welcome, <%= username %></h1>
    <h3>Role: <%= role %></h3>

    <!-- View Movies Button -->
    <form action="userViewMovies.jsp" method="get">
        <input type="submit" value="View Movies">
    </form>

    <!-- Logout Button -->
    <form action="logout.jsp" method="post">
        <input type="submit" value="Logout">
    </form>
</div>

</body>
</html>
