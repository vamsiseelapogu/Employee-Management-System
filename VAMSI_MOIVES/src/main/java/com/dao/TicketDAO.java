package com.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.dto.TicketDTO;

public class TicketDAO {
	  
    public Connection getConnection() throws ClassNotFoundException, SQLException {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/movie","root","root");
			 return con ;
    }
	
	
    
    
    
    
 // Insert a new ticket booking 
 public boolean insert(TicketDTO ticket) throws SQLException, ClassNotFoundException {
     boolean status = false;
     
        Connection con =getConnection();
        String sql = "INSERT INTO tickets (username, movie_id, show_id, seats_booked) VALUES (?, ?, ?, ?)";
        
             PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, ticket.getUsername());
            ps.setInt(2, ticket.getMovieId());
            ps.setInt(3, ticket.getShowId());
            ps.setInt(4, ticket.getSeatsBooked());

            int rows = ps.executeUpdate();
            if (rows > 0) {
                status = true;
            }
        
           con.close();
           ps.close();
        return status;
    }

	
}
