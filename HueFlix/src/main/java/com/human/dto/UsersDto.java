package com.human.dto;

import java.util.Date;

public class UsersDto {
	public String userEmail;
	public String pw;
	public String nickname;
	public String profile_img;
	public int enabled;
	public Date regdate;
	
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getProfile_img() {
		return profile_img;
	}
	public void setProfile_img(String profile_img) {
		this.profile_img = profile_img;
	}
	public int getEnabled() {
		return enabled;
	}
	public void setEnabled(int enabled) {
		this.enabled = enabled;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	
	@Override
	public String toString() {
		return "UsersDto [userEmail=" + userEmail + ", pw=" + pw + ", nickname=" + nickname + ", profile_img="
				+ profile_img + ", enabled=" + enabled + ", regdate=" + regdate + "]";
	}
	
	
}
