package com.tour.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.bind.annotation.ResponseBody;

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
	@ResponseBody
	public List<ClipBoardDTO> clipCount(HttpServletRequest req, HttpServletResponse resp ) throws ParseException, IOException {
		
		List<ClipBoardDTO> clipCountList= dao.clipCount();
		List<ClipBoardDTO> clipList= new ArrayList<ClipBoardDTO>();
		
		
		System.out.println("DB clipCount" + clipCountList.size());
		String url =
				"http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaBasedList?contentTypeId=12&areaCode=1&sigunguCode=&cat1=A02&cat2=A0201&cat3=A02010100&listYN=Y&MobileOS=ETC&MobileApp=TourAPI2.0_Guide&arrange=A&numOfRows=12&pageNo=1&_type=json&ServiceKey="
					+tourAPIKey;
		System.out.println(url);
		JSONParser jsonparser = new JSONParser();
        JSONObject jsonobject = (JSONObject)jsonparser.parse(jsonUtil.getJSONResponseString(resp, url));
        JSONObject json =  (JSONObject) jsonobject.get("response");
        JSONObject jsonbody =  (JSONObject) json.get("body");
        JSONObject jsonitem =  (JSONObject) jsonbody.get("items");
        JSONArray array = (JSONArray)jsonitem.get("item");

        System.out.println(array.size());
		
		for (int i = 0; i < array.size(); i++) {
			
			JSONObject entity = (JSONObject) array.get(i);
			Long contentid = (Long) entity.get("contentid");

			System.out.println(i + "contentid:" + contentid);
		
			Iterator<ClipBoardDTO> it = clipCountList.iterator();
			while (it.hasNext()) {
				ClipBoardDTO dto = it.next();
				

				if (contentid == dto.getContentid()) {
					
					clipList.add(dto);
					break;

				}
			}
			
		}
		System.out.println(clipList.size());
		
		return clipList;
	}
	
	
	
	
	
		
}
