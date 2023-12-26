package com.human.dto;

public class AuthoritiesDto {
	public String userEmail;
	public String authority;
	
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public String getAuthority() {
		return authority;
	}
	public void setAuthority(String authority) {
		this.authority = authority;
	}
	
	@Override
	public String toString() {
		return "Authorities [userEmail=" + userEmail + ", authority=" + authority + "]";
	}
	
}
