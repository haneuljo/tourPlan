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
	
	//�����������
	public void planInfoInsert(PlanInfoDTO dto) {
		
		sessionTemplate.insert("com.tour.planInfo.planInfoInsert", dto);
		
	}
	
	//�����������  (hMAp)
	public void planInfoInsertForhMap(HashMap<String, Object> hMap) {
		System.out.println(hMap);
		sessionTemplate.insert("com.tour.planInfo.planInfoInsertForhMap", hMap);
		
	}
	
	//planNum �ִ밪
	public int planInfoMax(){
		
		int result = sessionTemplate.selectOne("com.tour.planInfo.planInfoMax");
		
		return result;
	}
	
	//groupNum �ִ밪
	public int planInfoGroupMax(){
		
		int result = sessionTemplate.selectOne("com.tour.planInfo.planInfoGroupMax");
		
		return result;
	}
	
	//�����ҷ�����
	public List<PlanInfoDTO> getLists(int groupNum) {
		
		List<PlanInfoDTO> lists = sessionTemplate.selectList("com.tour.planInfo.getLists",groupNum);
		
		return lists;
	}
	//���������� ����Ʈid����.
	public Long getLastId(int groupNum) {
		
		Long contentid = sessionTemplate.selectOne("com.tour.planInfo.getLastId",groupNum);
		
		return contentid;
	}
	
	//��߼����� startdate��������
	public String getStartDate(int groupNum) {
		
		String startDate = sessionTemplate.selectOne("com.tour.planInfo.getStartDate",groupNum);
		
		return startDate;
	}
	
	//��߼����� ���������������
	public PlanInfoDTO getStartPlace(int groupNum) {
		
		PlanInfoDTO startPlace = sessionTemplate.selectOne("com.tour.planInfo.getStartPlace",groupNum);
		
		return startPlace;
	}
	
	//��߼����� ����������������
	public PlanInfoDTO getSecondPlace(int groupNum) {
		
		PlanInfoDTO secondPlace = sessionTemplate.selectOne("com.tour.planInfo.getSecondPlace",groupNum);
		
		return secondPlace;
	}


}
