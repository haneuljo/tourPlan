package com.tour.controller;


import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import javax.servlet.http.HttpServletRequest;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tour.dao.PlanDAO;

import com.tour.dto.MemberDTO;
import com.tour.dto.PlanDTO;
import com.tour.util.JSONResponseUtil;
import com.tour.util.SessionInfo;


@Controller("PlanController")
public class PlanController {
	
	@Autowired
	@Qualifier("PlanDAO")
	PlanDAO dao;
	
	@Autowired
	JSONResponseUtil jsonUtil;

	
	String tourAPIKey = "sGR0LkYPdWBTkZqjRcwTe8AzAV9yoa3Qkl0Tq6y7eAf1AJL0YcsaWSv2kaDmBRWikYgT5czC1BZ2N7K13YcEfQ%3D%3D";
	
	@RequestMapping("/planInfo")
	public String planInfo(HttpServletRequest req) {
		
		return "planInfo";
	}

	@RequestMapping("search")
	public String search() {
		
		return "plan/search";
	}
	
	//지역코드 API
	@RequestMapping("/areaCodeAPI1")
	@ResponseBody
	public ResponseEntity<String> areaCodeAPI(HttpServletResponse response) throws IOException {

		String url = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaCode?listYN=Y&MobileOS=ETC&MobileApp=TourAPI2.0_Guide&_type=json&numOfRows=17&ServiceKey="
				+ tourAPIKey;

		return jsonUtil.getJSONResponse(response, url);
	}

	@RequestMapping("/sigunguCodeAPI1")
	@ResponseBody
	public ResponseEntity<String> sigunguCodeAPI(HttpServletResponse response, Integer areaCode) throws IOException {

		String url = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaCode?listYN=Y&MobileOS=ETC&MobileApp=TourAPI2.0_Guide&_type=json&numOfRows=30&ServiceKey="
				+ tourAPIKey + "&areaCode=" + areaCode;

		return jsonUtil.getJSONResponse(response, url);
	}

	@RequestMapping("/searchStayAPI")
	@ResponseBody
	public ResponseEntity<String> searchStayAPI(HttpServletResponse response, Integer areaCode, Integer sigunguCode)
			throws IOException {

		String url = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/searchStay?listYN=Y&MobileOS=ETC&MobileApp=TourAPI2.0_Guide&_type=json&ServiceKey="
				+ tourAPIKey + "&areaCode=" + areaCode + "&sigunguCode=" + sigunguCode;

		return jsonUtil.getJSONResponse(response, url);
	}

	@RequestMapping("/areaBasedListAPI")
	@ResponseBody
	public ResponseEntity<String> areaBasedListAPI(HttpServletResponse response, Integer areaCode, Integer sigunguCode,
			Integer contentTypeId) throws IOException {

		String url = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaBasedList?listYN=Y&MobileOS=ETC&MobileApp=TourAPI2.0_Guide&_type=json&ServiceKey="
				+ tourAPIKey + "&areaCode=" + areaCode + "&sigunguCode=" + sigunguCode + "&contentTypeId="
				+ contentTypeId;

		return jsonUtil.getJSONResponse(response, url);
	}
	
	@RequestMapping("/areaBasedList")
	@ResponseBody
	public ResponseEntity<String> areaBasedList(HttpServletResponse response, Integer areaCode, Integer sigunguCode)
			throws IOException {

		String url = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaBasedList?listYN=Y&MobileOS=ETC&MobileApp=TourAPI2.0_Guide&_type=json&ServiceKey="
				+ tourAPIKey + "&areaCode=" + areaCode + "&sigunguCode=" + sigunguCode;

		return jsonUtil.getJSONResponse(response, url);
	}
	
	@RequestMapping("/getMyplan")
	public String getMyplan(HttpServletRequest req) {
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("loginInfo");  //세션에서 로그인정보가져오기
		
		String email = info.getEmail();
		
		List<PlanDTO> myPlan =  dao.getMyPlan(email);
		
		req.setAttribute("myPlan", myPlan);
		
		return "getMyplan";
	}

}
