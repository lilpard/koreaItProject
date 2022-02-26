package com.example.project.domain;

public class Artwork {
	
	private Long artNo, authorNo, price;
	private String artName, path, theme;
	private int state;
	
	private Author author;

	public Artwork() {
		// TODO Auto-generated constructor stub
	}

	public Artwork(Long artNo, Long authorNo, Long price, String artName, String path, String theme, int state,
			Author author) {
		super();
		this.artNo = artNo;
		this.authorNo = authorNo;
		this.price = price;
		this.artName = artName;
		this.path = path;
		this.theme = theme;
		this.state = state;
		this.author = author;
	}

	public Long getArtNo() {
		return artNo;
	}

	public void setArtNo(Long artNo) {
		this.artNo = artNo;
	}

	public Long getAuthorNo() {
		return authorNo;
	}

	public void setAuthorNo(Long authorNo) {
		this.authorNo = authorNo;
	}

	public Long getPrice() {
		return price;
	}

	public void setPrice(Long price) {
		this.price = price;
	}

	public String getArtName() {
		return artName;
	}

	public void setArtName(String artName) {
		this.artName = artName;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public String getTheme() {
		return theme;
	}

	public void setTheme(String theme) {
		this.theme = theme;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public Author getAuthor() {
		return author;
	}

	public void setAuthor(Author author) {
		this.author = author;
	}

	@Override
	public String toString() {
		return "ArtWork [artNo=" + artNo + ", authorNo=" + authorNo + ", price=" + price + ", artName=" + artName
				+ ", path=" + path + ", theme=" + theme + ", state=" + state + ", author=" + author + "]";
	}
	
}
