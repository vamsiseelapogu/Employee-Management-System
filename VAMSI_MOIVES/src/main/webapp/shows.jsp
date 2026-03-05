<%@ page import="java.util.List, com.dao.MovieDAO,com.dto.ShowDTO,com.dto.MovieDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!-- ADMIN SESSION MANAGEMENT -->
<%
String username = (String) session.getAttribute("username");
String role = (String) session.getAttribute("role");

if (username == null || !"admin".equalsIgnoreCase(role)) {
    response.sendRedirect("mlogin.jsp");
    return;
}

        /*  ----------   Java Code ------------      */

// Get movieId from URL
String movieIdParam = request.getParameter("movieId");
int movieId = 0;
if (movieIdParam != null) {
    movieId = Integer.parseInt(movieIdParam);
} else {
    out.println("<p style='color:red'>Invalid Movie ID!</p>");
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

    // Fetch shows
    shows = dao.getShowsByMovieId(movieId);

} catch(Exception e) {
    out.println("<p style='color:red'>Error: " + e.getMessage() + "</p>");
}
%>



<!------------------    HTML CODE    ----------------->


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Shows for <%= movie != null ? movie.getMovieName() : "" %></title>
 
</head>
<body>

<h1>Shows for Movie:
 <%= movie != null ? movie.getMovieName() : "Unknown" %></h1>

<!-- Shows Table -->
<table>
<tr>
    <th>Show ID</th>
    <th>Show Time</th>
    <th>Available Seats</th>
</tr>
<%
if (shows != null && !shows.isEmpty()) {
    for (ShowDTO s : shows) {
%>
<tr>
    <td><%= s.getShowId() %></td>
    <td><%= s.getShowTime() %></td>
    <td><%= s.getAvailableSeats() %></td>
</tr>
<%
    }
} else {
%>
<tr>
    <td colspan="3">No shows available for this movie.</td>
</tr>
<%
}
%>
</table>

<br>
<!-- Link to add a new show -->
<a href="addShow.jsp?movieId=<%= movieId %>">➕ Add New Show</a>
<br><br>
<a href="viewMovies.jsp">⬅ Back to Movies</a><br>
<a href="adminHome.jsp">⬅ Back to Admin Home</a>

</body>
</html>
