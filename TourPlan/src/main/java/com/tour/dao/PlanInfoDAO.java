package com.tour.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import com.tour.dto.PlanInfoDTO;

public class PlanInfoDAO {

	private SqlSessionTemplate sessionTemplate;

	public void setSessionTemplate(SqlSessionTemplate sessionTemplate) throws Exception{
		this.sessionTemplate = sessionTemplate;
	}	
	
	//일정정보등록
	public void planInfoInsert(PlanInfoDTO dto) {
		
		sessionTemplate.insert("com.tour.planInfo.planInfoInsert", dto);
		
	}
	
	//일정정보등록  (hMAp)
	public void planInfoInsertForhMap(HashMap<String, Object> hMap) {
		System.out.println(hMap);
		sessionTemplate.insert("com.tour.planInfo.planInfoInsertForhMap", hMap);
		
	}
	
	//planNum 최대값
	public int planInfoMax(){
		
		int result = sessionTemplate.selectOne("com.tour.planInfo.planInfoMax");
		
		return result;
	}
	
	//groupNum 최대값
	public int planInfoGroupMax(){
		
		int result = sessionTemplate.selectOne("com.tour.planInfo.planInfoGroupMax");
		
		return result;
	}
	
	//일정불러오기
	public List<PlanInfoDTO> getLists(int groupNum) {
		
		List<PlanInfoDTO> lists = sessionTemplate.selectList("com.tour.planInfo.getLists",groupNum);
		
		return lists;
	}
	//마지막일정 컨텐트id뽑음.
	public Long getLastId(int groupNum) {
		
		Long contentid = sessionTemplate.selectOne("com.tour.planInfo.getLastId",groupNum);
		
		return contentid;
	}
	
	//출발설정의 startdate가져오기
	public String getStartDate(int groupNum) {
		
		String startDate = sessionTemplate.selectOne("com.tour.planInfo.getStartDate",groupNum);
		
		return startDate;
	}
	
	//출발설정의 출발정보가져오기
	public PlanInfoDTO getStartPlace(int groupNum) {
		
		PlanInfoDTO startPlace = sessionTemplate.selectOne("com.tour.planInfo.getStartPlace",groupNum);
		
		return startPlace;
	}
	
	//출발설정의 도착정보가져오기
	public PlanInfoDTO getSecondPlace(int groupNum) {
		
		PlanInfoDTO secondPlace = sessionTemplate.selectOne("com.tour.planInfo.getSecondPlace",groupNum);
		
		return secondPlace;
	}


}
