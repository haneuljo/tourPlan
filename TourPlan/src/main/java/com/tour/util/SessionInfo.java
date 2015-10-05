package com.tour.util;

import java.util.HashMap;
import java.util.List;

public class SessionInfo {
	private String email;
	private String profileImg;
	private List<HashMap<String, Object>> infoList;
	
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
	public List<HashMap<String, Object>> getInfoList() {
		return infoList;
	}
	public void setInfoList(List<HashMap<String, Object>> infoList) {
		this.infoList = infoList;
	}
	
	
	
	
}
