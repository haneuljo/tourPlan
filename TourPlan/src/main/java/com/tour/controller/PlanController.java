package com.tour.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;

import com.tour.dao.PlanDAO;

@Controller("PlanController")
public class PlanController {
	
	@Autowired
	@Qualifier("PlanDAO")
	PlanDAO dao;
	
	
}
