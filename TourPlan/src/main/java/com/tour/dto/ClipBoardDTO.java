package com.tour.dto;

public class ClipBoardDTO {
	
	private int clipBoardNum, contentid, clipCount;
	private String email, firstimage,title, addr1;
	private Object mapx, mapy;
	
	public String getAddr1() {
		return addr1;
	}
	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}
	
	public Object getMapx() {
		return mapx;
	}
	public void setMapx(Object mapx) {
		this.mapx = mapx;
	}
	public Object getMapy() {
		return mapy;
	}
	public void setMapy(Object mapy) {
		this.mapy = mapy;
	}
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
