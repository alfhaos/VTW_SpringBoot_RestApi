package com.example.demo.member.model.service;

import com.example.demo.member.model.vo.Member;

public interface MemberService{

	int insertMember(Member member);

	Member selectMemberById(String id);

	String selectNameById(String id);

}
