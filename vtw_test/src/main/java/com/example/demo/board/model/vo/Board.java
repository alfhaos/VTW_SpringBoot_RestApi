package com.example.demo.board.model.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Board {
	
	private int num;
	private String title;
	private String content;
	private String writer;
	private Date enrollDate;
	private String formatDate;
	private String memberId;
	
	private int readCount;
	
	
	
	
	public Board(String title, String content, String writer) {
		super();
		this.title = title;
		this.content = content;
		this.writer = writer;
	}




	public Board(int num, String title, String content,String writer) {
		super();
		this.num = num;
		this.title = title;
		this.content = content;
		this.writer = writer;
	}




	public Board(int num, String title, String content) {
		super();
		this.num = num;
		this.title = title;
		this.content = content;
	}




	public Board(String title, String content, String writer, String memberId) {
		super();
		this.title = title;
		this.content = content;
		this.writer = writer;
		this.memberId = memberId;
	}
	
	
	
	

}
