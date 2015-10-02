package com.tour.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import com.tour.dto.ClipBoardDTO;

public class ClipBoardDAO {
	

	private SqlSessionTemplate sessionTemplate;

	public void setSessionTemplate(SqlSessionTemplate sessionTemplate) throws Exception{
		this.sessionTemplate = sessionTemplate;
	}	
	
	
	public List<ClipBoardDTO>  clipCount(){
		
		List<ClipBoardDTO> clipCountList = sessionTemplate.selectList("com.tour.clipBoard.clipCount");
		
		return clipCountList;

	}
	
}
