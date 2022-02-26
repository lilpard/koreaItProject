package com.example.project.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.example.project.domain.Cart;


@Mapper
public interface CartRepository {
	public int DuplicateCheck(Map<String, Object> map);
	public int insertCart(Map<String, Object> map);
	public int totalCount(Long userNo);
	public int totalPrice(Long userNo);
	public List<Cart> findCartList(Long userNo);
	public int deleteCart(Map<String, Object> map);
}
