package com.example.project.service;

import java.util.Map;

public interface CartService {
	public Map<String, Object> addCart(Map<String, Object> map);
	public Map<String, Object> findCartList(Long userNo);
	public Map<String, Object> removeCart(Map<String, Object> map);
}
