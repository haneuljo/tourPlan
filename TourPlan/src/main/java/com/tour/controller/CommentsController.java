package com.tour.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;

import com.tour.dao.CommentsDAO;

@Controller("CommentsController")
public class CommentsController {

	@Autowired
	@Qualifier("CommentsDAO")
	CommentsDAO dao;
		
}
