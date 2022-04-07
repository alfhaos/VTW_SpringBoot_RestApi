package com.example.demo;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

	
	@GetMapping("/")
	public String index(HttpSession session) {
		
		session.invalidate();
		
		return "forward:/WEB-INF/views/member/loginFrm.jsp";
	}
	
}
