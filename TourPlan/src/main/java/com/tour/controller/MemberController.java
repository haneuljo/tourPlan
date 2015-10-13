package com.tour.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.tour.dao.ClipBoardDAO;
import com.tour.dao.MemberDAO;
import com.tour.dao.PlanDAO;
import com.tour.dao.ReviewDAO;
import com.tour.dto.MemberDTO;
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
	
	@RequestMapping("/")
	public String intro(HttpServletRequest req) {
		//DB������ ���ϰ� ���� ����
		/*HttpSession session = req.getSession(true); 

		SessionInfo info = new SessionInfo();
		
		//1�̶�� ���̵� ����
		
		info.setEmail("1");
		session.setAttribute("loginInfo", info);
		// loginInfo��� �����ȿ� info ��� Ŭ���� ��ü�� �־��ش�
		
		MemberDTO dto = dao.searchMember(info.getEmail());
		
		int clipCount = cdao.myClipCount(info.getEmail());
		int planCount = pdao.myPlanCount(info.getEmail());
		int reviewCount = rdao.myReviewCount(info.getEmail());
		
		req.setAttribute("name", dto.getName());
		req.setAttribute("clipCount", clipCount);
		req.setAttribute("planCount", planCount);
		req.setAttribute("reviewCount", reviewCount);
		*/
		return "index";
	}
		
	//����â Modal
	@RequestMapping("/signModal")
	public String signModal() {
		
		return "member/sign";
	}
	
	//����â Insert
	@RequestMapping("/memberSign")
	public String memberSign(HttpServletRequest req, MemberDTO dto) {
		dao.insertData(dto);

		return "redirect:/";
	}
	
	//�α��� Modal
	@RequestMapping("/loginModal")
	public String loginModal() {

		return "member/login";
	}
	@RequestMapping("/memberLogin")
	public String memberLogin(HttpServletRequest req, String email, String pwd) {
		
		MemberDTO dto = dao.loginChk(email,pwd);
		
		//���̵�� ��й�ȣ�� Ʋ����?
		if (dto == null || (!dto.getPwd().equals(pwd))) {
			return null;
		}
		// id, pwd�� ��ġ

		HttpSession session = req.getSession(true); 

		SessionInfo info = new SessionInfo();

		info.setEmail(dto.getEmail());
		//info.setProfileImg(dto.getProfileImg());

		session.setAttribute("loginInfo", info);
		
		
		int clipCount = cdao.myClipCount(info.getEmail());
		int planCount = pdao.myPlanCount(info.getEmail());
		int reviewCount = rdao.myReviewCount(info.getEmail());
		
		req.setAttribute("name", dto.getName());
		req.setAttribute("clipCount", clipCount);
		req.setAttribute("planCount", planCount);
		req.setAttribute("reviewCount", reviewCount);
		
		return "redirect:/";
	}
	
	//�α׾ƿ�
	@RequestMapping(value = "/logout")
	public String logout(HttpServletRequest req) {
		HttpSession session = req.getSession();

		session.removeAttribute("loginInfo");
		return "redirect:/";
	}
}
