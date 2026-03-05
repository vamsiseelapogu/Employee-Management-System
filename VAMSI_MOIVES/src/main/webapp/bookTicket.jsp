<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.dao.TicketDAO,com.dto.TicketDTO" %>

<%
    // ================= Session Management =================
    String username = (String) session.getAttribute("username");
    if(username == null) {
        response.sendRedirect("mlogin.jsp"); // redirect to login if not logged in
        return;
    }

    // ================= Read movieId and showId from request =================
    int movieId = 0;
    int showId = 0;
    try {
        movieId = Integer.parseInt(request.getParameter("movieId"));
        showId = Integer.parseInt(request.getParameter("showId"));
    } catch(Exception e) {
        out.println("<p>Invalid movie or show selected!</p>");
        return;
    }

    String message = ""; // to store success/error message
    boolean isSuccess = false; // flag to control message color

    // ================= Handle form submission =================
    if(request.getMethod().equalsIgnoreCase("POST")) {
        try {
            int seatsBooked = Integer.parseInt(request.getParameter("seatsBooked"));
            if(seatsBooked <= 0) {
                message = "Please enter a valid number of seats!";
                isSuccess = false;
            } else {
                TicketDTO ticket = new TicketDTO();
                ticket.setUsername(username);
                ticket.setMovieId(movieId);
                ticket.setShowId(showId);
                ticket.setSeatsBooked(seatsBooked);

                TicketDAO ticketDAO = new TicketDAO();
                boolean booked = ticketDAO.insert(ticket);
                if(booked) {
                    message = "Ticket booked successfully! You booked " + seatsBooked + " seat" + (seatsBooked > 1 ? "s" : "") + ".";
                    isSuccess = true; // success message
                } else {
                    message = "Booking failed!";
                    isSuccess = false;
                }
            }
        } catch(Exception e) {
            message = "Error: " + e.getMessage();
            isSuccess = false;
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Book Ticket</title>
<style>
    body {
        font-family: Arial, Helvetica, sans-serif;
        background-color: #f2f2f2;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
    }

    .card {
        background-color: #fff;
        padding: 30px 40px;
        border-radius: 12px;
        box-shadow: 0 8px 25px rgba(0,0,0,0.2);
        width: 350px;
        text-align: center;
    }

    .card h2 {
        color: #ff4e50;
        margin-bottom: 20px;
        text-shadow: 1px 1px 2px rgba(0,0,0,0.2);
    }

    input[type="number"] {
        width: 80%;
        padding: 10px;
        margin: 15px 0;
        border: 1px solid #ccc;
        border-radius: 6px;
        font-size: 16px;
        transition: 0.3s;
    }

    input[type="number"]:focus {
        border-color: #ff4e50;
        box-shadow: 0 0 5px #ff4e50;
        outline: none;
    }

    input[type="submit"] {
        width: 85%;
        padding: 12px;
        background-color: #ff4e50;
        color: #fff;
        border: none;
        border-radius: 8px;
        font-size: 16px;
        cursor: pointer;
        transition: 0.3s;
        font-weight: bold;
    }

    input[type="submit"]:hover {
        background-color: #f9d423;
        color: #333;
    }

    .message {
        margin-bottom: 15px;
        font-weight: bold;
        color: <%= isSuccess ? "green" : "red" %>;
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

<div class="card">
    <h2>Book Ticket</h2>

    <% if(!message.isEmpty()) { %>
        <p class="message"><%= message %></p>
    <% } %>

    <form method="post">
        <input type="number" name="seatsBooked" min="1" placeholder="Enter number of seats" required><br>
        <input type="submit" value="Book Ticket">
    </form>

    <a href="shows.jsp?movieId=<%= movieId %>" class="back-link">⬅ Back to Shows</a>
</div>

</body>
</html>
