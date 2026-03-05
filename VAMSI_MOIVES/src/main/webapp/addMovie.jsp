<%@ page import="com.dto.MovieDTO" %>
<%@ page import="com.dao.MovieDAO" %>

                   <!-- Session Management -->
<%
String username = (String) session.getAttribute("username");
String role = (String) session.getAttribute("role");

if (username == null || !"admin".equalsIgnoreCase(role)) {
    response.sendRedirect("mlogin.jsp");
    return;
}
%>

                            <!-- Java Code -->

<%
try {
	if (request.getParameter("movie_name") != null) {

		//1: Create MovieDTO object	
		MovieDTO md = new MovieDTO();

		//2: Get the values from UI and set to MovieDTO
		md.setMovieName(request.getParameter("movie_name"));
		md.setLanguage(request.getParameter("language"));
		md.setDuration(request.getParameter("duration"));

		//3: Create DAO object to connect with DB     
		MovieDAO dao = new MovieDAO();
		boolean status = dao.addMoive(md);

		//4.returns status    
		if (status) {
	         out.println("<p style='color:green'>Movie Added Successfully</p>");
		} else {
	         out.println("<p style='color:red'>Failed to Add Movie</p>");
		}
	}
} catch (Exception e) {
	out.println("<p style='color:red'>Error : " + e.getMessage() + "</p>");
}
%>

                               <!-- HTML CODE TO ADD Movie -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Adding movie</title>
</head>
<body>
    <h2>Add Movie</h2>

<form method="post">
    Movie Name : <input type="text" name="movie_name" required><br><br>
    Language   : <input type="text" name="language" required><br><br>
    Duration   : <input type="text" name="duration" required><br><br>

    <input type="submit" value="Add Movie">
</form>

<br>
<a href="adminHome.jsp">Back to Home</a>
</body>
</html>