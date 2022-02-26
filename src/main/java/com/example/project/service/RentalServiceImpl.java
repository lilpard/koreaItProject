package com.example.project.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.project.domain.Member;
import com.example.project.domain.Rental;
import com.example.project.repository.RentalRepository;
import com.example.project.util.RentalPageUtils;

@Service
public class RentalServiceImpl implements RentalService {
	@Autowired
	RentalRepository repository;
	
	// 렌탈 중인 작품 중복 체크
	@Override
	public Map<String, Object> duplicateCheck(Map<String, Object> map) {
		List<Rental> list = repository.artNoDuplicateCheck(map);
		Map<String, Object> m = new HashMap<String, Object>();
		
		if(list.isEmpty()){
			m.put("status", 200);
		} else {
			m.put("list", list);
			m.put("status", 402);
		}
		
		return m;
	}
	
	@Override
	public Map<String, Object> insertRental(Map<String, Object> map) { 
		
		// 결과 반환 맵
		int result = 0;
		List<Rental> list = repository.rentalDuplicateCheck(map);
		Map<String, Object> m = new HashMap<String, Object>();
		if(list.size() == 0) {
			result = repository.insertRental(map);
			if(result > 0) {
				m.put("message", "작품이 렌탈목록에 등록되었습니다.");
				m.put("status", 200);
			} else {
				m.put("message", "작품이 렌탈목록에 등록되지 못했습니다");
				m.put("status", 401);
			}
		} else {
			m.put("list", list);
			m.put("status", 402);
		}
		return m;
	}
	
	@Override
	public Map<String, Object> selectForRental(Map<String, Object> m) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", repository.selectForRental(m));
		map.put("totalCount", repository.totalCount(m));
		map.put("totalPrice", repository.totalPrice(m));
		return map;
	}
	
	@Override
	public Map<String, Object> rentalListPaging(int page, HttpServletRequest request) {
		
		// session에 있는 회원 번호
		HttpSession session = (HttpSession) request.getSession();
		Member user = (Member) session.getAttribute("loginUser");
		Long userNo = user.getUserNo();
		
		
		int totalRecord = repository.rentalTotalCount(userNo);
		RentalPageUtils rentalPageUtils = new RentalPageUtils();
		rentalPageUtils.setPageEntity(totalRecord, page);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("beginRecord", rentalPageUtils.getBeginRecord());
		map.put("endRecord", rentalPageUtils.getEndRecord());
		map.put("userNo", userNo);
		List<Rental> list = repository.rentalList(map);

		Map<String, Object> m = new HashMap<String, Object>();
		m.put("list", list);
		m.put("rentalUtils", rentalPageUtils);
		
		return m;
	}
	
	@Override
	public Map<String, Object> returnListPaging(int page, HttpServletRequest request) {
	
		// session에 있는 회원 번호
		HttpSession session = (HttpSession) request.getSession();
		Member user = (Member) session.getAttribute("loginUser");
		Long userNo = user.getUserNo();
		
		int totalRecord = repository.returnTotalCount(userNo);
		RentalPageUtils returnPageUtils = new RentalPageUtils();
		returnPageUtils.setPageEntity(totalRecord, page);
		// 매퍼로 보낼 데이터
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("beginRecord", returnPageUtils.getBeginRecord());
		map.put("endRecord", returnPageUtils.getEndRecord());
		map.put("userNo", userNo);
		
		List<Rental> list = repository.returnList(map);
		
		Map<String, Object> m = new HashMap<String, Object>();
		m.put("list", list);
		m.put("returnUtils", returnPageUtils);
		
		return m;
	}
	
	@Override
	public void returnDate() {
		repository.returnArt();
	}
	
	@Override
	public Map<String, Object> deleteRental(Long rentalNo) {
		int result = repository.deleteRental(rentalNo);
		Map<String, Object> map = new HashMap<String, Object>();
		if(result > 0) {
			map.put("message", "반납 완료된 작품 내역을 삭제하였습니다.");
		}else {
			map.put("message", "작품 내역을 삭제하는데 실패하였습니다.");
		}
		return map;
	}
}
