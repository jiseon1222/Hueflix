package com.human.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class BoardDto {
	private int bid;
	private String userName;
	private String bGroupKind;
	private String bTitle;
	private String bContent;
	@DateTimeFormat(pattern="yyyy-mm-dd'T'HH:mm")
	private Date bWriteTime;
	private int bHit;
	
	public BoardDto() {}

	@Override
	public String toString() {
		return "BoardDto [bid=" + bid + ", userName=" + userName + ", bGroupKind=" + bGroupKind + ", bTitle=" + bTitle
				+ ", bContent=" + bContent + ", bWriteTime=" + bWriteTime + ", bHit=" + bHit + "]";
	}

	public int getbid() {
		return bid;
	}

	public void setbid(int bid) {
		this.bid = bid;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getbGroupKind() {
		return bGroupKind;
	}

	public void setbGroupKind(String bGroupKind) {
		this.bGroupKind = bGroupKind;
	}

	public String getbTitle() {
		return bTitle;
	}

	public void setbTitle(String bTitle) {
		this.bTitle = bTitle;
	}

	public String getbContent() {
		return bContent;
	}

	public void setbContent(String bContent) {
		this.bContent = bContent;
	}

	public Date getbWriteTime() {
		return bWriteTime;
	}

	public void setbWriteTime(Date bWriteTime) {
		this.bWriteTime = bWriteTime;
	}

	public int getbHit() {
		return bHit;
	}

	public void setbHit(int bHit) {
		this.bHit = bHit;
	}

	
}