package com.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.EmployeeDAO;
 
@WebServlet("/ELogin")
public class ELoginServlt extends HttpServlet {
	private static final long serialVersionUID = 1L;    
    
    public ELoginServlt() {
        
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html");
	    PrintWriter out= response.getWriter();
	    
	    String user = request.getParameter("username");
	    String pass = request.getParameter("password");
	    
	    EmployeeDAO ed = new EmployeeDAO();
	    try {
			boolean status=ed.validate(user,pass);

//Login 			
			if(status) {
				
				out.println("<html>");
				out.println("<body style='background-color:#e8f5e9; font-family:Arial; text-align:center;'>");

				out.println("<h1><b>Welcome User</b></h1>");

				out.println("<a href = \"view\"> Employee Details </a>");//view mentioned in ViewServlet
				out.println("</body>");
				out.println("</html>");
				
				 

			}
			

//Not Login			
			else {
				out.println("<html>");
				out.println("<body style='background-color:#fdecea; font-family:Arial; text-align:center;'>");

				out.println("<h1><b>Username & Password are InCorrect </b></h1>");
				out.println("<h2><b> try Agin </b></h2>");
				
				out.println("<h1><b> Go & signup </b></h1>");
				out.println("<a href =\"Esignup.html\"> Signup </a>");
				
				out.println("</body>");
				out.println("</html>");
			}
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    
	}

}
