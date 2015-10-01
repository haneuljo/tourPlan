package com.tour.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;

import com.tour.dao.ReviewDAO;


@Controller("ReviewController")
public class ReviewController {
	
	@Autowired
	@Qualifier("ReviewDAO")
	ReviewDAO dao;
}
