package com.tour.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tour.dao.PlanInfoDAO;
import com.tour.dto.PlanInfoDTO;
import com.tour.util.JSONResponseUtil;
import com.tour.util.SessionInfo;

@Controller("PlanInfoController")
public class PlanInfoController {
	
	String tourAPIKey = "sGR0LkYPdWBTkZqjRcwTe8AzAV9yoa3Qkl0Tq6y7eAf1AJL0YcsaWSv2kaDmBRWikYgT5czC1BZ2N7K13YcEfQ%3D%3D";
	
	@Autowired
	@Qualifier("PlanInfoDAO")
	PlanInfoDAO dao;
	
	@RequestMapping("/newplan")
	public String newplan(HttpServletRequest req,HttpServletResponse res, Integer contentid) {
		
		
		return "plan/newplan";
	}
	
	@RequestMapping("/choice")
	@ResponseBody
	public ResponseEntity<String> choice(HttpServletRequest req,HttpServletResponse res, Integer contentid,Integer areaCode) throws IOException{
		
		System.out.println(areaCode);
		String url = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaBasedList ?listYN=Y&MobileOS=ETC&MobileApp=TourAPI2.0_Guide&_type=json&numOfRows=30&ServiceKey="
				+ tourAPIKey
				+ "&areaCode="+areaCode;
				//+ "&contentid="+contentid;
		
		JSONResponseUtil util = new JSONResponseUtil();
		
		return util.getJSONResponse(res, url);
	}
	
	@RequestMapping("/register")
	public String register(PlanInfoDTO pdto,HttpServletRequest req,HttpServletResponse res, Integer contentid[],String sday[],String stime[],String eday[],String etime[]) {
		
			
		
		for(int i=0;i<contentid.length;i++){
			System.out.println("컨아이디:" + contentid[i]);
			String start = sday[i] +" " + stime[i];
			//String end = eday[i] + " " + etime[i];
			System.out.println("시작:" + start );
			//System.out.println("끝:" + end);
			
			pdto.setPlanNum(dao.planInfoMax()+1);
			pdto.setGroupNum(1);
			pdto.setContent("관광지");
			pdto.setStartDate(start);
			//pdto.setLongTime(end);
			pdto.setContentid(contentid[i]);
			pdto.setContenttypeid(12);
			
			dao.planInfoInsert(pdto);
		}
			
		return "plan/planInfo";
	}
	
	@RequestMapping("/myPlan")                                    //내일정보기
	public String myPlan(HttpServletRequest req) {
		
		int groupNum = 1;
		
		List<PlanInfoDTO> lists = dao.getLists(groupNum);
			
		req.setAttribute("lists", lists);
			
		return "plan/myPlan";
	}
	
	@RequestMapping("/myPlanTest")                                    //내일정보기
	public String myPlanTest(HttpServletRequest req) {
		
		forTest(req);
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("loginInfo");  //세션에서 로그인정보가져오기
		
		List<HashMap<String, Object>> lists= info.getInfoList();
			
		req.setAttribute("lists", lists);
			
		return "plan/myPlanTest";
	}
	
	
	//------------------임시저장소관련---------------------
	
	
	public void insertInfoLists (HashMap<String, Object> hMap,HttpServletRequest req) {              //로그인안했을시 에러남
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("loginInfo");  //세션에서 로그인정보가져오기
		List<HashMap<String, Object>> lists;
		
		if(info.getInfoList()==null){                                        
			lists = new  ArrayList<HashMap<String,Object>>();
			System.out.println("infolist is null");
		}else{
		lists = info.getInfoList();
		System.out.println("not null");
		}
		
		Iterator<HashMap<String, Object>> it = lists.iterator();
		HashMap<String, Object> dto = new HashMap<String, Object>();
		
		while(it.hasNext()){
			
			dto = (HashMap<String, Object>)it.next();
			System.out.println(dto.get("planNum"));
		}
		
		
		
		
		lists.add(hMap);
		
		info.setInfoList(lists);
		
		session.setAttribute("loginInfo", info);
	}
	
	public void forTest (HttpServletRequest req) {
		HashMap<String, Object> hMap = new HashMap<String, Object>();
		hMap.put("planNum", 1);
		hMap.put("groupNum", 1);
		hMap.put("contentid", 1);
		hMap.put("contenttypeid", 1);
		hMap.put("longTime",60);
		hMap.put("content", "111");
		hMap.put("startDate", "2015-10-1 00:00:00");
		
		insertInfoLists(hMap, req );
		
		HashMap<String, Object> hMap1 = new HashMap<String, Object>();
		hMap.put("planNum", 2);
		hMap.put("groupNum", 1);
		hMap.put("contentid", 2);
		hMap.put("contenttypeid", 2);
		hMap.put("longTime",60);
		hMap.put("content", "222");
		hMap.put("startDate", "2015-10-1 00:00:01");
		
		insertInfoLists(hMap1, req );
		
		HashMap<String, Object> hMap2 = new HashMap<String, Object>();
		hMap.put("planNum", 3);
		hMap.put("groupNum", 1);
		hMap.put("contentid", 3);
		hMap.put("contenttypeid", 3);
		hMap.put("longTime",60);
		hMap.put("content", "333");
		hMap.put("startDate", "2015-10-1 00:00:02");
		
		insertInfoLists(hMap2, req );
		
		
	}
}
