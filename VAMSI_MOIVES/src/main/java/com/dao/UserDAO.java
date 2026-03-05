package com.dao;
import java.sql.Connection;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.dto.UserDTO;
public class UserDAO {
  
	 public Connection getConnection() throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/movie","root","root");
		 return con ;
	}
	 
	/* inserting user / admin details */ 
	public  boolean insert(UserDTO ud) throws ClassNotFoundException, SQLException {
		boolean status=false;
		
//9:Get database connection		
		Connection con =getConnection();

//10.SQL query		
		String sql="INSERT INTO users(username, password, role, age, phone_no) VALUES (?, ?, ? , ?, ?)";

//11: Prepare the SQL Statement			
		PreparedStatement ps = con.prepareStatement(sql);
		
//12.Set values to ?	
		ps.setString(1,ud.getUsername());
		ps.setString(2, ud.getPassword());
		ps.setString(3, ud.getRole());
		ps.setInt   (4, ud.getAge());
		ps.setLong  (5, ud.getPhone());
 
//13:Executes the INSERT query	
		int i = ps.executeUpdate();

//14:If at least one row is inserted		
		if(i>0) {
			status=true;
		}
		return status;
		 
	}
	
	
	
	
	
	public UserDTO validate(UserDTO ud) throws ClassNotFoundException, SQLException {
//6: Create a reference variable		
		UserDTO u=null;// Will store user details if login is successful
		
//7: Get Database Connection
		Connection con =getConnection();  

//8: Write SQL Query		
		//i) checks: username and password and gives user and role
		//ii)  Password is NOT fetched for security reason
		String sql="select username,role from users where username=? and password=?";

//9: Prepare the SQL Statement		
		PreparedStatement ps = con.prepareStatement(sql);

//10: Set values in ?		
		ps.setString(1, ud.getUsername()); // Set username value <- UI data
		ps.setString(2, ud.getPassword()); // Set password value <- UI data
 
//11: Execute the Query			
		ResultSet rs = ps.executeQuery();  // Execute query and get result

//12: Check if user exists	
		//i) true → user found → login success
	   //ii) false → no record → login failed
		if(rs.next()) {  

//13: Create new DTO 
		    //i) We return only required data 
		   //ii) Password is NOT returned
			u = new UserDTO();
			
//14: Set values to DTO from DB			
			u.setUsername(rs.getString("username")); 
			u.setRole(rs.getString("role")); 
		}

//15: Return result	
		//i) login success → returns UserDTO
		//ii) login failed → returns null
		return u ;
		
	}	
}
