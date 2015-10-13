package com.tour.util;

import com.tour.dto.PlanInfoDTO;

public class GroupSession {
	
	private int groupNum;
	private String startDate;
	private Object mapx, mapy;
	private PlanInfoDTO sdto,edto;
	private String title;
	
	public int getGroupNum() {
		return groupNum;
	}

	public void setGroupNum(int groupNum) {
		this.groupNum = groupNum;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
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

	public PlanInfoDTO getSdto() {
		return sdto;
	}

	public void setSdto(PlanInfoDTO sdto) {
		this.sdto = sdto;
	}

	public PlanInfoDTO getEdto() {
		return edto;
	}

	public void setEdto(PlanInfoDTO edto) {
		this.edto = edto;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
}
