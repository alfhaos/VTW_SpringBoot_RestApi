package com.example.demo.board.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.board.model.vo.Board;
import com.example.demo.board.model.vo.Comment;

@Mapper
public interface BoardDao {

	int insertBoard(Board board);

	List<Board> selectAllBoard(Map<String,Integer> param);

	Board selectBoardByNum(int num);

	int deleteBoard(int num);

	int UpdateBoard(Board board);

	void addReadCount(int num);

	int selectTotalBoardCount();

	int insertComment(Comment comment);

	List<Comment> selectCommentByNum(int boardNum);

	int deleteComment(int commentNum, int boardNum);

	int updateComment(int commentNum, int boardNum, String commentContent);

	List<Board> selectBoardReadCount(Map<String, Integer> param);

	List<Board> selectBoardUser(Map<String, Integer> param,String memberId);



}
