package com.example.project.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.example.project.service.RentalService;

@RestController
public class RentalController {
	@Autowired
	RentalService rentalService;
	
	// rental
	@GetMapping(value = "rental/check/{artNo}", produces = "application/json; charset=UTF-8")
	public Map<String, Object> duplicateCheck(@PathVariable (value = "artNo") List<Long> artNo){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("artNo", artNo);
		return rentalService.duplicateCheck(map);
	}
	
	@PostMapping(value = "rental", produces = "application/json; charset=UTF-8")
	public Map<String, Object> addRental(@RequestBody Map<String, Object> map){		
		return rentalService.insertRental(map);		
	}
	
	@GetMapping(value="rental/{artNo}")
	public Map<String, Object> selectRental(@PathVariable (value = "artNo") List<Long> artNo){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("artNo", artNo);
		return rentalService.selectForRental(map);
	}
	
	// OrderList
	// 렌탈중인 List ( state = 1 )
	@GetMapping(value = "rental/rentalPage/{rentalPage}")
	public Map<String, Object> rentalList(@PathVariable(value = "rentalPage", required = false) Optional<String> opt, HttpServletRequest request){
		int page = Integer.parseInt(opt.orElse("1"));
		return rentalService.rentalListPaging(page, request);
	}
	// 반납된 List ( state = 2 )
	@GetMapping(value = "rental/returnPage/{returnPage}")
	public Map<String, Object> returnedList(@PathVariable (value = "returnPage", required = false) Optional<String> opt, HttpServletRequest request){
		int page = Integer.parseInt(opt.orElse("1"));
		return rentalService.returnListPaging(page, request);
	}
	
	@GetMapping(value = "rental/return/{rentalNo}")
	public Map<String, Object> deleteRental(@PathVariable(value = "rentalNo") Long rentalNo){
		return rentalService.deleteRental(rentalNo);
	}
	
}
