package com.tour.dao;

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
	
	//planNum 최대값
	public int planInfoMax(){
		
		int result = sessionTemplate.selectOne("com.tour.planInfo.planInfoMax");
		
		return result;
	}
	
	//일정불러오기
	public List<PlanInfoDTO> getLists(int groupNum) {
		
		List<PlanInfoDTO> lists = sessionTemplate.selectList("com.tour.planInfo.getLists",groupNum);
		
		return lists;
	}
	

}
