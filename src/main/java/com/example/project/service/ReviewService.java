package com.example.project.service;

import java.util.Map;

import com.example.project.domain.Review;

public interface ReviewService {

	public Map<String, Object> findAllReview(Long artNo);
	public Map<String, Object> addReview(Review review);
}
