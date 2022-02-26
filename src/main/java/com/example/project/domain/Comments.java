package com.example.project.domain;

import java.sql.Date;

public class Comments {
	
	private Long commentNo, reviewNo, userNo, groupNo, commentOrd;
	private String commentContent;
	private Date commentCreated;
	private int depth;
	
	private Review review;
	private Member member;
	public Comments() {
		// TODO Auto-generated constructor stub
	}
	public Comments(Long commentNo, Long reviewNo, Long userNo, Long groupNo, Long commentOrd, String commentContent,
			Date commentCreated, int depth, Review review, Member member) {
		super();
		this.commentNo = commentNo;
		this.reviewNo = reviewNo;
		this.userNo = userNo;
		this.groupNo = groupNo;
		this.commentOrd = commentOrd;
		this.commentContent = commentContent;
		this.commentCreated = commentCreated;
		this.depth = depth;
		this.review = review;
		this.member = member;
	}
	public Long getCommentNo() {
		return commentNo;
	}
	public void setCommentNo(Long commentNo) {
		this.commentNo = commentNo;
	}
	public Long getReviewNo() {
		return reviewNo;
	}
	public void setReviewNo(Long reviewNo) {
		this.reviewNo = reviewNo;
	}
	public Long getUserNo() {
		return userNo;
	}
	public void setUserNo(Long userNo) {
		this.userNo = userNo;
	}
	public Long getGroupNo() {
		return groupNo;
	}
	public void setGroupNo(Long groupNo) {
		this.groupNo = groupNo;
	}
	public Long getCommentOrd() {
		return commentOrd;
	}
	public void setCommentOrd(Long commentOrd) {
		this.commentOrd = commentOrd;
	}
	public String getCommentContent() {
		return commentContent;
	}
	public void setCommentContent(String commentContent) {
		this.commentContent = commentContent;
	}
	public Date getCommentCreated() {
		return commentCreated;
	}
	public void setCommentCreated(Date commentCreated) {
		this.commentCreated = commentCreated;
	}
	public int getDepth() {
		return depth;
	}
	public void setDepth(int depth) {
		this.depth = depth;
	}
	public Review getReview() {
		return review;
	}
	public void setReview(Review review) {
		this.review = review;
	}
	public Member getMember() {
		return member;
	}
	public void setMember(Member member) {
		this.member = member;
	}
	
	@Override
	public String toString() {
		return "Comments [commentNo=" + commentNo + ", reviewNo=" + reviewNo + ", userNo=" + userNo + ", groupNo="
				+ groupNo + ", commentOrd=" + commentOrd + ", commentContent=" + commentContent + ", commentCreated="
				+ commentCreated + ", depth=" + depth + ", review=" + review + ", member=" + member + "]";
	}
	
}
