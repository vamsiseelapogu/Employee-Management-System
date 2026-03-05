<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.dto.UserDTO, com.dao.UserDAO" %>

<%
    // ===== Login Validation Logic =====
    String method = request.getMethod();
    if("POST".equalsIgnoreCase(method)) {
        String user = request.getParameter("username");
        String pass = request.getParameter("password");

        if(user != null && pass != null) {
            UserDTO ud = new UserDTO();
            ud.setUsername(user);
            ud.setPassword(pass);

            UserDAO dao = new UserDAO();
            UserDTO loggeduser = dao.validate(ud);

            if(loggeduser != null) {
                // Create session attributes
                session.setAttribute("username", loggeduser.getUsername());
                session.setAttribute("role", loggeduser.getRole());

                // Role-based redirection
                if("admin".equalsIgnoreCase(loggeduser.getRole())) {
                    response.sendRedirect("adminHome.jsp");
                } else {
                    response.sendRedirect("userHome.jsp");
                }
                return;
            } else {
                // Invalid login
                request.setAttribute("error", "Invalid Username or Password!");
            }
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login - SNR Movies</title>
<style>
    /* ===== Body Styling ===== */
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        margin: 0;
        height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
        /* Background image using JSP context path */
        background: url('<%=request.getContextPath()%>/images/movieTheater.jpg') no-repeat center center fixed;
        background-size: cover;
        position: relative;
    }

    /* ===== Overlay to dim the background ===== */
    body::before {
        content: "";
        position: absolute;
        top: 0; left: 0;
        width: 100%; height: 100%;
        background-color: rgba(0, 0, 0, 0.5);
        z-index: 0;
    }

    /* ===== Login Card ===== */
    .login-card {
        position: relative;
        z-index: 1; /* above overlay */
        background: rgba(255, 255, 255, 0.95);
        padding: 40px 50px;
        border-radius: 15px;
        box-shadow: 0 8px 25px rgba(0,0,0,0.3);
        width: 350px;
        text-align: center;
        animation: fadeIn 1s ease-in-out;
    }

    /* ===== Card Animations ===== */
    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(-20px); }
        to { opacity: 1; transform: translateY(0); }
    }

    /* ===== Headings ===== */
    .login-card h1 {
        color: #333;
        margin-bottom: 15px;
        font-size: 28px;
    }

    .login-card h2 {
        color: #555;
        margin-bottom: 25px;
    }

    /* ===== Input Fields ===== */
    .login-card input[type="text"], 
    .login-card input[type="password"] {
        width: 100%;
        padding: 12px 15px;
        margin: 10px 0 20px 0;
        border: 1px solid #ccc;
        border-radius: 8px;
        font-size: 16px;
        transition: 0.3s;
    }

    .login-card input[type="text"]:focus,
    .login-card input[type="password"]:focus {
        border-color: #ff4e50;
        box-shadow: 0 0 5px #ff4e50;
        outline: none;
    }

    /* ===== Submit Button ===== */
    .login-card input[type="submit"] {
        width: 100%;
        padding: 12px;
        background: #ff4e50;
        border: none;
        color: white;
        font-size: 18px;
        border-radius: 8px;
        cursor: pointer;
        transition: 0.3s;
    }

    .login-card input[type="submit"]:hover {
        background: #f9d423;
        color: #333;
        box-shadow: 0 0 10px #f9d423;
    }

    /* ===== Links ===== */
    .login-card a {
        text-decoration: none;
        color: #ff4e50;
        font-weight: bold;
        transition: 0.3s;
    }

    .login-card a:hover {
        color: #f9d423;
    }

    /* ===== Messages ===== */
    .success-msg {
        color: green;
        margin-bottom: 15px;
    }
    .error-msg {
        color: red;
        margin-bottom: 15px;
    }

</style>
</head>
<body>

<div class="login-card">
    <h1>SNR Movies</h1>
    <h2>Login</h2>

    <!-- Success message after signup -->
    <%
        String msg = request.getParameter("msg");
        if("success".equals(msg)) {
    %>
        <p class="success-msg">Signup successful! Please login.</p>
    <%
        }
    %>

    <!-- Error message if login failed -->
    <%
        String error = (String) request.getAttribute("error");
        if(error != null) {
    %>
        <p class="error-msg"><%= error %></p>
    <% } %>

    <!-- Login Form -->
    <form action="mlogin.jsp" method="post">
        <input type="text" name="username" placeholder="Username" required>
        <input type="password" name="password" placeholder="Password" required>
        <input type="submit" value="Login">
    </form>

    <p>New to SNR Movies? <a href="msignup.jsp">Sign Up</a></p>
</div>

</body>
</html>
