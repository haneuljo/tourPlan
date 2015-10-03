package com.tour.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.tour.dao.PlanDAO;
import com.tour.dto.MemberDTO;
import com.tour.util.SessionInfo;

@Controller("PlanController")
public class PlanController {
	
	@Autowired
	@Qualifier("PlanDAO")
	PlanDAO dao;
	
	@RequestMapping("/planInfo")
	public String planInfo(HttpServletRequest req) {
		
		return "plan/planInfo";
	}
	
	
}
