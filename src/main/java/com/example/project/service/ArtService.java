package com.example.project.service;

import java.util.Map;

public interface ArtService {
	public Map<String, Object> findArtList(Map<String, Object> map);
	public Map<String, Object> selectArtByNo(Long artNo);
	public Map<String, Object> autoComplete(String query);	
	public Map<String, Object> searchList(Map<String, Object> map);
}
