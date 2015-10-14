package com.tour.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.tour.dao.ClipBoardDAO;
import com.tour.dao.MemberDAO;
import com.tour.dao.PlanDAO;
import com.tour.dao.ReviewDAO;
import com.tour.dto.ClipBoardDTO;
import com.tour.dto.MemberDTO;
import com.tour.util.JSONResponseUtil;
import com.tour.util.SessionInfo;

@Controller("MemberController")
public class MemberController {
	
	@Autowired
	@Qualifier("MemberDAO")
	MemberDAO dao;
	
	@Autowired
	@Qualifier("ClipBoardDAO")
	ClipBoardDAO cdao;
	
	@Autowired
	@Qualifier("PlanDAO")
	PlanDAO pdao;
	
	@Autowired
	@Qualifier("ReviewDAO")
	ReviewDAO rdao;
	

	@Autowired
	JSONResponseUtil jsonUtil;


	String tourAPIKey = "yTjHIt%2FH7AcPJXelK4H8YojzSp9LozbSrtkEaNNnK5MySJEpntK5dWQIcNCYQRzNQCpR4oBcpXtQVtMCBlWYEQ%3D%3D";
	
	
	@RequestMapping("/")
	public String intro(HttpServletRequest req, HttpServletResponse resp) throws ParseException, IOException {
		
		HttpSession session = req.getSession(); 

		SessionInfo info = (SessionInfo) session.getAttribute("loginInfo");
		
		if(info!=null){
		
			MemberDTO dto = dao.searchMember(info.getEmail());
			
			int clipCount = cdao.myClipCount(info.getEmail());
			int planCount = pdao.myPlanCount(info.getEmail());
			int reviewCount = rdao.myReviewCount(info.getEmail());
			
			req.setAttribute("name", dto.getName());
			req.setAttribute("clipCount", clipCount);
			req.setAttribute("planCount", planCount);
			req.setAttribute("reviewCount", reviewCount);
			
				      
		}
		List<ClipBoardDTO> allClipList = cdao.clipList();
        
	    List<ClipBoardDTO> clipList = new ArrayList<ClipBoardDTO>();
	       
	    Iterator<ClipBoardDTO> it = allClipList.iterator();
	      while (it.hasNext()) {
	         
	         ClipBoardDTO cdto = it.next();
	        //System.out.println( cdto.getContentid());
	         int cCount = cdao.getClipCount(cdto.getContentid());
	         
	         String url =
	               "http://api.visitkorea.or.kr/openapi/service/rest/KorService/detailCommon?contentId="+cdto.getContentid()+"&defaultYN=Y&addrinfoYN=Y&mapinfoYN=Y&firstImageYN=Y&overviewYN=Y&MobileOS=ETC&MobileApp=AppTesting&_type=json&ServiceKey="
	                  +tourAPIKey;
	         System.out.println(url);
	         
	         JSONParser jsonparser = new JSONParser();
	         JSONObject jsonobject = (JSONObject)jsonparser.parse(jsonUtil.getJSONResponseString(resp, url));
	         JSONObject json =  (JSONObject) jsonobject.get("response");
	         JSONObject jsonbody =  (JSONObject) json.get("body");
	         JSONObject jsonitem =  (JSONObject) jsonbody.get("items");
	         JSONObject array = (JSONObject)jsonitem.get("item");
	           
	         cdto.setFirstimage((String)array.get("firstimage"));
	         cdto.setTitle((String)array.get("title"));
	         cdto.setClipCount(cCount);
	           
	         clipList.add(cdto);
	         
	      }
	      
	      req.setAttribute("clipList", clipList);

		
		return "index";
	}
		
	//占쏙옙占쏙옙창 Modal
	@RequestMapping("/signModal")
	public String signModal() {
		
		return "member/sign";
	}
	
	//占쏙옙占쏙옙창 Insert
	@RequestMapping("/memberSign")
	public String memberSign(HttpServletRequest req, MemberDTO dto) {
		dao.insertData(dto);

		return "redirect:/";
	}
	
	//占싸깍옙占쏙옙 Modal
	@RequestMapping("/loginModal")
	public String loginModal() {

		return "member/login";
	}
	@RequestMapping("/memberLogin")
	public String memberLogin(HttpServletRequest req, String email, String pwd) {
		
		MemberDTO dto = dao.loginChk(email,pwd);
		
		//占쏙옙占싱듸옙占�占쏙옙橘占싫ｏ옙占�틀占쏙옙占쏙옙?
		if (dto == null || (!dto.getPwd().equals(pwd))) {
			return null;
		}
		// id, pwd占쏙옙 占쏙옙치

		HttpSession session = req.getSession(true); 

		SessionInfo info = new SessionInfo();

		info.setEmail(email);
		//info.setProfileImg(dto.getProfileImg());

		session.setAttribute("loginInfo", info);
		
		
		return "redirect:/";
	}
	
	//占싸그아울옙
	@RequestMapping(value = "/logout")
	public String logout(HttpServletRequest req) {
		HttpSession session = req.getSession();

		session.removeAttribute("loginInfo");
		return "redirect:/";
	}
}
