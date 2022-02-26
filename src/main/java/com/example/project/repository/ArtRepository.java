package com.example.project.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.example.project.domain.Artwork;
import com.example.project.domain.Author;


@Mapper
public interface ArtRepository {
	public int artTotalCount(Map<String, Object> map);
	public List<Artwork> findArtList(Map<String, Object> map);
	public Artwork selectArtByNo(Long artNo);
	public int searchArtCnt(Map<String, Object> map);
	public List<Artwork>searchArtList(Map<String, Object> map);
	public List<Artwork>selectRadioList(Map<String, Object> map);
	public int selectRadioCnt(Map<String, Object> map);
	public List<Author> autoComplete(String query);
	public List<Artwork> autoComplete2(String query);
}
