package com.example.demo.board.model.service;

import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.board.model.dao.BoardDao;
import com.example.demo.board.model.vo.Board;
import com.example.demo.board.model.vo.Comment;




@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardDao boardDao;

	@Override
	public int insertBoard(Board board) {
	
		return boardDao.insertBoard(board);
	}

	@Override
	public List<Board> selectAllBoard(Map<String,Integer> param) {
		
		return setSimpleDateFormat(boardDao.selectAllBoard(param));
	}

	@Override
	public Board selectBoardByNum(int num) {
		SimpleDateFormat dtFormat = new SimpleDateFormat("yyyy/MM/dd");
		boardDao.addReadCount(num);
		Board board = boardDao.selectBoardByNum(num);
		board.setFormatDate(dtFormat.format(board.getEnrollDate()));
		
		
		return board;
	}

	@Override
	public int deleteBoard(int num) {
		return boardDao.deleteBoard(num);
	}

	@Override
	public int UpdateBoard(Board board) {
		return boardDao.UpdateBoard(board);
	}

	@Override
	public int selectTotalBoardCount() {
		return boardDao.selectTotalBoardCount();
	}

	@Override
	public int insertComment(Comment comment) {
		
		return boardDao.insertComment(comment);
	}

	@Override
	public List<Comment> selectCommentByNum(int boardNum) {
		SimpleDateFormat dtFormat = new SimpleDateFormat("yyyy/MM/dd hh:mm:ss");
		
		List<Comment> commentList =  boardDao.selectCommentByNum(boardNum);
		
		for(Comment comment : commentList) {
			
			comment.setFormatDate(dtFormat.format(comment.getEnrollDate()));
		}
		return commentList;
	}

	@Override
	public int deleteComment(int commentNum, int boardNum) {
	
		return boardDao.deleteComment(commentNum,boardNum);
	}

	@Override
	public int updateComment(int commentNum, int boardNum, String commentContent) {
		return boardDao.updateComment(commentNum,boardNum,commentContent);
	}

	@Override
	public List<Board> selectBoardReadCount(Map<String, Integer> param) {
		
		return setSimpleDateFormat(boardDao.selectBoardReadCount(param));
	}

	@Override
	public List<Board> selectBoardUser(Map<String, Integer> param,String writerId) {

		return setSimpleDateFormat(boardDao.selectBoardUser(param,writerId));
	}
	
	public List<Board> setSimpleDateFormat(List<Board> boardList){
		SimpleDateFormat dtFormat = new SimpleDateFormat("yyyy/MM/dd");
		
		for (Board board : boardList) {
			board.setFormatDate(dtFormat.format(board.getEnrollDate()));
		}
		return boardList;
	}

}
