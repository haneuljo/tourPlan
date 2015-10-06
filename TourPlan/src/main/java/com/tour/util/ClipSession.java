package com.tour.util;


import net.sf.json.JSONObject;

public class ClipSession {
	
	private JSONObject clipList;
	private int totalPage;
	public JSONObject getClipList() {
		return clipList;
	}
	public void setClipList(JSONObject clipList) {
		this.clipList = clipList;
	}
	public int getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
}