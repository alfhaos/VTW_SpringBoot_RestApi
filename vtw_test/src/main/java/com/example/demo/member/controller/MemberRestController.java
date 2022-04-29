package com.example.demo.member.controller;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo.board.model.service.BoardService;
import com.example.demo.member.model.service.MemberService;
import com.example.demo.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;


@RestController
@RequestMapping("/memberRest")
public class MemberRestController {

	@Autowired
	private MemberService memberService;
	
	private BCryptPasswordEncoder bcryptPasswordEncoder = new BCryptPasswordEncoder();
	
	@GetMapping("/checkId")
	public String CheckId(String id) {
		
		String name = memberService.selectNameById(id);
		
		return name;
	}
	
	@GetMapping("/signIn")
	public int Member(String id, String pwd, HttpSession session) throws Exception {
		
		Member member = null;
		int errCount = 0;
		
		try {
			member = memberService.selectMemberById(id);
		} catch (Exception e) {
			e.printStackTrace();
			errCount++;
		}
		
		if(member != null) {
			if(bcryptPasswordEncoder.matches(pwd, member.getPwd())) {
				
				session.setAttribute("member", member);
				
				return errCount;
			} 
			else {errCount++;}
		}
		else {errCount++;}
		
		return errCount;
	}
	
	@PostMapping("/insertMember")
	public int insertMember(
			String id,
			String pwd,
			String name) {
		
		int result = 0;
		
		Member member = new Member(id,bcryptPasswordEncoder.encode(pwd),name);
		try {
			result = memberService.insertMember(member);
		} catch (Exception e) {
			e.printStackTrace();
			result = 0;
		}

		return result;
	}
	
}
