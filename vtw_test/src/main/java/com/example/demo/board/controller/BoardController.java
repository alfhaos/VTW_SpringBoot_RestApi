package com.example.demo.board.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.board.model.service.BoardService;
import com.example.demo.board.model.vo.Board;
import com.example.demo.board.model.vo.Comment;
import com.example.demo.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/board")
@Slf4j
public class BoardController {
	
	
	@Autowired
	private BoardService boardService;
	

	@GetMapping("/boardDetail")
	public String boardDetail(
			HttpServletRequest request,
			int num,
			HttpSession session,
			Model md
			) {
		Board board;
		List<Comment> commentList = null;
		Member loginMember =(Member)session.getAttribute("member");
		
		try {
			board = boardService.selectBoardByNum(num);

			board.setContent(board.getContent().replaceAll("\n", "<br/>"));
			commentList = boardService.selectCommentByNum(num);
			
			
		} catch (Exception e) {
			e.printStackTrace();
			board = null;
		}
		
		md.addAttribute("member", loginMember);
		md.addAttribute(board);
		md.addAttribute(commentList);

		
		return "forward:/WEB-INF/views/board/boardDetail.jsp";
	}
	
	@PostMapping("/boardDelete")
	public String boardDelete(
			HttpServletRequest request,
			Model md) {

		int num = Integer.parseInt(request.getParameter("num"));
		int result;
		
		try {
			result = boardService.deleteBoard(num);
		} catch (Exception e) {
			e.printStackTrace();
			result = 0;
		}
		
		
		return "forward:/index.jsp";
	}
	
	@GetMapping("boardUpdate")
	public String boardUpdate(
			int num,
			Model md) {
		
		Board board;
		try {
			board = boardService.selectBoardByNum(num);
		} catch (Exception e) {
			e.printStackTrace();
			board = null;
		}
		
		md.addAttribute(board);
		
		return "forward:/WEB-INF/views/board/boardUpdateFrm.jsp";
	}
	
	@GetMapping("/boardFrm")
	public String boardFrm() {
		
		return "forward:/WEB-INF/views/board/boardFrm.jsp";
	}
	
	@GetMapping("/backToIndex")
	public String backto(HttpSession session,Model md) {
		Member loginMember =(Member)session.getAttribute("member");
		md.addAttribute("member", loginMember);
		return "forward:/index.jsp";
	}
	
	
	
}
