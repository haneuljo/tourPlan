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
	
	public List<ClipBoardDTO>  myclip(String email){
		
		List<ClipBoardDTO> myClipList = sessionTemplate.selectList("com.tour.clipBoard.myclip",email);
		
		return myClipList;

	}
	
	public int getMaxNum(){
		
		int result = 0;
		
		result = sessionTemplate.selectOne("com.tour.clipBoard.maxNum");
		
		return result;
		
	}
	
	public void insertData(ClipBoardDTO dto){
		
		sessionTemplate.insert("com.tour.clipBoard.clipInsert",dto);
		
	}
	
}
