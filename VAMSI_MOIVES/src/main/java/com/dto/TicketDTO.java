package com.dto;

import java.sql.Timestamp;

public class TicketDTO {
	 int ticketId;
	 String username;
	 int movieId;
	 int showId;
     int seatsBooked;
     Timestamp bookingDate;

     
     // Additional fields for display (optional)
     private String movieName;
     private String showTime;
	 public int getTicketId() {
		 return ticketId;
	 }
	 public void setTicketId(int ticketId) {
		 this.ticketId = ticketId;
	 }
	 public String getUsername() {
		 return username;
	 }
	 public void setUsername(String username) {
		 this.username = username;
	 }
	 public int getMovieId() {
		 return movieId;
	 }
	 public void setMovieId(int movieId) {
		 this.movieId = movieId;
	 }
	 public int getShowId() {
		 return showId;
	 }
	 public void setShowId(int showId) {
		 this.showId = showId;
	 }
	 public int getSeatsBooked() {
		 return seatsBooked;
	 }
	 public void setSeatsBooked(int seatsBooked) {
		 this.seatsBooked = seatsBooked;
	 }
	 public Timestamp getBookingDate() {
		 return bookingDate;
	 }
	 public void setBookingDate(Timestamp bookingDate) {
		 this.bookingDate = bookingDate;
	 }
	 public String getMovieName() {
		 return movieName;
	 }
	 public void setMovieName(String movieName) {
		 this.movieName = movieName;
	 }
	 public String getShowTime() {
		 return showTime;
	 }
	 public void setShowTime(String showTime) {
		 this.showTime = showTime;
	 }
     
     
     
     
}
