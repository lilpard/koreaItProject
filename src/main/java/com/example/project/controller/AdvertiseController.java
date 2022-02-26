package com.example.project.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.project.service.AdvertiseService;

@RestController
public class AdvertiseController {

	@Autowired
	AdvertiseService advertiseService;
	
	@GetMapping(value = "api/advertisement")
	public Map<String, Object> findAlladvertise(){
		return advertiseService.FindAlladvertise();
	}
}

