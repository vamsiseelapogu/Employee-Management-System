<%@ page import="com.dto.UserDTO" %>
<%@ page import="com.dao.UserDAO" %>

<%
    // ===== Signup Logic =====
    if(request.getParameter("username") != null) {

        UserDTO ud = new UserDTO();

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String ageStr = request.getParameter("age");
        String phoneStr = request.getParameter("phone");

        ud.setRole("USER");

        if (username == null || username.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
            ageStr == null || ageStr.trim().isEmpty() ||
            phoneStr == null || phoneStr.trim().isEmpty()) {

            request.setAttribute("msg", "Please fill all fields correctly.");
            request.getRequestDispatcher("msignup.jsp").forward(request, response);
            return;
        }

        ud.setUsername(username);
        ud.setPassword(password);
        ud.setAge(Integer.parseInt(ageStr));
        ud.setPhone(Long.parseLong(phoneStr));

        UserDAO dao = new UserDAO();
        try {
            boolean status = dao.insert(ud);
            if(status){
                response.sendRedirect("mlogin.jsp?msg=success");
            } else {
                request.setAttribute("msg", "Registration failed.");
                request.getRequestDispatcher("msignup.jsp").forward(request, response);
            }
        } catch(Exception e){
            request.setAttribute("msg", "Something went wrong!");
            request.getRequestDispatcher("msignup.jsp").forward(request, response);
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Signup - SNR Movies</title>

<!-- Bootstrap CDN -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
    body {
        background-color: #f7f7f7;
    }
</style>
</head>

<body class="d-flex justify-content-center align-items-center vh-100">

<div class="card shadow p-4" style="width: 380px;">
    
    <h3 class="text-center text-danger fw-bold mb-4">SNR MOVIES</h3>

    <% String msg = (String) request.getAttribute("msg");
       if(msg != null) { %>
        <div class="alert alert-danger text-center">
            <%= msg %>
        </div>
    <% } %>

    <form action="msignup.jsp" method="post">

        <div class="mb-3">
            <label class="form-label">Username</label>
            <input type="text" name="username" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Password</label>
            <input type="password" name="password" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Age</label>
            <input type="text" name="age" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Phone</label>
            <input type="text" name="phone" class="form-control" required>
        </div>

        <button type="submit" class="btn btn-danger w-100">Signup</button>
    </form>

    <p class="text-center mt-3">
        Already have an account?
        <a href="mlogin.jsp" class="text-danger fw-bold">Login</a>
    </p>

</div>

</body>
</html>
