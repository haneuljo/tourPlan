package com.tour.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;

import com.tour.dao.PlanLikeDAO;

@Controller("PlanLikeController")
public class PlanLikeController {
	
	@Autowired
	@Qualifier("PlanLikeDAO")
	PlanLikeDAO dao;
	
}
