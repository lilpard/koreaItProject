package com.example.project.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.example.project.domain.Member;

public interface MemberService {
	
	public Map<String, Object> addMember(Member member);
	public Map<String, Object> loginMember(Member member, HttpSession session);
	public Map<String, Object> logoutMember(HttpServletRequest request);
	public Map<String, Object> changePw(Member member);
	public Map<String, Object> changeTel(Member member);
	public Map<String, Object> removeMember(Long userNo, HttpServletRequest request);
	public Map<String, Object> findId(String tel);
	public Map<String, Object> sendAuthCode(String email);
}
