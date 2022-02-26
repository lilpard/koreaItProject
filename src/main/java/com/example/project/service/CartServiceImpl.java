package com.example.project.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.project.domain.Cart;
import com.example.project.repository.CartRepository;

@Service
public class CartServiceImpl implements CartService {
	@Autowired
	CartRepository repository;

	@Override
	public Map<String, Object> addCart(Map<String, Object> map) {
		int DuplicateCheck = repository.DuplicateCheck(map);
		Map<String, Object> m = new HashMap<String, Object>();
		int result = 0;
		if(DuplicateCheck == 0) {
			result = repository.insertCart(map);			
			m.put("result", result);
			m.put("message", "장바구니에 해당 작품이 \n 등록되었습니다.");
			m.put("status", 200);
		} else {
			m.put("result", result);
			m.put("message", "장바구니에 이미 \n 등록된 제품입니다.");
			m.put("status", 400);
		}
		
		return m;
	}
	
	@Override
	public Map<String, Object> findCartList(Long userNo) {
		int totalCount = repository.totalCount(userNo);
		int totalPrice = repository.totalPrice(userNo);
		List<Cart> list = repository.findCartList(userNo);
		Map<String, Object> map = new HashMap<String, Object>();
		if(list.size() == 0) {
			map.put("status", 500);
			map.put("message", "카트에 담겨있는 작품이 없습니다");
			map.put("totalPrice", totalPrice);
			map.put("totalCount", totalCount);
			map.put("list", null);
		} else {
			map.put("status", 200);
			map.put("totalPrice", totalPrice);
			map.put("totalCount", totalCount);
			map.put("list", list);
		}
		return map;
	}
	
	@Override
	public Map<String, Object> removeCart(Map<String, Object> m) {
		int result = repository.deleteCart(m);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", result);
		return map;
	}
}
