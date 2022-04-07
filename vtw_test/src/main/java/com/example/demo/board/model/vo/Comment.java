package com.example.demo.board.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Comment {
	
	private String writer;
	private String content;
	private Date enrollDate;
	private String formatDate;
	private int commentNum;
	private int boardId;
	private String memberId;
	
	public Comment(String writer, String content, int boardId,String memberId) {
		super();
		this.writer = writer;
		this.content = content;
		this.boardId = boardId;
		this.memberId = memberId;
	}
	
	

}
