package com.tour.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import com.tour.dto.PlanInfoDTO;

public class PlanInfoDAO {

	private SqlSessionTemplate sessionTemplate;

	public void setSessionTemplate(SqlSessionTemplate sessionTemplate) throws Exception{
		this.sessionTemplate = sessionTemplate;
	}	
	
	//�����������
	public void planInfoInsert(PlanInfoDTO dto) {
		
		sessionTemplate.insert("com.tour.planInfo.planInfoInsert", dto);
		
	}
	
	//planNum �ִ밪
	public int planInfoMax(){
		
		int result = sessionTemplate.selectOne("com.tour.planInfo.planInfoMax");
		
		return result;
	}
	
	//�����ҷ�����
	public List<PlanInfoDTO> getLists(int groupNum) {
		
		List<PlanInfoDTO> lists = sessionTemplate.selectList("com.tour.planInfo.getLists",groupNum);
		
		return lists;
	}
	

}
