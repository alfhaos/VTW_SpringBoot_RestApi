package com.example.demo.security;


import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.util.PatternMatchUtils;

public class LoginCheckFilter implements Filter {
	
	// 필터 적용 제외할 경로들 설정
	private static final String[] whitelist = {"/", "/springboot/memberRest/signIn", "/springboot/member/signUp", "/springboot/member/logout","/springboot/resources/*","/springboot/",
			"/springboot/memberRest/checkId","/springboot/memberRest/insertMember","/springboot/member/signIn"};
	
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {

		HttpServletRequest httpRequest = (HttpServletRequest) request;
 		String requestURI = httpRequest.getRequestURI();
 		HttpServletResponse httpResponse = (HttpServletResponse) response;
 		
		 try {
 			if (isLoginCheckPath(requestURI)) {
 				HttpSession session = httpRequest.getSession(false);
		 		if (session == null || session.getAttribute("member") == null) {
 					//로그인 화면으로 redirect
 					httpResponse.sendRedirect("/springboot/");
				}
    		 }
			 chain.doFilter(request, response);
		 } catch (Exception e) {
 				throw e; 
		 }
		
	}
	
	 private boolean isLoginCheckPath(String requestURI) {
	 		return !PatternMatchUtils.simpleMatch(whitelist, requestURI);
		 }


}
