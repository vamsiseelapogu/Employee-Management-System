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
import com.dto.Employee;

 
@WebServlet("/signup")
public class SignupServlt extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
    public SignupServlt() {
    	
    }

	 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html");
        PrintWriter out= response.getWriter();
 
// 1 :giving req from html page to servlet
        
        String id=request.getParameter("id");
          int ID= Integer.parseInt(id);
        String fname=request.getParameter("fname");
        String lname=request.getParameter("lname");
        String uname=request.getParameter("uname");
        String pass=request.getParameter("pass");
        String phoneNo=request.getParameter("phone");
          long phone = Long.parseLong(phoneNo);
        String ages=request.getParameter("age"); 
          int age= Integer.parseInt(ages);
        String city=request.getParameter("city");
        String country =request.getParameter("country ");
        String Gender  =request.getParameter("Gender" );

//2 :set the data to DTO
        
        Employee e = new Employee();
        e.setId(ID);
        e.setFirstname(fname);
        e.setLastname(lname);
        e.setUsername(uname);
        e.setPassword(pass);
        e.setPhonenumber(phone);
        e.setAge(age);
        e.setCity(city);
        e.setCoutry(country);
        e.setGender(Gender);

//3  :DAO connecting mysql and stores the data into DB        
       EmployeeDAO ed = new EmployeeDAO();
       
	try {
		 boolean status = ed.createAccount(e);
		 if(status) {
			 out.println("<html>");
			
			 out.println("<body style='background-color: #e8f5e9; font-family: Arial;'>");
			    out.println("<div style='width:50%; margin:100px auto; padding:30px; "
			         + "background:white; border-radius:10px; box-shadow:0 0 10px gray; text-align:center;'>");

			         out.println("<h1 style='color:lightblue;'> Dear " + e.getFirstname() + " </h1>");
			         
			               out.println("<h2 style='color:#2e7d32;'>Account Created Successfully</h2>");
			               
			               out.println("<a href =\"ELogin.html\"> Login </a>");
			               

			     out.println("</div>");
			 out.println("</body>");
			 out.println("</html>");
;

	       }
	} catch (ClassNotFoundException | SQLException e1) {
		// TODO Auto-generated catch block
		e1.printStackTrace();
	}
       
       
	}

}
