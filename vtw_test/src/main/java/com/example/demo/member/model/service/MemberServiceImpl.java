package com.example.demo.member.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Service;

import com.example.demo.member.model.dao.MemberDao;
import com.example.demo.member.model.vo.Member;

@Service
public class MemberServiceImpl implements MemberService  {

	@Autowired
	private MemberDao memberDao;

	@Override
	public int insertMember(Member member) {
		
		return memberDao.insertMember(member);
	}

	@Override
	public Member selectMemberById(String id) {
		
		return memberDao.selectMemberById(id);
	}

	@Override
	public String selectNameById(String id) {
		
		return memberDao.selectNameById(id);
	}

}
