package com.example.project.domain;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class Rental {
	private Long rentalNo;
	private Long artNo;
	private Long userNo;
	private String recieverName;
	private String recieverTel;
	private String address;
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
	private Date startDate;
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
	private Date endDate;
	private String requirements;
	private String rentalState;
	
	private Artwork artwork;
	private Member member;
	
	public Rental() {
		// TODO Auto-generated constructor stub
	}

	public Rental(Long rentalNo, Long artNo, Long userNo, String recieverName, String recieverTel, String address,
			Date startDate, Date endDate, String requirements, String rentalState, Artwork artwork, Member member) {
		super();
		this.rentalNo = rentalNo;
		this.artNo = artNo;
		this.userNo = userNo;
		this.recieverName = recieverName;
		this.recieverTel = recieverTel;
		this.address = address;
		this.startDate = startDate;
		this.endDate = endDate;
		this.requirements = requirements;
		this.rentalState = rentalState;
		this.artwork = artwork;
		this.member = member;
	}

	public Long getRentalNo() {
		return rentalNo;
	}

	public void setRentalNo(Long rentalNo) {
		this.rentalNo = rentalNo;
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

	public String getRecieverName() {
		return recieverName;
	}

	public void setRecieverName(String recieverName) {
		this.recieverName = recieverName;
	}

	public String getRecieverTel() {
		return recieverTel;
	}

	public void setRecieverTel(String recieverTel) {
		this.recieverTel = recieverTel;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public String getRequirements() {
		return requirements;
	}

	public void setRequirements(String requirements) {
		this.requirements = requirements;
	}

	public String getRentalState() {
		return rentalState;
	}

	public void setRentalState(String rentalState) {
		this.rentalState = rentalState;
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
		return "Rental [rentalNo=" + rentalNo + ", artNo=" + artNo + ", userNo=" + userNo + ", recieverName="
				+ recieverName + ", recieverTel=" + recieverTel + ", address=" + address + ", startDate=" + startDate
				+ ", endDate=" + endDate + ", requirements=" + requirements + ", rentalState=" + rentalState
				+ ", artwork=" + artwork + ", member=" + member + "]";
	}
	
}
