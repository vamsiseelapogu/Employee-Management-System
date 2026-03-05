package com.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.EmployeeDAO;
import com.dto.Employee;

 
@WebServlet("/view")
public class ViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
     
    public ViewServlet() {
    }

	 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.setContentType("text/html");
        PrintWriter out	=response.getWriter();
		
        EmployeeDAO ed1 = new EmployeeDAO();
		try {
			List<Employee> empDetails =ed1.getEmpDetails();
			
			out.println("<html>");
			out.println("<body style='background-color: #e8f5e9; font-family: Arial;'>");
			out.println("<h1><b>Hii You can edit / delete Here</b></h1>");
			  out.println("<table border=1px>");
			  out.println(
					  "<th>ID</th>  <th>FirstName</th>  <th>LastName</th>  <th>Username</th>  <th>Password</th>  <th>Phone No</th>  <th>Age</th>  <th>City</th>  <th>Coutry</th> <th>Gender</th> <th>Edit</th>  <th>Delete</th> ");

			  //Looping the list of empdetails 
			  for(Employee e:empDetails) {
					out.println("<tr>"+
			                    "<td>"+e.getId()+"</td>"+
			                    "<td>"+e.getFirstname()+"</td>"+
			                    "<td>"+e.getLastname()+"</td>"+
			                    "<td>"+e.getUsername()+"</td>"+
			                    "<td>"+e.getPassword()+"</td>"+
			                    "<td>"+e.getPhonenumber()+"</td>"+
			                    "<td>"+e.getAge()+"</td>"+
			                    "<td>"+e.getCity()+"</td>"+
			                    "<td>"+e.getCoutry()+"</td>"+
			                    "<td>"+e.getGender()+"</td>"+
			                 //To edit and delete = Create a Link to those 2   
			                    "<td>"+"  <a href='EditServlet?id="+ e.getId() + "'>edit  </a>  "+"</td>"+ /*  ? → starts the query string in a URL
			                    		                                                                      id → the parameter name
                                                                                                               = → assigns a value to that parameter */
			                    "<td>"+"  <a href='DeleteServlet?id="+ e.getId()+"'>delete</a> "+"</td>"+
							    "</tr>");
				}
			  		   			  
			  out.println("</table>");
			out.println("</body>");
			out.println("</html>");
			
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

}
