 
              <!-- Admin Session Management -->
<%
String username = (String) session.getAttribute("username");
String role = (String) session.getAttribute("role");

if (username == null || !"admin".equalsIgnoreCase(role)) {
    response.sendRedirect("mlogin.jsp");
    return;
}
%>





<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Homepage</title>
</head>
<body>
  <h1>Welcome Admin</h1>

<p><b>Name :</b> <%= username %></p>
<p><b>Role :</b> <%= role %></p>

<hr>

<!-- ADMIN ACTIONS -->
<h2>Admin Controls</h2>
 
    
     <a href="viewMovies.jsp">🎬 View All Movies</a> 
     <br><br>
 
<form action="logout.jsp" method="post">
    <input type="submit" value="Logout">
</form>

</body>
</html>