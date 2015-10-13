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
	
	//�������
	public void planInsert(PlanDTO dto) {
		
		sessionTemplate.insert("com.tour.plan.planInsert", dto);
		
	}
	
	//groupNum �ִ밪
	public int planMax(){
		
		int result = sessionTemplate.selectOne("com.tour.plan.planMax");
		
		return result;
	}
	
	public int myPlanCount(String email){
		
		int result = 0;
		
		result = sessionTemplate.selectOne("com.tour.plan.myPlanCount", email);
		
		return result;
	}
		
	//���������� ������
	public List<PlanDTO> getMyPlan(String email){
		
		List<PlanDTO> lists = sessionTemplate.selectList("com.tour.plan.getMyPlan", email);
		
		return lists;
	}
	
}
