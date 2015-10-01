package com.tour.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;

import com.tour.dao.PlanInfoDAO;

@Controller("PlanInfoController")
public class PlanInfoController {
	
	
	@Autowired
	@Qualifier("PlanInfoDAO")
	PlanInfoDAO dao;
	
}
