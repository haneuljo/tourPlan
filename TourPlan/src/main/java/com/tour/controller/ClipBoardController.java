package com.tour.controller;

import java.io.IOException;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.tour.dao.ClipBoardDAO;
import com.tour.dto.ClipBoardDTO;
import com.tour.util.JSONResponseUtil;

@Controller("ClipBoardController")
public class ClipBoardController {

	@Autowired
	@Qualifier("ClipBoardDAO")
	ClipBoardDAO dao;
	
	@Autowired
	JSONResponseUtil jsonUtil;
	
	String tourAPIKey = "sGR0LkYPdWBTkZqjRcwTe8AzAV9yoa3Qkl0Tq6y7eAf1AJL0YcsaWSv2kaDmBRWikYgT5czC1BZ2N7K13YcEfQ%3D%3D";
	
	
	
	@RequestMapping("/clipCount")
	public String memberSign(HttpServletRequest req, HttpServletResponse resp ) throws ParseException, IOException {
		
		List<ClipBoardDTO> clipCountList= dao.clipCount();
		
		System.out.println("DB clipCount" + clipCountList.size());
		String url = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/searchKeyword?keyword=%EA%B2%BD%EB%B3%B5%EA%B6%81&areaCode=&sigunguCode=&cat1=&cat2=&cat3=&listYN=Y&MobileOS=ETC&MobileApp=TourAPI2.0_Guide&arrange=A&numOfRows=12&pageNo=1&ServiceKey="
					+tourAPIKey;
	
		JSONParser jsonparser = new JSONParser();
        JSONObject jsonobject = (JSONObject)jsonparser.parse(jsonUtil.getJSONResponseString(resp, url));
        JSONObject json =  (JSONObject) jsonobject.get("response");
        JSONObject jsonbody =  (JSONObject) json.get("body");
        JSONObject jsonitem =  (JSONObject) jsonbody.get("items");
        JSONArray array = (JSONArray)jsonitem.get("item");

        System.out.println(array.size());
		Iterator<ClipBoardDTO> it = clipCountList.iterator();
		
		
		while(it.hasNext()){
			
			ClipBoardDTO dto = new ClipBoardDTO();
			for(int i = 0 ; i < array.size(); i++){
				JSONObject entity = (JSONObject)array.get(i);
				int contentid =  (Integer) entity.get("contentid");
				
				if(contentid==dto.getContentid()){
					
					System.out.println("¤Ð¤Ð");
					
					
				}
	         }
		}
		return "redirect:/";
	}
	
	
	
	
	
		
}
