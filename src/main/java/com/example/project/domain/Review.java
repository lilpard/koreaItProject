package com.example.project.domain;

public class Review {
	
	private Long reviewNo, artNo, userNo;
	private String reviewContent;
	private int starRating;
	
	private Artwork artWork;
	private Member member;
	public Review() {
		// TODO Auto-generated constructor stub
	}
	public Review(Long reviewNo, Long artNo, Long userNo, String reviewContent, int starRating, Artwork artWork,
			Member member) {
		super();
		this.reviewNo = reviewNo;
		this.artNo = artNo;
		this.userNo = userNo;
		this.reviewContent = reviewContent;
		this.starRating = starRating;
		this.artWork = artWork;
		this.member = member;
	}
	public Long getReviewNo() {
		return reviewNo;
	}
	public void setReviewNo(Long reviewNo) {
		this.reviewNo = reviewNo;
	}
	public Long getArtNo() {
		return artNo;
	}
	public void setArtNo(Long artNo) {
		this.artNo = artNo;
	}
	public Long getUserNo() {
		return userNo;
	}
	public void setUserNo(Long userNo) {
		this.userNo = userNo;
	}
	public String getReviewContent() {
		return reviewContent;
	}
	public void setReviewContent(String reviewContent) {
		this.reviewContent = reviewContent;
	}
	public int getStarRating() {
		return starRating;
	}
	public void setStarRating(int starRating) {
		this.starRating = starRating;
	}
	public Artwork getArtWork() {
		return artWork;
	}
	public void setArtWork(Artwork artWork) {
		this.artWork = artWork;
	}
	public Member getMember() {
		return member;
	}
	public void setMember(Member member) {
		this.member = member;
	}
	@Override
	public String toString() {
		return "Review [reviewNo=" + reviewNo + ", artNo=" + artNo + ", userNo=" + userNo + ", reviewContent="
				+ reviewContent + ", starRating=" + starRating + ", artWork=" + artWork + ", member=" + member + "]";
	}
}
