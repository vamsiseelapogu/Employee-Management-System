package com.dto;

public class ShowDTO {

      int showId;
      int movieId;
      String showTime;
      int availableSeats;
      
      
	  public int getShowId() {
		  return showId;
	  }
	  public void setShowId(int showId) {
		  this.showId = showId;
	  }
	  public int getMovieId() {
		  return movieId;
	  }
	  public void setMovieId(int movieId) {
		  this.movieId = movieId;
	  }
	  public String getShowTime() {
		  return showTime;
	  }
	  public void setShowTime(String showTime) {
		  this.showTime = showTime;
	  }
	  public int getAvailableSeats() {
		  return availableSeats;
	  }
	  public void setAvailableSeats(int availableSeats) {
		  this.availableSeats = availableSeats;
	  }
      
      

}
