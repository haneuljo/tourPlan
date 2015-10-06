package com.tour.util;

import java.util.ArrayList;
import java.util.HashMap;

public class SessionInfo {
	private String email;
	private String profileImg;
	private ArrayList<HashMap<String, Object>> infoList;
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getProfileImg() {
		return profileImg;
	}
	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
	}
	public ArrayList<HashMap<String, Object>> getInfoList() {
		return infoList;
	}
	public void setInfoList(ArrayList<HashMap<String, Object>> infoList) {
		this.infoList = infoList;
	}
	
	
	
	
}
