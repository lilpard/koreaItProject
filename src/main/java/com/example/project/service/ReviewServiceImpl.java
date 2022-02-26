package com.example.project.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.project.domain.Review;
import com.example.project.repository.ReviewRepository;

@Service
public class ReviewServiceImpl implements ReviewService {
	@Autowired
	ReviewRepository repository;
	
	// 리뷰 조회
	@Override
	public Map<String, Object> findAllReview(Long artNo) {
		List<Review> reviewList = repository.selectReviewListByArtNo(artNo);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("reviewList", reviewList);
		return map;
	}
	
	// 리뷰 등록
	@Override
	public Map<String, Object> addReview(Review review) {
		int result = repository.insertReview(review);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", result);
		return map;
	}

}
