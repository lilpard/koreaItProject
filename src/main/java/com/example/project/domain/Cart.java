package com.example.project.domain;

public class Cart {

	private Long cartNo;
	private Long artNo;
	private Long userNo;
	
	private Artwork artwork;
	private Member member;

	public Cart() {
		// TODO Auto-generated constructor stub
	}

	public Cart(Long cartNo, Long artNo, Long userNo, Artwork artwork, Member member) {
		super();
		this.cartNo = cartNo;
		this.artNo = artNo;
		this.userNo = userNo;
		this.artwork = artwork;
		this.member = member;
	}

	public Long getCartNo() {
		return cartNo;
	}

	public void setCartNo(Long cartNo) {
		this.cartNo = cartNo;
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

	public Artwork getArtwork() {
		return artwork;
	}

	public void setArtwork(Artwork artwork) {
		this.artwork = artwork;
	}

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	@Override
	public String toString() {
		return "Cart [cartNo=" + cartNo + ", artNo=" + artNo + ", userNo=" + userNo + ", artwork=" + artwork
				+ ", member=" + member + "]";
	}
	
	
}
