package com.example.project.domain;

public class Author {
	private Long authorNo;
	private String authorName;
	private String authorIntro;
	
	public Author() {
		// TODO Auto-generated constructor stub
	}
	public Author(Long authorNo, String authorName, String authorIntro) {
		super();
		this.authorNo = authorNo;
		this.authorName = authorName;
		this.authorIntro = authorIntro;
	}

	public Long getAuthorNo() {
		return authorNo;
	}

	public void setAuthorNo(Long authorNo) {
		this.authorNo = authorNo;
	}

	public String getAuthorName() {
		return authorName;
	}

	public void setAuthorName(String authorName) {
		this.authorName = authorName;
	}

	public String getAuthorIntro() {
		return authorIntro;
	}

	public void setAuthorIntro(String authorIntro) {
		this.authorIntro = authorIntro;
	}
	@Override
	public String toString() {
		return "Author [authorNo=" + authorNo + ", authorName=" + authorName + ", authorIntro=" + authorIntro + "]";
	}
	
}
