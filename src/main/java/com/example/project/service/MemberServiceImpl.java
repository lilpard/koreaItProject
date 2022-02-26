package com.example.project.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.Message;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.example.project.domain.Member;
import com.example.project.repository.MemberRepository;
import com.example.project.util.SecurityUtils;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	MemberRepository repository;
	private JavaMailSender javaMailSender;
	
	public MemberServiceImpl(SqlSessionTemplate sqlSession, JavaMailSender javaMailSender) {
		repository = sqlSession.getMapper(MemberRepository.class);
		this.javaMailSender = javaMailSender;
	}
	
	// 회원가입 메소드
	@Override
	public Map<String, Object> addMember(Member member) {
		member.setPw(SecurityUtils.sha256(member.getPw()));
		member.setUserName(SecurityUtils.xxs(member.getUserName()));
		int result = repository.insertMember(member);  
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", result);   
		return map;
		}
	
	// 로그인 메소드
	@Override
	public Map<String, Object> loginMember(Member member, HttpSession session) {
		member.setPw(SecurityUtils.sha256(member.getPw()));
		Member loginUser = repository.login(member);
		if (loginUser != null) {
			session.setAttribute("loginUser", loginUser);
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", loginUser != null);  // result가 true이면 로그인 성공
		return map;
	}
	
	// 로그아웃 메소드
	@Override
	public Map<String, Object> logoutMember(HttpServletRequest request) {
		request.getSession().invalidate();
		request.getSession(true);
		Map<String, Object> map = new HashMap<String, Object>();
		return map;
	}
	
	// 비밀번호 변경 메소드
	@Override
	public Map<String, Object> changePw(Member member) {
		member.setPw(SecurityUtils.sha256(member.getPw()));
		int result = repository.updateMemberPw(member);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", result);
		return map;
	}
	
	// 핸드폰번호 변경 메소드
	@Override
	public Map<String, Object> changeTel(Member member) {
		int result = repository.updateMemberTel(member);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", result);
		return map;
	}
	
	// 회원탈퇴 메소드
	@Override
	public Map<String, Object> removeMember(Long userNo, HttpServletRequest request) {
		int result = repository.deleteMemberByEmail(userNo);
		request.getSession().invalidate();
		request.getSession(true);		// 세션을 날려버리지 않으면 회원 탈퇴를 해도 세션 데이터가 남아 탈퇴가 안 된것처럼 보인다
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", result);
		return map;
	}

	// 아이디 찾기
	@Override
	public Map<String, Object> findId(String tel) {
		List<String> emails = repository.findId(tel);
		List<String> email = new ArrayList<String>();
		Map<String, Object> map = new HashMap<String, Object>();
		if(emails.size() == 0){
			map.put("status", 500);
			map.put("message", "해당되는 아이디가 없습니다.");
		}else {
			for(String mail : emails) {
				String starmail = mail.substring(0, 2) + "**" + mail.substring(5);
				email.add(starmail);
			}
			map.put("email", email);
			map.put("status", 200);	
			map.put("emailCnt", emails.size());
		}
		
		return map;
	}
	
	// 비번 찾기
	@Override
	public Map<String, Object> sendAuthCode(String email) {
		
		Member user = repository.findPw(email);
		
		Map<String, Object> map = new HashMap<String, Object>();
		if(user != null) {		
			String authCode = SecurityUtils.authCode(6);
			String pw = SecurityUtils.sha256(authCode);
			user.setPw(pw);
			try {
				int result = repository.updateMemberPw(user);
				if(result > 0) {
					MimeMessage message = javaMailSender.createMimeMessage();
					message.setHeader("Content-Type", "text/plain; charset=UTF-8");
					message.setFrom(new InternetAddress("wispring08@gmail.com", "인증코드관리자"));
					message.setRecipient(Message.RecipientType.TO, new InternetAddress(email));
					message.setSubject("임시 비밀번호 메일입니다");
					message.setText("임시 비밀번호는 " + authCode + " 입니다.");
					javaMailSender.send(message);					
					map.put("status", 200);
					map.put("message", "해당 메일로 임시비밀번호가 전송되었습니다.");
				}else {
					map.put("message", "임시비밀번호 발급 실패");
				}
			} catch(Exception e) {
				e.printStackTrace();
				map.put("message", "메일 전송 오류");
			}
		}else{
			map.put("status", 500);
			map.put("message", "해당 메일로 가입된 정보가 없습니다.");
		}
		
		return map;	
	}
}
