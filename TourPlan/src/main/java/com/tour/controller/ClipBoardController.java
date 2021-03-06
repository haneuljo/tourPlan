package com.tour.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


import com.tour.dao.ClipBoardDAO;
import com.tour.dto.ArticleDTO;
import com.tour.dto.ClipBoardDTO;

import com.tour.util.ClipSession;

import com.tour.util.JSONResponseUtil;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import com.tour.util.SessionInfo;
//import net.sf.json.*;

@Controller("ClipBoardController")
public class ClipBoardController {

	@Autowired
	@Qualifier("ClipBoardDAO")
	ClipBoardDAO dao;

	@Autowired
	JSONResponseUtil jsonUtil;

	String tourAPIKey = "GuzaHzXNprs4fLYjtHtDrHm56KNX9GWdRELzkuqPUELlWBjOtuW%2BygZfhgEuZI2ZbU4se3cn2AFfyfQJM%2BhG3Q%3D%3D";
	
	@RequestMapping("/travel")
	public String travel(HttpServletRequest req, HttpServletResponse res, Integer contentid) {

		return "travelMain";
	}

	//지역코드 API
	@RequestMapping("/areaCodeAPI")
	@ResponseBody
	public ResponseEntity<String> areaCodeAPI(HttpServletResponse response) throws IOException {

		String url = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaCode?listYN=Y&MobileOS=ETC&MobileApp=TourAPI2.0_Guide&_type=json&numOfRows=17&ServiceKey="
				+ tourAPIKey;
		return jsonUtil.getJSONResponse(response, url);
	}

	//시구군코드
	@RequestMapping("/sigunguCodeAPI")
	@ResponseBody
	public ResponseEntity<String> sigunguCodeAPI(HttpServletResponse response, Integer areaCode) throws IOException {

		String url = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaCode?listYN=Y&MobileOS=ETC&MobileApp=TourAPI2.0_Guide&_type=json&numOfRows=30&ServiceKey="
				+ tourAPIKey + "&areaCode=" + areaCode;

		return jsonUtil.getJSONResponse(response, url);
	}

	@RequestMapping("/clipLike")
	public String clipLike(ClipBoardDTO dto,HttpServletRequest req, HttpServletResponse response,Integer contentid){
	
		HttpSession session = req.getSession();
		
		SessionInfo info = (SessionInfo)session.getAttribute("loginInfo");
		System.out.println(contentid);
		
		int clipBoardNum = dao.getMaxNum();
		dto.setClipBoardNum(clipBoardNum + 1);
		dto.setEmail(info.getEmail());
		dto.setContentid(contentid);
		
		dao.insertData(dto);
		
		return "redirect:/clipArticle?contentid="+contentid;
		
	}
	
	@RequestMapping("/clipArticle")
	public String article(HttpServletRequest req,HttpServletResponse resp, Integer contentid) throws ParseException, IOException {
		
		HttpSession session = req.getSession();
		
		SessionInfo info = (SessionInfo)session.getAttribute("loginInfo");		
		
		ArticleDTO adto = new ArticleDTO();
		System.out.println(contentid);
		
		int cCount = dao.getClipCount(contentid);
		System.out.println("cCount : "+ cCount);
		
		int clipchk = dao.getClipChk(info.getEmail(), contentid);
		System.out.println("clipchk" +clipchk);
		
		String url =
				"http://api.visitkorea.or.kr/openapi/service/rest/KorService/detailCommon?contentId="+contentid+"&defaultYN=Y&addrinfoYN=Y&mapinfoYN=Y&firstImageYN=Y&overviewYN=Y&MobileOS=ETC&MobileApp=AppTesting&_type=json&ServiceKey="
					+tourAPIKey;
		
		JSONParser jsonparser = new JSONParser();
        JSONObject jsonobject = (JSONObject)jsonparser.parse(jsonUtil.getJSONResponseString(resp, url));
        JSONObject json =  (JSONObject) jsonobject.get("response");
        JSONObject jsonbody =  (JSONObject) json.get("body");
        JSONObject jsonitem =  (JSONObject) jsonbody.get("items");
        JSONObject array = (JSONObject)jsonitem.get("item");
        
		
        adto.setTitle((String) array.get("title"));
        adto.setAddr1((String) array.get("addr1"));
        adto.setAddr2((String) array.get("addr2"));
        System.out.println("Addr2 : "+(String) array.get("addr2"));
        adto.setContentid(contentid);
        adto.setFirstimage((String) array.get("firstimage"));
        adto.setOverview((String) array.get("overview"));
        
        	if(array.containsKey("mapx")){
			
			adto.setMapx(array.get("mapx"));
			adto.setMapy(array.get("mapy"));
			
        	}
		
		
        req.setAttribute("adto", adto);
        req.setAttribute("cCount", cCount);
        req.setAttribute("clipchk", clipchk);
		
		return "clipArticle";
		
		
	}
	
	@RequestMapping("/deletedClip")
	public String deletedclip(HttpServletRequest req, HttpServletResponse res, Integer contentid) {

		HttpSession session = req.getSession();

		SessionInfo info = (SessionInfo) session.getAttribute("loginInfo");

		dao.deletedclip(info.getEmail(), contentid);

		req.setAttribute("contentid", contentid);

		return "redirect:/clipArticle?contentid=" + contentid;
	}

		
	@RequestMapping("/myClip")
	public String myClip(HttpServletRequest req, HttpServletResponse resp) throws ParseException, IOException {
		
		HttpSession session = req.getSession();
		
		SessionInfo info = (SessionInfo)session.getAttribute("loginInfo");
		
		//String email=info.getEmail();
		
		System.out.println("email : " + info.getEmail());
		
		System.out.println(dao.myClipCount(info.getEmail()));
		int myClipCount = dao.myClipCount(info.getEmail());
		
		List<ClipBoardDTO> myClipList= dao.myclipList(info.getEmail());
		List<ClipBoardDTO> clipList= new ArrayList<ClipBoardDTO>();
		
		
			Iterator<ClipBoardDTO> it = myClipList.iterator();
			while (it.hasNext()) {
				ClipBoardDTO dto = it.next();
				System.out.println(dto.getContentid());
				
				String url =
						"http://api.visitkorea.or.kr/openapi/service/rest/KorService/detailCommon?contentId="+dto.getContentid()+"&defaultYN=Y&addrinfoYN=Y&mapinfoYN=Y&firstImageYN=Y&overviewYN=Y&MobileOS=ETC&MobileApp=AppTesting&_type=json&ServiceKey="
							+tourAPIKey;
				
				JSONParser jsonparser = new JSONParser();
		        JSONObject jsonobject = (JSONObject)jsonparser.parse(jsonUtil.getJSONResponseString(resp, url));
		        JSONObject json =  (JSONObject) jsonobject.get("response");
		        JSONObject jsonbody =  (JSONObject) json.get("body");
		        JSONObject jsonitem =  (JSONObject) jsonbody.get("items");
		        JSONObject array = (JSONObject)jsonitem.get("item");
		        
		        dto.setFirstimage((String)array.get("firstimage"));
		        dto.setTitle((String)array.get("title"));
		        
		        clipList.add(dto);
				
			}
			
		
		
		req.setAttribute("myClipCount", myClipCount);
		req.setAttribute("clipList", clipList);
				
		
		System.out.println(clipList.size());
		
		return "myClip";
	}
		

	//Ŭ�� Map
	@RequestMapping("/travelMap")
	public String travelMap(HttpServletRequest req, HttpServletResponse res, Integer contentid) {

		return "clipBoard/travelMap";
	}

	
	//clipCount�ؼ� ��
	@RequestMapping("/clipCount")
	@ResponseBody
	public List<ClipBoardDTO> clipCount(HttpServletRequest req, HttpServletResponse resp,Integer areaCode, Integer sigunguCode, Integer mapChk, Integer contentTypeId) throws ParseException, IOException {
		
		//DB - contentid �� clipCount
		List<ClipBoardDTO> clipCountList = dao.clipCount();
		
		List<ClipBoardDTO> clipList = new ArrayList<ClipBoardDTO>();
		

		// System.out.println("DB clipCount" + clipCountList.size());
		String url = "";
		if(contentTypeId==null){
			contentTypeId=12;
		}

		String cat1="";
		
		switch (contentTypeId) {
		case 12:
			cat1="A02";
			break;
		case 32:
			cat1="B02";
			break;
		case 38:
			cat1="A04";
			break;
		case 39:
			cat1="A05";
			break;
		}

		/*관광지 : 인문 ; A02
		쇼핑 A04
		음식점 A05
		숙박 B02
		관광지	12
		문화시설	14
		행사/공연/축제	15
		여행코스	25
		레포츠	28
		숙박	32
		쇼핑	38
		음식점	39
		*/
		if (sigunguCode == 0) {
			url = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaBasedList?contentTypeId="+contentTypeId+"&areaCode="
					+ areaCode
					+ "&sigunguCode=&cat1="+cat1+"&cat2=&cat3=&listYN=Y&MobileOS=ETC&MobileApp=TourAPI2.0_Guide&arrange=A&numOfRows=400&pageNo=1&_type=json&ServiceKey=";
		} else {
			url = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaBasedList?contentTypeId="+contentTypeId+"&areaCode="
					+ areaCode + "&sigunguCode=" + sigunguCode
					+ "&cat1="+cat1+"&cat2=&cat3=&listYN=Y&MobileOS=ETC&MobileApp=TourAPI2.0_Guide&arrange=A&numOfRows=400&pageNo=1&_type=json&ServiceKey=";
		}
		url = url + tourAPIKey;

		System.out.println(url);

		JSONParser jsonparser = new JSONParser();
		JSONObject jsonobject = (JSONObject) jsonparser.parse(jsonUtil.getJSONResponseString(resp, url));
		JSONObject json = (JSONObject) jsonobject.get("response");
		JSONObject jsonbody = (JSONObject) json.get("body");
		JSONObject jsonitem = (JSONObject) jsonbody.get("items");
		JSONArray array = (JSONArray) jsonitem.get("item");

		// System.out.println(array.size());

		for (int i = 0; i < array.size(); i++) {
			int chk = 0;
			JSONObject entity = (JSONObject) array.get(i);
			Long contentid = (Long) entity.get("contentid");

			Iterator<ClipBoardDTO> it = clipCountList.iterator();

			while (it.hasNext()) {
				ClipBoardDTO dto = it.next();
				// System.out.println("�������?");
				if (contentid == dto.getContentid()) {

					dto.setFirstimage((String) entity.get("firstimage"));
					dto.setTitle((String) entity.get("title"));

					if (entity.containsKey("mapx")) {

						dto.setMapx(entity.get("mapx"));
						dto.setMapy(entity.get("mapy"));

					}
					dto.setAddr1((String) entity.get("addr1"));
					// System.out.println("Ŭ�� ī��Ʈ " + dto.getClipCount());
					chk = 1;
					clipList.add(dto);
					break;

				}
			}
			// List�κ�
			if (mapChk == 0) {

				if (chk == 0) {
					ClipBoardDTO dto = new ClipBoardDTO();
					dto.setFirstimage((String) entity.get("firstimage"));
					dto.setTitle((String) entity.get("title"));
					if (entity.containsKey("mapx")) {

						dto.setMapx(entity.get("mapx"));
						dto.setMapy(entity.get("mapy"));

					}
					dto.setAddr1((String) entity.get("addr1"));
					dto.setContentid(Integer.parseInt(contentid.toString()));
					dto.setClipCount(0);
					clipList.add(dto);
				}

			}

		}

		// clipList ����, clipCount ������?
		Collections.sort(clipList, new Comparator<ClipBoardDTO>() {

			@Override
			public int compare(ClipBoardDTO o1, ClipBoardDTO o2) {

				int count1 = o1.getClipCount();
				int count2 = o2.getClipCount();

				if (count1 > count2) {
					return -1;

				} else if (count1 < count2) {
					return 1;

				} else
					return 0;

			}
		});
		
		return clipList;

	}

	@ResponseBody
	@RequestMapping("/travelMain")
	public ResponseEntity<String> travelMain(HttpServletRequest req, HttpServletResponse resp, Integer areaCode, Integer sigunguCode, Integer page) throws ParseException, IOException {

		//System.out.println(clipList.size());
		//ù �������϶� session��
		if(page==1){
			List<ClipBoardDTO> clipList = clipCount(req, resp, areaCode, sigunguCode, 0, null);
			jsonUtil.clipPage(clipList, req);
			
		}

		HttpSession session = req.getSession();
		ClipSession clipSession = (ClipSession) session.getAttribute("clipJSON");
		net.sf.json.JSONObject jsonObj = clipSession.getClipList();

		//System.out.println(jsonObj.toString());
		
		JSONParser jsonparser = new JSONParser();
		JSONObject jsonobject = (JSONObject) jsonparser.parse(jsonObj.toString());
		JSONObject json = (JSONObject) jsonobject.get("body");
		JSONArray jsonItems = (JSONArray) json.get("items");

		JSONObject jsonPage = (JSONObject) jsonItems.get(page - 1);
		//System.out.println(jsonPage.get("page"));
		JSONArray jsonItem = (JSONArray) jsonPage.get("item");
		
		
		//System.out.println(jsonItem.toString());
		

		HttpHeaders responseHeaders = new HttpHeaders();

		responseHeaders.add("Content-Type", "text/html; charset=UTF-8");
		// System.out.println(buffer.toString());
		return new ResponseEntity<String>(jsonItem.toString(), responseHeaders, HttpStatus.CREATED);

	}

	

	@ResponseBody
	@RequestMapping("/travelMapClipCount")
	private List<ClipBoardDTO> travelMap(HttpServletRequest req,HttpServletResponse resp, Integer areaCode, Integer sigunguCode, Integer contentTypeId) throws ParseException, IOException{
		// TODO Auto-generated method stub
		return clipCount(req, resp, areaCode, sigunguCode, 1, contentTypeId);
	}

}
