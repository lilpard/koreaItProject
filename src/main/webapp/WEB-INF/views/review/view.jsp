<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script type="text/javascript">
	$(document).ready(function(){
		fnFindAllReview();
	});
	
	// 전체 리뷰 목록 함수
	function fnFindAllReview(){
		$.ajax({
			url : '/api/reviews',
			type : 'get',
			data: 'artNo=' + $('#artNo'),
			dataType : 'json',
			success : function(map){
					$.each(map.list, function(i, review){
						$('<tr>')
						.append($('<td>').text(review.reviewContent))
						.append($('<td>').text(review.starRating))
						.append($('<td>').html( $('<input type="hidden" name="reviewNo" value="'+ review.reviewNo +'">')))
						.append($('<td>').html( $('<input type="hidden" name="artNo" value="'+ review.artWork.artNo +'">')))
						.append($('<td>').html( $('<input type="hidden" name="userNo" value="'+ review.member.userNo +'">')))
						.appendTo('#review_list');
				});
			} 
		});
	} // end fnFindAllReview
	
	
	
	
</script>
</head>
<body>

	<!--  작품 보기  -->
	<input type="hidden" id="artNo" value="??"> 
	
	
	
	<hr>
	
	<!--  리뷰 화면 -->
	
	<h1><a href="/review/insertPage">리뷰 작성하기!</a></h1>
	
	무 수 한 리 뷰 들
	
	<table>
		<tbody id="review_list"></tbody>
	</table>


</body>
</html>