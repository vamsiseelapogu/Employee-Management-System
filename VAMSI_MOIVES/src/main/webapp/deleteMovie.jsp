<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.dao.MovieDAO" %>

<%

try{
String idStr = request.getParameter("id");

if(idStr != null){
    int movieId = Integer.parseInt(idStr);
    MovieDAO dao = new MovieDAO();
    boolean deleted = dao.deleteMovie(movieId);

    if(deleted){
        response.sendRedirect("viewMovies.jsp?msg=Movie+Deleted+Successfully");
    } else {
        out.println("<p style='color:red'>Failed to delete movie</p>");
    }
} else {
    response.sendRedirect("viewMovies.jsp");
}
}catch(Exception e){
	e.printStackTrace();
}
%>
 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete Page</title>
</head>
<body>

</body>
</html>