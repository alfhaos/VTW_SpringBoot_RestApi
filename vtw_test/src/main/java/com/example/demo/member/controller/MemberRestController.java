package com.example.demo.member.controller;

import java.net.http.HttpRequest;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.board.model.service.BoardService;
import com.example.demo.board.model.vo.Board;
import com.example.demo.member.model.service.MemberService;
import com.example.demo.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;


@RestController
@RequestMapping("/memberRest")
@Slf4j
public class MemberRestController {

	@Autowired
	private MemberService memberService;
	
	@Autowired
	private BoardService boardService;
	
	private BCryptPasswordEncoder bcryptPasswordEncoder = new BCryptPasswordEncoder();
	

	@GetMapping("/checkId")
	public String CheckId(String id) {
		String name = null;
		
		try {
			name = memberService.selectNameById(id);
		} catch (Exception e) {
			e.printStackTrace();
			
		}
		
		
		return name;
	}
	
	@GetMapping("/signIn")
	public int Member(
			String id, 
			String pwd,
			HttpSession session) throws Exception {
		
		Member member = null;
		int errCount = 0;
		
		try {
			member = memberService.selectMemberById(id);
		} catch (Exception e) {
			e.printStackTrace();
			errCount++;
		}
		
		
		//id로 멤버 조회후 errCount 값에 따라 로그인 or 로그인 실패 여부 결정(loginFrm의 ajax내에서)
		
		if(member != null) {
			if(bcryptPasswordEncoder.matches(pwd, member.getPwd())) {
				
				session.setAttribute("member", member);
				
				return errCount;
			}
			else {
				errCount++;
			}
		}
		else {
			errCount++;
		}
		

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
