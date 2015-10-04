package com.tour.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import com.tour.dto.PlanDTO;

public class PlanDAO {
	

	private SqlSessionTemplate sessionTemplate;

	public void setSessionTemplate(SqlSessionTemplate sessionTemplate) throws Exception{
		this.sessionTemplate = sessionTemplate;
	}	
	
	//일정등록
	public void planInsert(PlanDTO dto) {
		
		sessionTemplate.insert("com.tour.plan.planInsert", dto);
		
	}
	
	//groupNum 최대값
	public int planMax(){
		
		int result = sessionTemplate.selectOne("com.tour.plan.planMax");
		
		return result;
	}
	
	
}
