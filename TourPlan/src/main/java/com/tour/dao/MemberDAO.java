package com.tour.dao;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import com.tour.dto.MemberDTO;

public class MemberDAO {

	private SqlSessionTemplate sessionTemplate;

	public void setSessionTemplate(SqlSessionTemplate sessionTemplate) throws Exception {
		this.sessionTemplate = sessionTemplate;
	}

	// 회원가입

	public void insertData(MemberDTO dto) {
		sessionTemplate.insert("com.tour.member.sign", dto);
	}

	// 로그인 확인

	public MemberDTO loginChk(String email, String pwd) {

		Map<String, String> hmap = new HashMap<String, String>();
		hmap.put("email", email);
		hmap.put("pwd", pwd);

		MemberDTO dto = sessionTemplate.selectOne("com.tour.member.loginChk", hmap);

		return dto;

	}
	
	public MemberDTO searchMember(String email) {
		
		MemberDTO dto = sessionTemplate.selectOne("com.tour.member.searchMember", email);
		
		return dto;
	}
}
