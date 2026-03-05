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

@WebServlet("/EditServlet")
public class EditServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
      
    public EditServlet() {
    }

	 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		
		String id = request.getParameter("id");
		int id1=Integer.parseInt(id);
		
		EmployeeDAO dao= new EmployeeDAO();
		try {
			Employee e=dao.editEmpDetails(id1);
			
			out.println("<html>");
			out.println("<body bgcolor='D9F246'>");
			out.println("<form action='EditSubmitServlet' method='post'>");
			out.println("<table border=1px>");
			
			 
		    out.println(  "<tr><td>ID</td>"       + "<td> <input type='text'  name='id'    value='"+e.getId()         +"'readonly> </td></tr>"
			  		    + "<tr><td>FirstName</td>"+ "<td> <input type='text'  name='fname' value='"+e.getFirstname()  +"'> </td></tr>"
			  		    + "<tr><td>LastName</td>" + "<td> <input type='text'  name='lname' value='"+e.getLastname()   +"'> </td></tr>"
					    + "<tr><td>Username</td>" + "<td> <input type='text'  name='uname' value='"+e.getUsername()   +"'> </td></tr>"
			  	        + "<tr><td>Password</td>" + "<td> <input type='password'  name='pass'  value='"+e.getPassword()   +"'> </td></tr>"
			  		    + "<tr><td>Phone no</td>" + "<td> <input type='text'  name='phone' value='"+e.getPhonenumber()+"'> </td></tr>"
			            + "<tr><td>Age </td>"     + "<td> <input type='number'  name='age'   value='"+e.getAge()        +"'> </td></tr>"
			            + "<tr><td>City</td>"     + "<td> <input type='text'  name='city'  value='"+e.getCity()       +"'> </td></tr>"
			  		    + "<tr><td>Country</td>"  + "<td> <input type='text'  name='country' value='"+e.getCoutry()     +"'> </td></tr>"
			  		    + "<tr><td>Gender</td>"   + "<td> <input type='text'  name='gender' value='"+e.getGender()     +"'> </td></tr>");
			  
			out.println("<input type='submit' value='edit & submit'>");
			out.println("</table>");
			out.println("</form>");
			out.println("</body>");
			out.println("</html>");
			
			
			
		} catch (ClassNotFoundException | SQLException e) {
 			e.printStackTrace();
		}
		
	}

}
