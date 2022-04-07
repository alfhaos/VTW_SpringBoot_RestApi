package com.example.demo.member.model.dao;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.demo.member.model.vo.Member;

@Mapper
public interface MemberDao {

	int insertMember(Member member);

	Member selectMemberById(String id);

	String selectNameById(String id);
}
