package com.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.dto.MovieDTO;
import com.dto.ShowDTO;

public class MovieDAO {

	public Connection getConnection() throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/movie", "root", "root");
		return con;
	}

	
//1.Add movies	
	public boolean addMoive(MovieDTO md) throws ClassNotFoundException, SQLException {
		boolean status = true;
		Connection con = getConnection();
		String sql = "INSERT INTO movies(movie_name, language, duration) VALUES (?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, md.getMovieName());
		ps.setString(2, md.getLanguage());
		ps.setString(3, md.getDuration());

		int i = ps.executeUpdate();

		if (i > 0) {
			status = true;
		}

		return status;
	}
	
//2.Retrieving all movies into View Page 	
	public List<MovieDTO> getAllMovies() throws ClassNotFoundException, SQLException {
		 List<MovieDTO> movieList = new ArrayList<>();
		 
		 Connection con = getConnection(); 
		 String sql = "SELECT * FROM movies";
		 PreparedStatement ps = con.prepareStatement(sql);
		 ResultSet rs = ps.executeQuery();
		 while (rs.next()) {
             MovieDTO md = new MovieDTO();

             md.setMovieId(rs.getInt("movie_id"));
             md.setMovieName(rs.getString("movie_name"));
             md.setLanguage(rs.getString("language"));
             md.setDuration(rs.getString("duration"));

             movieList.add(md);
         }
		 rs.close();
         ps.close();
         con.close();
		
		return movieList;	
	}
	
//3.Delete the Moives Based on MoiveId
	
	public boolean deleteMovie(int movieId) throws ClassNotFoundException, SQLException {
	    boolean status = false;
	    String sql = "DELETE FROM movies WHERE movie_id = ?";

	     Connection con =getConnection();
	     PreparedStatement ps = con.prepareStatement(sql);

	        ps.setInt(1, movieId);
	        int rows = ps.executeUpdate();
	        if (rows > 0) {
	            status = true;
	        }
 
	    return status;
	}

 
// 4. Fetch shows for a specific movie
	    public List<ShowDTO> getShowsByMovieId(int movieId) throws Exception {
	        List<ShowDTO> shows = new ArrayList<>();
	        Connection con = getConnection();

	        String sql = "SELECT * FROM shows WHERE movie_id = ?";
	        PreparedStatement ps = con.prepareStatement(sql);
	        ps.setInt(1, movieId);
	        ResultSet rs = ps.executeQuery();

	        while (rs.next()) {
	            ShowDTO s = new ShowDTO();
	            s.setShowId(rs.getInt("show_id"));
	            s.setMovieId(rs.getInt("movie_id"));
	            s.setShowTime(rs.getString("show_time"));
	            s.setAvailableSeats(rs.getInt("available_seats"));

	            shows.add(s);
	        }
	        return shows;
	    }
	    
	    
//5 .Adding the Show in show table
	    public boolean addShow(int movieId, String showTime, int seats) throws Exception {
	        boolean status = false;
	        Connection con = getConnection();

	        String sql = "INSERT INTO shows(movie_id, show_time, available_seats) VALUES (?, ?, ?)";
	        PreparedStatement ps = con.prepareStatement(sql);

	        ps.setInt(1, movieId);
	        ps.setString(2, showTime);
	        ps.setInt(3, seats);

	        int i = ps.executeUpdate();
	        if (i > 0) {
	            status = true;
	        }

	        
	        con.close();
	        ps.close();
	        return status;
	         
	    }
		
}	


