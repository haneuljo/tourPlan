package com.tour.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
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
import org.springframework.http.ResponseEntity;
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
	
	
	//여행지 페이지 띄우기
	@RequestMapping("/travel")
	public String travel(HttpServletRequest req,HttpServletResponse res, Integer contentid) {
		
		
		return "clipBoard/travelMain";
	}
	
	//지역코드 API
	@RequestMapping("/areaCodeAPI")
	@ResponseBody
	public ResponseEntity<String> areaCodeAPI(HttpServletResponse response) throws IOException {

		String url = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaCode?listYN=Y&MobileOS=ETC&MobileApp=TourAPI2.0_Guide&_type=json&numOfRows=17&ServiceKey="
				+ tourAPIKey;

		JSONResponseUtil util = new JSONResponseUtil();
		return util.getJSONResponse(response, url);
	}
	
	//시구군 코드 API
	@RequestMapping("/sigunguCodeAPI")
	@ResponseBody
	public ResponseEntity<String> sigunguCodeAPI(HttpServletResponse response, Integer areaCode) throws IOException {
		
		String url = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaCode?listYN=Y&MobileOS=ETC&MobileApp=TourAPI2.0_Guide&_type=json&numOfRows=30&ServiceKey="
				+ tourAPIKey
				+ "&areaCode="+areaCode;
		
		JSONResponseUtil util = new JSONResponseUtil();
		return util.getJSONResponse(response, url);
	}
	
	//클립 Map
	@RequestMapping("/travelMap")
	public String travelMap(HttpServletRequest req,HttpServletResponse res, Integer contentid) {
			
		return "clipBoard/travelMap";
	}
	
	//clipCount해서 비교
	@RequestMapping("/clipCount")
	@ResponseBody
	public List<ClipBoardDTO> clipCount(HttpServletRequest req, HttpServletResponse resp,Integer areaCode, Integer sigugunCode) throws ParseException, IOException {
		
		System.out.println("areacode : "+areaCode);
		List<ClipBoardDTO> clipCountList= dao.clipCount();
		List<ClipBoardDTO> clipList= new ArrayList<ClipBoardDTO>();
		
		System.out.println("DB clipCount" + clipCountList.size());
		String url =
				"http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaBasedList?contentTypeId=12&areaCode="+areaCode+"&sigunguCode="+sigugunCode+"&cat1=A02&cat2=&cat3=&listYN=Y&MobileOS=ETC&MobileApp=TourAPI2.0_Guide&arrange=A&numOfRows=20&pageNo=1&_type=json&ServiceKey="
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
			int chk=0;
			JSONObject entity = (JSONObject) array.get(i);
			Long contentid = (Long) entity.get("contentid");

			System.out.println(i + "contentid:" + contentid);
		
			Iterator<ClipBoardDTO> it = clipCountList.iterator();
			while (it.hasNext()) {
				ClipBoardDTO dto = it.next();
				//System.out.println("여기까지?");
				if (contentid == dto.getContentid()) {
					
					dto.setFirstimage((String)entity.get("firstimage"));
					dto.setTitle((String)entity.get("title"));
					
				/*	if(entity.get("mapy") instanceof Double){
						
						System.out.println("double이야");
					}
					if(entity.get("mapy") instanceof String){
						
						System.out.println("String" + entity.get("mapy"));
					}*/
					if(entity.containsKey("mapx")){
						
						dto.setMapx(entity.get("mapx"));
						dto.setMapy(entity.get("mapy"));
						
					}
					dto.setAddr1((String)entity.get("addr1"));
					//System.out.println("클립 카운트 " + dto.getClipCount());
					chk=1;
					clipList.add(dto);
					break;

				}
			}
			if(chk==0){
				ClipBoardDTO dto = new ClipBoardDTO();
				dto.setFirstimage((String)entity.get("firstimage"));
				dto.setTitle((String)entity.get("title"));
				if(entity.containsKey("mapx")){
					
					dto.setMapx(entity.get("mapx"));
					dto.setMapy(entity.get("mapy"));
					
				}
				dto.setAddr1((String)entity.get("addr1"));
				dto.setContentid(Integer.parseInt(contentid.toString()));
				dto.setClipCount(0);
				clipList.add(dto);
			}
			
		}
		
		//clipList 정렬, clipCount 순으로?
		Collections.sort(clipList, new Comparator <ClipBoardDTO>() {

			@Override
			public int compare(ClipBoardDTO o1, ClipBoardDTO o2) {
				
				int count1 = o1.getClipCount();
				int count2 = o2.getClipCount();
				
				if(count1>count2){
					return -1;
					
				}else if(count1<count2){
					return 1;
					
				}else
					return 0;
			
			}
		});
		
		
			
		
		System.out.println(clipList.size());
		
		return clipList;
	}
	
	
	
	
	
		
}
