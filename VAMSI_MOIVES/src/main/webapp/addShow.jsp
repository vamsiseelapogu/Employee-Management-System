<%@ page import="com.dto.MovieDTO" %>
<%@ page import="com.dao.MovieDAO" %>
<%@ page import="java.util.List" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- ================= ADMIN SESSION MANAGEMENT ================= -->
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
List<MovieDTO> movies = null; // declare here

try {
    MovieDAO dao = new MovieDAO();
    movies = dao.getAllMovies(); // assign inside try


    // Check if form submitted
    if (request.getParameter("movie_id") != null) {
        int movieId = Integer.parseInt(request.getParameter("movie_id"));
        String showTime = request.getParameter("show_time");
        int seats = Integer.parseInt(request.getParameter("available_seats"));

        boolean status = dao.addShow(movieId, showTime, seats);

        if (status) {
            out.println("<p style='color:green'>Show added successfully!</p>");
        } else {
            out.println("<p style='color:red'>Failed to add show!</p>");
        }
    }

} catch (Exception e) {
    out.println("<p style='color:red'>Error: " + e.getMessage() + "</p>");
}
%>

 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
     
     
<h2>➕ Add Show</h2>

<form method="post">
    Movie: 
    <select name="movie_id" required>
        <option value="">--Select Movie--</option>
        <%
        if (movies != null) {
            for (MovieDTO m : movies) {
        %>
        <option value="<%= m.getMovieId() %>"><%= m.getMovieName() %></option>
        <%
            }
        }
        %>
    </select><br><br>

    Show Time: <input type="text" name="show_time" placeholder="e.g., 10:00 AM" required><br><br>
    Available Seats: <input type="text" name="available_seats" required><br><br>

    <input type="submit" value="Add Show">
</form>

<br>
 
<a href="adminHome.jsp">⬅ Back to Admin Home</a>
     
     
</body>
</html>