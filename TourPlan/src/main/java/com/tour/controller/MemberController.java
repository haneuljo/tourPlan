package com.tour.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.tour.dao.MemberDAO;
import com.tour.dto.MemberDTO;
import com.tour.util.SessionInfo;

@Controller("MemberController")
public class MemberController {
	
	@Autowired
	@Qualifier("MemberDAO")
	MemberDAO dao;
	
	@RequestMapping("/")
	public String intro(HttpServletRequest req) {
		//DB연동시 편하게 세션 설정
		HttpSession session = req.getSession(true); 

		SessionInfo info = new SessionInfo();
		
		//1이라는 아이디 대입
		
		//info.setEmail("1");
		//session.setAttribute("loginInfo", info);
		// loginInfo라는 변수안에 info 라는 클래스 객체를 넣어준다

		return "index";
	}
		
	//가입창 Modal
	@RequestMapping("/signModal")
	public String signModal() {
		
		
		return "member/sign";
	}
	
	//가입창 Insert
	@RequestMapping("/memberSign")
	public String memberSign(HttpServletRequest req, MemberDTO dto) {
		dao.insertData(dto);

		return "redirect:/";
	}
	
	//로그인 Modal
	@RequestMapping("/loginModal")
	public String loginModal() {

		return "member/login";
	}
	@RequestMapping("/memberLogin")
	public String memberLogin(HttpServletRequest req, String email, String pwd) {
		
		MemberDTO dto = dao.loginChk(email,pwd);
		
		//아이디랑 비밀번호가 틀리면?
		if (dto == null || (!dto.getPwd().equals(pwd))) {
			return null;
		}
		// id, pwd가 일치

		HttpSession session = req.getSession(true); 

		SessionInfo info = new SessionInfo();

		info.setEmail(dto.getEmail());
		//info.setProfileImg(dto.getProfileImg());

		session.setAttribute("loginInfo", info);
		// loginInfo라는 변수안에 info 라는 클래스 객체를 넣어준다
		
		return "redirect:/";
	}
	
	//로그아웃
	@RequestMapping(value = "/logout.action")
	public String logout(HttpServletRequest req) {
		HttpSession session = req.getSession();

		session.removeAttribute("loginInfo");
		return "redirect:/";
	}
}
