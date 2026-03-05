<%@ page import="java.util.List, com.dao.MovieDAO,com.dto.ShowDTO,com.dto.MovieDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    // ================= USER SESSION MANAGEMENT =================
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");

    if (username == null || !"user".equalsIgnoreCase(role)) {
        response.sendRedirect("mlogin.jsp");
        return;
    }

    //----------> Get movieId from request
    String movieIdParam = request.getParameter("movieId");
    int movieId = 0;
    if (movieIdParam != null) {
        movieId = Integer.parseInt(movieIdParam);
    } else {
        response.sendRedirect("userViewMovies.jsp"); // go back if no movieId
        return;
    }

    MovieDAO dao = new MovieDAO();
    MovieDTO movie = null;
    List<ShowDTO> shows = null;

    try {
        // Fetch movie details
        List<MovieDTO> allMovies = dao.getAllMovies();
        for (MovieDTO m : allMovies) {
            if (m.getMovieId() == movieId) {
                movie = m;
                break;
            }
        }

        // Fetch shows using DAO
        shows = dao.getShowsByMovieId(movieId);

    } catch(Exception e) {
        out.println("<p style='color:red'>Error: " + e.getMessage() + "</p>");
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Shows for <%= movie != null ? movie.getMovieName() : "" %></title>
<style>
    body {
        font-family: Arial, Helvetica, sans-serif;
        background-color: #f7f7f7;
        margin: 0;
        padding: 0;
    }

    .container {
        width: 90%;
        max-width: 900px;
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
        margin-bottom: 20px;
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
    <h1>Shows for Movie: <%= movie != null ? movie.getMovieName() : "Unknown" %></h1>

    <table>
        <tr>
            <th>Show ID</th>
            <th>Show Time</th>
            <th>Available Seats</th>
            <th>Action</th>
        </tr>

        <%
        if (shows != null && !shows.isEmpty()) {
            for (ShowDTO s : shows) {
        %>
        <tr>
            <td><%= s.getShowId() %></td>
            <td><%= s.getShowTime() %></td>
            <td><%= s.getAvailableSeats() %></td>
            <td>
                <form action="bookTicket.jsp" method="get" style="margin:0;">
                    <input type="hidden" name="showId" value="<%= s.getShowId() %>">
                    <input type="hidden" name="movieId" value="<%= movieId %>">
                    <input type="submit" value="Book Tickets">
                </form>
            </td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="4">No shows available for this movie.</td>
        </tr>
        <%
        }
        %>
    </table>

    <a href="userViewMovies.jsp" class="back-link">⬅ Back to Movies</a>
</div>

</body>
</html>
