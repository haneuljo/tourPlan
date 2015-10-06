package com.tour.controller;

import java.io.IOException;
import java.util.HashMap;
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

import com.tour.dao.PlanDAO;
import com.tour.dao.PlanInfoDAO;
import com.tour.dto.PlanDTO;
import com.tour.dto.PlanInfoDTO;
import com.tour.util.JSONResponseUtil;
import com.tour.util.SessionInfo;

@Controller("PlanInfoController")
public class PlanInfoController {
	
	String tourAPIKey = "sGR0LkYPdWBTkZqjRcwTe8AzAV9yoa3Qkl0Tq6y7eAf1AJL0YcsaWSv2kaDmBRWikYgT5czC1BZ2N7K13YcEfQ%3D%3D";
	
	@Autowired
	@Qualifier("PlanInfoDAO")
	PlanInfoDAO dao;
	
	@Autowired
	@Qualifier("PlanDAO")
	PlanDAO pdao;
	
	@RequestMapping("/newplan")
	public String newplan(HttpServletRequest req,HttpServletResponse res, Integer contentid) {
		
		
		return "plan/selPlan";
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
	
	//일정완료
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
	
	@RequestMapping("/planAdd")
	public String planAdd(PlanDTO pdto,HttpServletRequest req,HttpServletResponse res) {
	
		
		return "plan/planAdd";
	}
	
	//관광일정추가
	@RequestMapping("/planOk")
	public String planOk(PlanDTO pdto,String startDate,HttpServletRequest req,HttpServletResponse res) {
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("loginInfo");
		
		System.out.println(pdto.getTitle());
		System.out.println(startDate);
		
		pdto.setGroupNum(pdao.planMax()+1);
		pdto.setEmail(info.getEmail());
		
		pdao.planInsert(pdto);
		
		req.setAttribute("startDate", startDate);
		
		return "plan/newplan";
	}
	
	@RequestMapping("/myPlan")                                    //내일정보기
	public String myPlan(HttpServletRequest req) {
		
		int groupNum = 1;
		
		List<PlanInfoDTO> lists = dao.getLists(groupNum);
			
		req.setAttribute("lists", lists);
			
		return "plan/myPlan";
	}
	
	
	//------------------임시저장소관련---------------------
	
	
	public void insertInfoLists (HashMap<String, Object> hMap,HttpServletRequest req) {
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("loginInfo");  //세션에서 로그인정보가져오기
		
		List<HashMap<String, Object>> lists= info.getInfoList();
		
		lists.add(hMap);
		
		info.setInfoList(lists);
		
		session.setAttribute("loginInfo", info);
	}
	
	@RequestMapping("/startPlace")
	public String startPlace(HttpServletRequest req,HttpServletResponse res, Integer contentid) {
		
		
		return "plan/startPlace";
	}
	
	//dragTest
	
	@RequestMapping("/dragTest")
	public String dragTest(HttpServletRequest req,HttpServletResponse res, Integer contentid) {
		
		
		return "plan/dragTest";
	}
	
}
