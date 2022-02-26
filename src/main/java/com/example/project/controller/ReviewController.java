package com.example.project.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.example.project.domain.Review;
import com.example.project.service.ReviewService;


@RestController
public class ReviewController {
	@Autowired
	ReviewService service;
	
	// 작품상세 보기
	
	// 리뷰 목록
	@GetMapping(value="reviews/{artNo}", produces="application/json; charset=UTF-8")
	public Map<String, Object> findAllReview(@PathVariable (value="artNo") Long artNo) {
		return service.findAllReview(artNo);
	}
	
	// 리뷰 등록
	@PostMapping(value="reviews", produces="application/json; charset=UTF-8")
	public Map<String, Object> addReview(@RequestBody Review review) {
		System.out.println(review);
		return service.addReview(review);
	}
	
	

}
