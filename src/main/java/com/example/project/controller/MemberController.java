package com.example.project.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.project.domain.Member;
import com.example.project.service.MemberService;


@RestController
public class MemberController {
	@Autowired
	MemberService service;
	
	
	// 회원 등록!
	@PostMapping(value="members/join", produces="application/json; charset=UTF-8")
	public Map<String, Object> addMember(@RequestBody Member member, HttpServletResponse response) {
		try {
			return service.addMember(member);
		} catch (DuplicateKeyException e) {
			try {
				response.setContentType("text/html; charset=UTF-8");
				response.setStatus(500);
				response.getWriter().println("동일한 계정이 존재합니다.");
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		} catch (DataIntegrityViolationException e) {
			try {
				response.setContentType("text/html; charset=UTF-8");
				response.setStatus(501);
				response.getWriter().println("필수 정보가 누락되었습니다.");
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return null;  // 동작할 일 없음.
	}
	
	// 회원 로그인
	@PostMapping(value="members/login", produces="application/json; charset=UTF-8")
	public Map<String, Object> loginMember(@RequestBody Member member, HttpSession session) {
		return service.loginMember(member, session);
	}
	
	// 회원 로그아웃
	@DeleteMapping(value="api/members", produces="application/json; charset=UTF-8")
	public Map<String, Object> logoutMember(HttpServletRequest request) {
		return service.logoutMember(request);
		
	}
	
	// 회원 비밀번호 변경
	@PutMapping(value="members/changePw", produces="application/json; charset=UTF-8")
	public Map<String, Object> changePw(@RequestBody Member member) {
		return service.changePw(member);
	}
	
	// 회원 휴대폰번호 변경
	@PutMapping(value="members/changeTel", produces="application/json; charset=UTF-8")
	public Map<String, Object> changeTel(@RequestBody Member member) {
		return service.changeTel(member);
	}
	
	// 회원 탈퇴
	@DeleteMapping(value="members/{userNo}", produces="application/json; charset=UTF-8")
	public Map<String, Object> removeMember(@PathVariable(value="userNo") Long userNo, HttpServletRequest request) {
		return service.removeMember(userNo, request);
	}
	
	// 아이디 찾기 
	@GetMapping(value = "member/findId/tel/{tel}", produces = "application/json; charset=UTF-8")
	public Map<String, Object> findId (@PathVariable(value = "tel") String tel){
		return service.findId(tel);
	}
	
	// 비번찾기
	@PostMapping(value = "member/sendAuthCode", produces = "application/json; charset=UTF-8")
	public Map<String, Object> sendAuthCode(@RequestParam ("email") String email){
		return service.sendAuthCode(email);	
	}

}
