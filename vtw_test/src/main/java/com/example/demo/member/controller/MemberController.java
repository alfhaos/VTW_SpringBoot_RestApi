package com.example.demo.member.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.member.model.service.MemberService;
import com.example.demo.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/member")
public class MemberController {

	@Autowired
	private MemberService memberService;

	@GetMapping("/signIn")
	public String Member(
			String id, 
			HttpSession session,
			Model md){
	
		Member member;
		try {
			member = memberService.selectMemberById(id);
		} catch (Exception e) {
			e.printStackTrace();
			member = null;
		}
		
		md.addAttribute(member);
	
		return "forward:/index.jsp";
	}

	@GetMapping("/logout")
	public String end(HttpSession session) {
		session.invalidate();
		
		return "forward:/WEB-INF/views/member/loginFrm.jsp";
	}
	
	@GetMapping("signUp")
	public String signUpFrm() {
		
		return "forward:/WEB-INF/views/member/signUpFrm.jsp";
	}
}
