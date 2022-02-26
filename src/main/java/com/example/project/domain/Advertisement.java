package com.example.project.domain;

public class Advertisement {
	private Long adNo;
	private String adPath;
	private String adType;
	private String adTitle;
	private String adExplain;
	
	public Advertisement() {
		// TODO Auto-generated constructor stub
	}
  
	public Advertisement(Long adNo, String adPath, String adType, String adTitle, String adExplain) {
		super();
		this.adNo = adNo;
		this.adPath = adPath;
		this.adType = adType;
		this.adTitle = adTitle;
		this.adExplain = adExplain;
	}

	public Long getAdNo() {
		return adNo;
	}

	public void setAdNo(Long adNo) {
		this.adNo = adNo;
	}

	public String getAdType() {
		return adType;
	}

	public void setAdType(String adType) {
		this.adType = adType;
	}

	public String getAdTitle() {
		return adTitle;
	}

	public void setAdTitle(String adTitle) {
		this.adTitle = adTitle;
	}

	public String getAdPath() {
		return adPath;
	}

	public void setAdPath(String adPath) {
		this.adPath = adPath;
	}

	public String getAdExplain() {
		return adExplain;
	}

	public void setAdExplain(String adExplain) {
		this.adExplain = adExplain;
	}
	

	@Override
	public String toString() {
		return "Advertisement [adNo=" + adNo + ", adType=" + adType + ", adTitle=" + adTitle + ", adPath=" + adPath
				+ ", adExplain=" + adExplain + "]";
	}
	
}
