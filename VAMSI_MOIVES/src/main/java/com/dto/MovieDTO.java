package com.dto;

import java.util.List;

public class MovieDTO {

     int movieId;
     String movieName;
     String language;
     String duration;
     
     List<ShowDTO> shows;
     
     
     
	 public List<ShowDTO> getShows() {
		return shows;
	}
	 public void setShows(List<ShowDTO> shows) {
		 this.shows = shows;
	 }
	 public int getMovieId() {
		 return movieId;
	 }
	 public void setMovieId(int movieId) {
		 this.movieId = movieId;
	 }
	 public String getMovieName() {
		 return movieName;
	 }
	 public void setMovieName(String movieName) {
		 this.movieName = movieName;
	 }
	 public String getLanguage() {
		 return language;
	 }
	 public void setLanguage(String language) {
		 this.language = language;
	 }
	 public String getDuration() {
		 return duration;
	 }
	 public void setDuration(String duration) {
		 this.duration = duration;
	 }
     
     
}
