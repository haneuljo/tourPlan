package com.tour.controller;


import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.tour.dao.PlanDAO;

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
