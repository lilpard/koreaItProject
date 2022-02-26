package com.example.project.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.project.domain.Artwork;
import com.example.project.domain.Author;
import com.example.project.repository.ArtRepository;
import com.example.project.util.PageUtils;

@Service
public class ArtServiceImpl implements ArtService {
	@Autowired
	ArtRepository repository;
	
	@Override
	public Map<String, Object> findArtList(Map<String, Object> m) {
		int totalRecord = repository.artTotalCount(m);
		PageUtils pageUtils = new PageUtils();
		pageUtils.setPageEntity(totalRecord, (int)m.get("page"));
		m.put("beginRecord", pageUtils.getBeginRecord());
		m.put("endRecord", pageUtils.getEndRecord());
		List<Artwork> list = repository.findArtList(m);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("pageUtils", pageUtils);
		return map;
	}
	
	@Override
	public Map<String, Object> autoComplete(String query) {
	
		List<Author> list = repository.autoComplete(query);
		List<Artwork> list2 = repository.autoComplete2(query);
		Map<String, Object> result = new HashMap<String, Object>();
		if(list.size() == 0 && list2.size() == 0) {
			result.put("list", null);
			result.put("list2", null);
		}else {
			result.put("list", list);
			result.put("list2", list2);
		}
		return result;
	}
	
	@Override
	public Map<String, Object> searchList(Map<String, Object> m2) {
		int totalRecord = repository.artTotalCount(m2);
		PageUtils pageUtils = new PageUtils();
		pageUtils.setPageEntity(totalRecord, (int)m2.get("page"));
		m2.put("beginRecord", pageUtils.getBeginRecord());
		m2.put("endRecord", pageUtils.getEndRecord());
		List<Artwork> list = repository.searchArtList(m2);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("pageUtils", pageUtils);
		return map;
	}
		
	@Override
	public Map<String, Object> selectArtByNo(Long artNo) {		
		Artwork artwork = repository.selectArtByNo(artNo);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("artwork", artwork);
		return map;
	}
	
}
