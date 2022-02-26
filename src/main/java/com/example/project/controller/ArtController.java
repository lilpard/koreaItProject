package com.example.project.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import com.example.project.service.ArtService;

@RestController
public class ArtController {
	@Autowired
	ArtService artService;

	// 작품 목록 페이징처리 (+ 정렬, 필터, 검색기능)
		@GetMapping(value = "art/page/{page}/state/{state}/arrange/{arrange}/theme/{theme}/query/{query}", produces = "application/json; charset=UTF-8")
		public Map<String, Object> findArtList(@PathVariable(value = "page", required=false) Optional<String> opt, 
											@PathVariable (value = "state") Boolean state, 
											@PathVariable (value = "arrange") String arrange,
											@PathVariable (value = "theme") String theme,
											@PathVariable (value="query", required = false) String query){
			Map<String, Object> map = new HashMap<String, Object>();
			String page = opt.orElse("1");
			map.put("state", state);
			map.put("arrange", arrange);
			map.put("theme", theme);
			map.put("page", Integer.parseInt(page));
			map.put("query", query);
			return artService.findArtList(map);
		}
	
	// 자동완성
	@GetMapping(value="art/autoComplete/query/{query}", produces="application/json; charset=UTF-8")
	public Map<String, Object> autoComplete(@PathVariable(value="query", required=false) String query) {
		return artService.autoComplete(query);
	}	
		
	// 작품 상세보기
	@GetMapping(value = "art/{artNo}", produces = "application/json; charset=UTF-8")
	public Map<String, Object> selectArtByNo(@PathVariable(value = "artNo") Long artNo) {
		return artService.selectArtByNo(artNo);
	}
	

}
