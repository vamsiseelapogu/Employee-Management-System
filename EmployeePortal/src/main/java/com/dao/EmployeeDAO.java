package com.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.dto.Employee;

public class EmployeeDAO {

	// 1. To connect with the DB

	public Connection connect() throws ClassNotFoundException, SQLException {

		Class.forName("com.mysql.cj.jdbc.Driver");

		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/batch65", "root", "root");
		return con;

	}

	// 2.Creating or inserting Data into DB
	public boolean createAccount(Employee e) throws ClassNotFoundException, SQLException {

		Connection con = connect();
		boolean status = false;

		// 3
		String sql = "insert into employeeinfo values(?,?,?,?,?,?,?,?,?,?)";
		PreparedStatement ps = con.prepareStatement(sql);

		// 4
		ps.setInt(1, e.getId());
		ps.setString(2, e.getFirstname());
		ps.setString(3, e.getLastname());
		ps.setString(4, e.getUsername());
		ps.setString(5, e.getPassword());
		ps.setLong(6, e.getPhonenumber());
		ps.setInt(7, e.getAge());
		ps.setString(8, e.getCity());
		ps.setString(9, e.getCoutry());
		ps.setString(10, e.getGender());

		// 5
		int i = ps.executeUpdate();

		if (i > 0) {  // i --> Returns no.of rows effected
			status = true;
		}

		// close resources
		ps.close();
		con.close();

		return status;

	}

	
	//4.Validate Login DATA
	public boolean validate(String user, String pass) throws ClassNotFoundException, SQLException {

		boolean status =false;
		Connection con = connect();

		String sql = "select * from employeeinfo where username=? and password=?";
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setString(1, user);
		ps.setString(2, pass);
		
	//	 status = ps.execute();
		
		ResultSet rs = ps.executeQuery();
		
		while(rs.next()) {
			status=true;
		}
		
		return status;
	}

	
//Retrieving all the emp Details	
	public List<Employee> getEmpDetails() throws ClassNotFoundException, SQLException {
		List<Employee> empdetails = new ArrayList<Employee>(); //Here empdetails is the return type so created an object  
		Connection con = connect();
		String sql="select * from employeeinfo";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs =ps.executeQuery();


		while(rs.next()) {

//Employee is DTO :We created emp object to transfer the data which comes from DB(employeeinfo table)					
			Employee emp = new Employee(); /*Very IMPORTANT : You must create the (DTO Object) inside the Loop*/
			emp.setId(rs.getInt(1));
			emp.setFirstname(rs.getString(2));
			emp.setLastname(rs.getString(3));
			emp.setUsername(rs.getString(4));
			emp.setPassword(rs.getString(5));
			emp.setPhonenumber(rs.getLong(6));
			emp.setAge(rs.getInt(7));
			emp.setCity(rs.getString(8));
			emp.setCoutry(rs.getString(9));
			emp.setGender(rs.getString(10));
			

			empdetails.add(emp);
		}
	
//empdetails list have no elements in beginning,so we are adding elements through emp object		

		return empdetails;

		
	}

//To edit emp details:	
	public Employee editEmpDetails(int id1) throws ClassNotFoundException, SQLException {
		Employee emp = new Employee();
		Connection con = connect();
		String sql= "select * from employeeinfo where id=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, id1);
		ResultSet rs =ps.executeQuery();
		
		while(rs.next()) {

						emp.setId(rs.getInt(1));
						emp.setFirstname(rs.getString(2));
						emp.setLastname(rs.getString(3));
						emp.setUsername(rs.getString(4));
						emp.setPassword(rs.getString(5));
						emp.setPhonenumber(rs.getLong(6));
						emp.setAge(rs.getInt(7));
						emp.setCity(rs.getString(8));
						emp.setCoutry(rs.getString(9));
						emp.setGender(rs.getString(10));	

					}		
		
		return emp;
	}

//Updating the Emp details	
	public boolean updateEmpDetails(Employee e) throws ClassNotFoundException, SQLException {
		boolean status = false;
	 
		Connection con = connect();
		String sql= "update employeeinfo set firstname=?,lastname=?,username=?,password=?,phonenumber=?,age=?,city=?, country=?, gender=?  where id=? ";
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setString(1, e.getFirstname());
		ps.setString(2, e.getLastname());
		ps.setString(3, e.getUsername());
		ps.setString(4, e.getPassword());
		ps.setLong  (5, e.getPhonenumber());
		ps.setInt   (6, e.getAge());
		ps.setString(7, e.getCity());
		ps.setString(8, e.getCoutry());
		ps.setString(9, e.getGender());
		ps.setInt   (10, e.getId());
		
		int i =ps.executeUpdate();
		
		if( i> 0) {
			status= true;
		}
		return status;
	}

	
//To delete emp details	
	public boolean deleteEmpByID(int id1) throws ClassNotFoundException, SQLException {
		boolean status=false;
		
		Connection con =connect();
		String sql="delete from employeeinfo where id=?";
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setInt(1, id1);
		int i=ps.executeUpdate();
		
		if (i > 0) {
			status = true;
		}
		
		return status;
		
	}


	 

}
