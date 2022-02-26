package com.example.project.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.example.project.domain.Comments;
import com.example.project.service.CommentsService;

@RestController
public class CommentsController {
	@Autowired
	CommentsService service;

	// 댓글 목록
	@GetMapping(value = "comments/{reviewNo}", produces = "application/json; charset=UTF-8")
	public Map<String, Object> findComment(@PathVariable (value="reviewNo") Long reviewNo) {
		// System.out.println("controller reviewNo: " + reviewNo);
		return service.findComment(reviewNo);
	}
	
	// 댓글 등록 
	@PostMapping(value = "comments", produces = "application/json; charset=UTF-8")
	public Map<String, Object> addComment(@RequestBody Comments comments){
		return service.addComment(comments);
	}
	
	// 댓글 수정
	@PutMapping(value = "comments", produces = "application/json; charset=UTF-8")
	public Map<String, Object> modifyComment(@RequestBody Comments comments){
		return service.modifyComment(comments);
	}
	
	// 댓글 삭제
	@DeleteMapping(value = "comments/{commentNo}", produces = "application/json; charset=UTF-8")
	public Map<String, Object> removeComment(@PathVariable (value="commentNo") Long commentNo) {
		return service.removeComment(commentNo);
	}
	

}
