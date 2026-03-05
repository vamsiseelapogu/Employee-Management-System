<%@ page import="java.util.List" %>
<%@ page import="com.dto.MovieDTO" %>
<%@ page import="com.dao.MovieDAO" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- ADMIN SESSION MANAGEMENT -->
<%
String username = (String) session.getAttribute("username");
String role = (String) session.getAttribute("role");

if (username == null || !"admin".equalsIgnoreCase(role)) {
    response.sendRedirect("mlogin.jsp");
    return;
}
%>

<!-- ================= JAVA CODE ================= -->
<%
List<MovieDTO> movies = null;

try {
    MovieDAO dao = new MovieDAO();
    movies = dao.getAllMovies();
} catch (Exception e) {
    out.println("<p style='color:red'>Error : " + e.getMessage() + "</p>");
}
%>

<!-- ================= HTML CODE ================= -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View Movies</title>
</head>
<body>

<h1>🎬 Available Movies</h1>

<!-- MOVIES TABLE -->
<table  >
<tr>
    <th>ID</th>
    <th>Movie Name</th>
    <th>Language</th>
    <th>Duration</th>
    <th>Manage Shows</th>  <!-- Link to manage shows -->
    <th>Delete This Movie</th>
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
    <!-- Link to manage shows page -->
    <td>
        <a href="shows.jsp?movieId=<%= m.getMovieId() %>">
            🎭 Shows
        </a>
    </td>
    <!-- Delete Movie -->
    <td>
        <a href="deleteMovie.jsp?id=<%= m.getMovieId() %>" 
           onclick="return confirm('Are you sure you want to delete this movie?');">
           ❌ Delete
        </a>
    </td>
</tr>
<%
    }
} else {
%>
<tr>
    <td colspan="6">No movies available</td>
</tr>
<%
}
%>
</table>

<br>
<h3>Add a new Movie here: <a href="addMovie.jsp">➕ Add Movie</a></h3>
<a href="adminHome.jsp">⬅ Back to Admin Home</a>

</body>
</html>
