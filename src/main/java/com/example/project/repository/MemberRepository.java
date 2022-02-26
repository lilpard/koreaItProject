package com.example.project.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.project.domain.Member;


@Mapper
public interface MemberRepository {

	public int insertMember(Member member);
	public Member login(Member member);
	public int updateMemberPw(Member member);
	public int updateMemberTel(Member member);
	public int deleteMemberByEmail(Long userNo);
	public List<String> findId(String tel);
	public Member findPw(String email);
}
