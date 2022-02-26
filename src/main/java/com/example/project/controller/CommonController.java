package com.example.project.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
public class CommonController {

	// 메인화면 이동
	@GetMapping("/")
	public String index() {
		return "index";
	}
	
	// 로그인 페이지 이동
	@GetMapping(value="member/loginPage")
	public String loginPage() {
		return "member/login";
	}
	
	// 로그아웃
	@GetMapping("member/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "index";
	}
	
	// 회원가입 페이지 이동
	@GetMapping(value="member/joinPage")
	public String joinPage() {
		return "member/join";
	}
	
	// 관리자 페이지 이동
	@GetMapping(value="artwork/adminPage")
	public String adminPage() {
		return "artwork/art";
	}
	
	// 마이 페이지 이동
	@GetMapping(value="member/myPage")
	public String myPage() {
		return "member/myPage";
	}
	
	// 목록 페이지 이동
	@GetMapping(value="art/artPage")
	public String viewPage() {
		return "art/list";
	}
	
	// 목록 상세보기 페이지 이동
	@GetMapping(value="art/view/{artNo}")
	public String artView(@PathVariable (value = "artNo") String artNo) {
		return "art/view";
	}
	
	// 댓글 작성 페이지 이동
	@GetMapping(value="review/insertPage")
	public String insertPage() {
		return "review/insert";
	}
	
	// 장바구니 목록 페이지 이동
	@GetMapping(value = "cart")
	public String cartList() {
		return "cart/cart";
	}
	
	// 장바구니에서 체크한 목록을 가지고 렌탈하기 (등록) 페이지 이동
	@GetMapping(value = "rental")
	public String rentalPage() {
		return "rental/cartToRental";
	}
	
	// 상세 작품 보기에서 렌탈하기(등록) 페이지 이동
	@GetMapping(value = "rental/order/{artNo}")
	public String selectOrder(@PathVariable (value = "artNo") List<Long> artNo) {
		return "rental/rental";
	}
	
	// 렌탈 관련 목록으로 이동
	@GetMapping(value = "rental/orderList")
	public String orderList() {
		return "rental/orderList";
	}
	
	// 아이디 찾기 페이지
	@GetMapping(value = "member/findIdPage")
	public String findIdPage() {
		return "member/findIdPage";
	}
	
	// 비밀번호 찾기 페이지
	@GetMapping(value = "member/findPwPage")
	public String findPwPage() {
		return "member/findPwPage";
	}
	
}
