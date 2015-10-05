package com.tour.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.taglibs.standard.lang.jstl.Literal;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tour.dao.PlanInfoDAO;
import com.tour.dto.PlanInfoDTO;
import com.tour.util.JSONResponseUtil;

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
			String end = eday[i] + " " + etime[i];
			System.out.println("시작:" + start );
			System.out.println("끝:" + end);
			
			pdto.setPlanNum(dao.planInfoMax()+1);
			pdto.setGroupNum(1);
			pdto.setContent("관광지");
			pdto.setStartDate(start);
			pdto.setEndDate(end);
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
	
	public List<HashMap<String, String>> setLists () {
		
		HashMap<String, String> hMap;
		
		List<HashMap<String, String>> lists = null;
		
		return lists;
	}
}
