package com.example.project.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.project.domain.Comments;
import com.example.project.repository.CommentsRepository;

@Service
public class CommentsServiceImpl implements CommentsService {
	
	@Autowired
	CommentsRepository repository;
	
	// 댓글 목록 메소드
	@Override
	public Map<String, Object> findComment(Long reviewNo) {
		List<Comments> list = repository.selectCommentsListByReviewNo(reviewNo);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		return map;
	}
	// 댓글 등록 메소드
	@Override
	public Map<String, Object> addComment(Comments comments) {
		int result = repository.insertComments(comments);
		Map<String, Object> m = new HashMap<String, Object>();
		m.put("result", result);
		return m;
	}
	// 댓글 수정 메소드
	@Override
	public Map<String, Object> modifyComment(Comments comments) {
		int result = repository.updateComments(comments);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", result);
		return map;
	}
	// 댓글 삭제 메소드
	@Override
	public Map<String, Object> removeComment(Long commentNo) {
		int result = repository.deleteComments(commentNo);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", result);
		return map;
	}

}
