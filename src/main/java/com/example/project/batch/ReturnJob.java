package com.example.project.batch;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.example.project.repository.RentalRepository;

@Component
public class ReturnJob {

	@Autowired
	RentalRepository repository;
	
	@Scheduled(cron = "0 0/1 * * * *")
	public void execute() throws Exception {
		System.out.println("스케쥴러 작동");
		repository.returnArt();
	}

}
