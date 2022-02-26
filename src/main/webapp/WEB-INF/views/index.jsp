<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link rel="stylesheet" href="/css/index.css">
  	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
	<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		fnSlide();
		fnBxSlider();
	});

	var $j = jQuery.noConflict();
	function fnSlide(){
		$.ajax({
			url: 'api/advertisement',
			date: 'get',
			async: false,
			dateType: 'json',
			success: function(map){
				console.log(map);
				$.each(map.list, function(i, ad){
					$('<li>&nbsp;<img class="imgs" src="'+ ad.adPath +'" title="'+ ad.adTitle +'"></li>')
					.appendTo($('.bxSlider'));
				});
			}
		});
	}
	
	function fnBxSlider(){

		$j(".bxSlider").bxSlider({
			speed: 500,
			pause: 3000, 
			auto: true,
		    autoHover: true,
		    autoDelay: 0,	
		 	pager: true,
		 	mode : 'horizontal',
		  	controls: true,
		  	infiniteLoop: true,
		  	autoControls: false,
		  	moveSlides: 1,
		  	captions: true
		});
		
	}
	
	
</script>
</head>
<body>
	<jsp:include page="component/nav.jsp"></jsp:include>

	<div class="wrapper">
	    <ul class="bxSlider"></ul>
	</div>
	
	<jsp:include page="component/footer.jsp"></jsp:include>
</body>
</html>