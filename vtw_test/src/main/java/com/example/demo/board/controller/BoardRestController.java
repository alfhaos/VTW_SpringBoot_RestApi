package com.example.demo.board.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.example.demo.board.model.service.BoardService;
import com.example.demo.board.model.vo.Board;
import com.example.demo.board.model.vo.Comment;
import com.example.demo.common.utils.Utils;
import com.example.demo.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/boardRest")
@Slf4j
public class BoardRestController {

	@Autowired
	private BoardService boardService;
	
	@GetMapping("/selectBoardUser")
	public Map<String,Object> selectBoardUser(
			@RequestParam(defaultValue  = "1")int cPage,
			HttpSession session,
			HttpServletRequest request){
	
		Map<String,Object> map = new HashMap<String,Object>();
		Member loginMember =(Member)session.getAttribute("member");
		
		List<Board> board = boardService.selectBoardUser(getParam(cPage),loginMember.getId());
		
		map.put("board", board);
		map.put("pagebar", getPageBar(cPage, request));
		
		return map;
		
	}
	@GetMapping("/selectBoardReadCount")
	public Map<String,Object> selectBoardReadCount(
			@RequestParam(defaultValue  = "1")int cPage,
			HttpServletRequest request){
		
		Map<String,Object> map = new HashMap<String,Object>();

		List<Board> board = boardService.selectBoardReadCount(getParam(cPage));
		
		map.put("board", board);
		map.put("pagebar", getPageBar(cPage, request));
		
		return map;
		
	}
	
	@PostMapping("/updateComment")
	public List<Comment> updateComment(
			int commentNum,
			String commentContent,
			int boardNum){
		
		boardService.updateComment(commentNum,boardNum,commentContent);
		
		List<Comment> commentList = boardService.selectCommentByNum(boardNum);
		return commentList;
		
	}
	
	
	@PostMapping("/deleteComment")
	public List<Comment> deleteComment(
			int commentNum,
			int boardNum){
	

		boardService.deleteComment(commentNum,boardNum);
		
		List<Comment> commentList = boardService.selectCommentByNum(boardNum);
		
		return commentList;
	}
	
	@PostMapping("/insertComment")
	public List<Comment> insertComment(
			HttpSession session,
			String content,
			int boardNum){

		Member loginMember =(Member)session.getAttribute("member");
		Comment comment = new Comment(loginMember.getName(),content,boardNum,loginMember.getId());
		
		boardService.insertComment(comment);
		
		List<Comment> commentList = boardService.selectCommentByNum(boardNum);
		
		return commentList;
	}
	
	@GetMapping("/selectAllBoard")
	public Map<String,Object> selectAllBoard(
			@RequestParam(defaultValue  = "1")int cPage,
			HttpServletRequest request,
			Model md){
		
		List<Board> board;
		Map<String,Object> map = new HashMap<String,Object>();
		try {
				
			board = boardService.selectAllBoard(getParam(cPage));
			
			map.put("board", board);
			map.put("pagebar", getPageBar(cPage, request));
			
		} catch (Exception e) {
			e.printStackTrace();
			board = null;
		}
		
		return map;
	}

	@PostMapping("/insertBoard")
	public int insertFrm(String title,String content,String memberId,HttpSession session) {
		
		int result= 0;
		
		Member loginMember =(Member)session.getAttribute("member");

		Board board = new Board(title,content,loginMember.getName(),memberId);

		try {
			result = boardService.insertBoard(board);
		} catch (Exception e) {
			e.printStackTrace();
			result = 0;
		}
		
		return result;
	}
	
	@PostMapping("/boardUpdate")
	public int boardUpdate(
			String title,
			String content,
			int num){
		
		int result=0;
		Board board = new Board(num,title,content);
		
		board.setContent(board.getContent().replaceAll("<br/>", "\n"));
		try {
			result = boardService.UpdateBoard(board);
		} catch (Exception e) {
			e.printStackTrace();
			result=0;
		}
		
		return result;
	}

	public String getPageBar(int cPage,HttpServletRequest request) {
		final int numPerPage = 5;
		
		int startNum = (cPage - 1) * numPerPage + 1;
		int endNum =  cPage * numPerPage;
		
		Map<String,Integer> param =new HashMap<>();
		param.put("startNum", startNum);
		param.put("endNum", endNum);
		
		int totalContent = boardService.selectTotalBoardCount();
		
		String url = request.getRequestURI();
		String pageBar = Utils.getPageBar(cPage, numPerPage, totalContent, url);
		
		return pageBar;
	}
	
	public Map<String,Integer> getParam(int cPage){
		final int numPerPage = 5;
		
		int startNum = (cPage - 1) * numPerPage + 1;
		int endNum =  cPage * numPerPage;
		
		Map<String,Integer> param =new HashMap<>();
		param.put("startNum", startNum);
		param.put("endNum", endNum);
		
		return param;
	}
}
