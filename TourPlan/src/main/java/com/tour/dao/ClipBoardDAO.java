package com.tour.dao;

import java.util.HashMap;
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
	
	public List<ClipBoardDTO>  myclipList(String email){
		
		List<ClipBoardDTO> myclipList = sessionTemplate.selectList("com.tour.clipBoard.myclipList",email);
		
		return myclipList;

	}
	
	
	
	public int getMaxNum(){
		
		int result = 0;
		
		result = sessionTemplate.selectOne("com.tour.clipBoard.maxNum");
		
		return result;
		
	}
	
	public int getClipCount(int contentid){
		
		int result = 0;
		
		result = sessionTemplate.selectOne("com.tour.clipBoard.getClipCount", contentid);
		
		return result;
		
	}
	
	public int myClipCount(String email){
		
		int result = 0;
		
		result = sessionTemplate.selectOne("com.tour.clipBoard.myClipCount", email);
		
		
		//System.out.println(result);
		
		return result;
		
	}
	
	public void insertData(ClipBoardDTO dto){
		
		sessionTemplate.insert("com.tour.clipBoard.clipInsert",dto);
		
	}
	
	public int getClipChk(String email,int contentid){
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("email", email);
		params.put("contentid", contentid);
		
		int result =  sessionTemplate.selectOne("com.tour.clipBoard.myclip",params);
			
		
		return result;
		
	}
	
	public void deletedclip(String email,int contentid){
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		
		params.put("email", email);
		params.put("contentid", contentid);
		
		
		sessionTemplate.delete("com.tour.clipBoard.deletedclip",params);
		
		
	}
	
}
