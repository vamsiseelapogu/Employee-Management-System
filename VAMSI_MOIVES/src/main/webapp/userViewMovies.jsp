<%@ page import="com.dao.MovieDAO,com.dto.MovieDTO, java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    // ================= USER SESSION MANAGEMENT =================
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");
    if (username == null || !"user".equalsIgnoreCase(role)) {
        response.sendRedirect("mlogin.jsp");
        return;
    }   

    // Fetch all movies from DAO
    MovieDAO dao = new MovieDAO();
    List<MovieDTO> movies = dao.getAllMovies();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Available Movies - SNR Movies</title>
<style>
    body {
        font-family: Arial, Helvetica, sans-serif;
        background-color: #f7f7f7;
        margin: 0;
        padding: 0;
    }

    .container {
        width: 90%;
        max-width: 1000px;
        margin: 40px auto;
        background-color: #fff;
        padding: 30px 40px;
        border-radius: 12px;
        box-shadow: 0 8px 20px rgba(0,0,0,0.2);
    }

    h1 {
        color: #ff4e50;
        text-align: center;
        text-shadow: 1px 1px 3px rgba(0,0,0,0.3);
        margin-bottom: 10px;
    }

    h3 {
        text-align: center;
        color: #555;
        margin-bottom: 30px;
    }

    table {
        width: 100%;
        border-collapse: collapse;
    }

    table th, table td {
        padding: 12px 15px;
        text-align: center;
        border-bottom: 1px solid #ddd;
    }

    table th {
        background-color: #ff4e50;
        color: white;
        text-transform: uppercase;
    }

    table tr:hover {
        background-color: #f1f1f1;
    }

    input[type="submit"] {
        padding: 8px 15px;
        border: none;
        border-radius: 5px;
        background-color: #ff4e50;
        color: white;
        cursor: pointer;
        transition: 0.3s;
        font-weight: bold;
    }

    input[type="submit"]:hover {
        background-color: #f9d423;
        color: #333;
    }

    a.back-link {
        display: inline-block;
        margin-top: 20px;
        text-decoration: none;
        color: #ff4e50;
        font-weight: bold;
        transition: 0.3s;
    }

    a.back-link:hover {
        color: #f9d423;
    }
</style>
</head>
<body>

<div class="container">
    <h1>Available Movies</h1>
    <h3>Welcome, <%= username %></h3>

    <table>
        <tr>
            <th>Movie ID</th>
            <th>Movie Name</th>
            <th>Language</th>
            <th>Duration</th>
            <th>Select Show</th>
        </tr>

        <%
        if (movies != null && !movies.isEmpty()) {
            for (MovieDTO m : movies) {
        %>
        <tr>
            <td><%= m.getMovieId() %></td>
            <td><%= m.getMovieName() %></td>
            <td><%= m.getLanguage() %></td>
            <td><%= m.getDuration() %></td>
            <td>
                <form action="userViewShows.jsp" method="get" style="margin:0;">
                    <input type="hidden" name="movieId" value="<%= m.getMovieId() %>">
                    <input type="submit" value="Select Shows">
                </form>
            </td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="5">No movies available</td>
        </tr>
        <%
        }
        %>
    </table>

    <a href="userHome.jsp" class="back-link">⬅ Back to Home</a>
</div>

</body>
</html>
