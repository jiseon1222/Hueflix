package com.human.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class CommentDto {
	private int rId;
	private int movieId;
	private String nickname;
	private String rContent;
	private double starScore;
	@DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
	private Date rWriteTime;
	public int getrId() {
		return rId;
	}
	public void setrId(int rId) {
		this.rId = rId;
	}
	public int getMovieId() {
		return movieId;
	}
	public void setMovieId(int movieId) {
		this.movieId = movieId;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getrContent() {
		return rContent;
	}
	public void setrContent(String rContent) {
		this.rContent = rContent;
	}
	public double getStarScore() {
		return starScore;
	}
	public void setStarScore(double starScore) {
		this.starScore = starScore;
	}
	public Date getrWriteTime() {
		return rWriteTime;
	}
	public void setrWriteTime(Date rWriteTime) {
		this.rWriteTime = rWriteTime;
	}
	@Override
	public String toString() {
		return "CommentDto [rId=" + rId + ", movieId=" + movieId + ", nickname=" + nickname + ", rContent=" + rContent
				+ ", starScore=" + starScore + ", rWriteTime=" + rWriteTime + "]";
	}
	
	


}
