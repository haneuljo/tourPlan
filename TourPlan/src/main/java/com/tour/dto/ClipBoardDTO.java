package com.tour.dto;

public class ClipBoardDTO {
	
	int clipBoardNum, contentid, clipCount;
	String email, firstimage,title;
	
	
	public String getFirstimage() {
		return firstimage;
	}
	public void setFirstimage(String firstimage) {
		this.firstimage = firstimage;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getClipBoardNum() {
		return clipBoardNum;
	}
	public void setClipBoardNum(int clipBoardNum) {
		this.clipBoardNum = clipBoardNum;
	}
	public int getContentid() {
		return contentid;
	}
	public void setContentid(int contentid) {
		this.contentid = contentid;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getClipCount() {
		return clipCount;
	}
	public void setClipCount(int clipCount) {
		this.clipCount = clipCount;
	}

	
	
}
