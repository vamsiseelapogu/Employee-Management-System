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


@WebServlet("/EditSubmitServlet")
public class EditSubmitServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
  
    public EditSubmitServlet() {
    	
    }

	 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html");
        PrintWriter out= response.getWriter();
 
// 1 :Coming req from EditServlet page to EditSubmitServlet :
        
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
        String country =request.getParameter("country");
        String Gender  =request.getParameter("gender");

  //all edit details we need to set to emp object(DTO) 
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
        
        EmployeeDAO ed = new EmployeeDAO();
 
         try {
			boolean status =ed.updateEmpDetails(e);  //So we are passing e object
			
			if(status) {
				response.sendRedirect("view");
			}else {
				out.println("<html>");
				out.println("<body bgcolor='#F4C2C2'>");
				
				out.println("<h1><b>Sorry we are unable to Process Your Request <b><h1>");
				out.println("<h1><b>Try Again <b><h1>");
				
				out.println("</body>");
				out.println("</html>");
			}
		} catch (ClassNotFoundException | SQLException e1) {
			e1.printStackTrace();
		} 
                 
	}

}
