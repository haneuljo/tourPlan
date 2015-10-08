package com.tour.dto;

public class PlanInfoDTO {
	
	
	private Long contenttypeid, contentid;
	private int planNum, groupNum, longTime;
	private String content, startDate,title,addr1,addr2,firstimage,overview;
	Object mapx, mapy;
	
	
	public int getPlanNum() {
		return planNum;
	}
	public void setPlanNum(int planNum) {
		this.planNum = planNum;
	}
	public int getGroupNum() {
		return groupNum;
	}
	public void setGroupNum(int groupNum) {
		this.groupNum = groupNum;
	}
	public Long getContentid() {
		return contentid;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getAddr1() {
		return addr1;
	}
	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}
	public String getAddr2() {
		return addr2;
	}
	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}
	public String getFirstimage() {
		return firstimage;
	}
	public void setFirstimage(String firstimage) {
		this.firstimage = firstimage;
	}
	public String getOverview() {
		return overview;
	}
	public void setOverview(String overview) {
		this.overview = overview;
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
	public void setContentid(Long contentid) {
		this.contentid = contentid;
	}
	public long getContenttypeid() {
		return contenttypeid;
	}
	public void setContenttypeid(long contenttypeid) {
		this.contenttypeid = contenttypeid;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public int getLongTime() {
		return longTime;
	}
	public void setLongTime(int longTime) {
		this.longTime = longTime;
	}

	

}
