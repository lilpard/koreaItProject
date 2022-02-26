package com.example.project.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.example.project.domain.Artwork;
import com.example.project.domain.Rental;


@Mapper
public interface RentalRepository {

	public List<Rental> artNoDuplicateCheck(Map<String, Object> map);
	public List<Rental> rentalDuplicateCheck(Map<String, Object> map);
	public int insertRental(Map<String, Object> map);
	public List<Artwork> selectForRental(Map<String, Object> map);
	public int totalCount(Map<String, Object> map);
	public int totalPrice(Map<String, Object> map);
	// 렌탈중인 목록 가져오기
	public int rentalTotalCount(Long userNo);
	public List<Rental> rentalList(Map<String, Object> map);
	// 반납한 목록 가져오기
	public int returnTotalCount(Long userNo);
	public List<Rental> returnList(Map<String, Object> map);
	// 반납일에 자동 수정을 위한 코드
	public int returnArt();
	// 반납된 작품 내역 삭제
	public int deleteRental(Long rentalNo);
}
