package com.example.project.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface RentalService {

	public Map<String, Object> duplicateCheck(Map<String, Object> map);
	public Map<String, Object> insertRental(Map<String, Object> map);
	public Map<String, Object> selectForRental(Map<String, Object> map);
	public Map<String, Object> rentalListPaging(int page, HttpServletRequest request);
	public Map<String, Object> returnListPaging(int page, HttpServletRequest request);
	public void returnDate();
	public Map<String, Object> deleteRental(Long rentalNo);
}
