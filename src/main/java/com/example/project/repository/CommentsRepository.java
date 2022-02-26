package com.example.project.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.project.domain.Comments;


@Mapper
public interface CommentsRepository {
	
	public List<Comments> selectCommentsListByReviewNo(Long reviewNo);
	public int insertComments(Comments comments);
	public int updateComments(Comments comments);
	public int deleteComments(Long commentNo);

}
