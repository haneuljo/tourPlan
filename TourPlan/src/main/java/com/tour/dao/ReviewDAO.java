package com.tour.dao;

import org.mybatis.spring.SqlSessionTemplate;

public class ReviewDAO {

	private SqlSessionTemplate sessionTemplate;

	public void setSessionTemplate(SqlSessionTemplate sessionTemplate) throws Exception{
		this.sessionTemplate = sessionTemplate;
	}
	
	
	public int myReviewCount(String email){
		
		int result = 0;
		
		result = sessionTemplate.selectOne("com.tour.review.myReviewCount", email);
		
		return result;
		
	}
}
