package com.tour.controller;

<<<<<<< HEAD
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
=======

import javax.servlet.http.HttpServletRequest;
>>>>>>> 6d834985f24960a34f57b8f01b5f04b31497093c

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tour.dao.PlanDAO;
<<<<<<< HEAD
import com.tour.dto.MemberDTO;
import com.tour.util.JSONResponseUtil;
import com.tour.util.SessionInfo;
=======
>>>>>>> 6d834985f24960a34f57b8f01b5f04b31497093c

@Controller("PlanController")
public class PlanController {
	
	@Autowired
	@Qualifier("PlanDAO")
	PlanDAO dao;
	
	@RequestMapping("/planInfo")
	public String planInfo(HttpServletRequest req) {
		
		return "plan/planInfo";
	}
	
<<<<<<< HEAD
	String tourAPIKey = "sGR0LkYPdWBTkZqjRcwTe8AzAV9yoa3Qkl0Tq6y7eAf1AJL0YcsaWSv2kaDmBRWikYgT5czC1BZ2N7K13YcEfQ%3D%3D";
	

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
			
			JSONResponseUtil util = new JSONResponseUtil();
			return util.getJSONResponse(response, url);
		}
		@RequestMapping("/sigunguCodeAPI1")
		@ResponseBody
		public ResponseEntity<String> sigunguCodeAPI(HttpServletResponse response, Integer areaCode) throws IOException {
			
			String url = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaCode?listYN=Y&MobileOS=ETC&MobileApp=TourAPI2.0_Guide&_type=json&numOfRows=30&ServiceKey="
					+ tourAPIKey
					+ "&areaCode="+areaCode;
			
			JSONResponseUtil util = new JSONResponseUtil();
			return util.getJSONResponse(response, url);
		}
		@RequestMapping("/searchStayAPI")
		@ResponseBody
		public ResponseEntity<String> searchStayAPI(HttpServletResponse response,Integer areaCode, Integer sigunguCode) throws IOException {
			
			String url = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/searchStay?listYN=Y&MobileOS=ETC&MobileApp=TourAPI2.0_Guide&_type=json&ServiceKey="
					+ tourAPIKey
					+ "&areaCode="+areaCode+"&sigunguCode="+sigunguCode;

			JSONResponseUtil util = new JSONResponseUtil();
			return util.getJSONResponse(response, url);
		}
		
		@RequestMapping("/areaBasedListAPI")
		@ResponseBody
		public ResponseEntity<String> areaBasedListAPI(HttpServletResponse response,Integer areaCode, Integer sigunguCode,Integer contentTypeId) throws IOException {
			
			String url = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaBasedList?listYN=Y&MobileOS=ETC&MobileApp=TourAPI2.0_Guide&_type=json&ServiceKey="
					+ tourAPIKey
					+ "&areaCode="+areaCode+"&sigunguCode="+sigunguCode + "&contentTypeId=" + contentTypeId;

			JSONResponseUtil util = new JSONResponseUtil();
			return util.getJSONResponse(response, url);
		}
	
		@RequestMapping("/areaBasedList")
		@ResponseBody
		public ResponseEntity<String> areaBasedList(HttpServletResponse response,Integer areaCode, Integer sigunguCode) throws IOException {
			
			String url = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaBasedList?listYN=Y&MobileOS=ETC&MobileApp=TourAPI2.0_Guide&_type=json&ServiceKey="
					+ tourAPIKey
					+ "&areaCode="+areaCode+"&sigunguCode="+sigunguCode;

			JSONResponseUtil util = new JSONResponseUtil();
			return util.getJSONResponse(response, url);
		}
=======

>>>>>>> 6d834985f24960a34f57b8f01b5f04b31497093c
	
	
}
