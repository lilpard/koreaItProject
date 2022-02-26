<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<link href="/css/artwork/list.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	$(document).ready(function(){
		fnArtList();
		fnArtInfo();
		fnSearchBtn();
		fnChangePage();
		fnAutoComplete();
		fnSelectRadio();
	});
	
	var page = 1;
	var query = $('#query').val('');
	// 작품 목록
	function fnSearchBtn(){
		$(document).on('click', '#search_btn', function(){
			query = $('#query').val();
			if($('#query').val() == ''){
				alert('검색어를 입력주세요.');
				$('#query').focus();
				return;
			}else{
				fnArtList();	
			}
		});
	}
	function fnArtList(){
		let state = $('#artStateArrage').is(':checked');
		let arrange = $('#arrange').val();
		let theme =  $('input:radio[name="theme"]:checked').val();
		if(query.length == 0){
			query = 'null';
		}
		$.ajax({
			url: '/art/page/' + page +'/state/' + state + '/arrange/' + arrange + '/theme/' + theme + '/query/' + query,
			type: 'get',
			dataType: 'json',
			success: function(map){
				fnPrintArtList(map);
				fnPrintPaging(map.pageUtils);
			}
		});
	}// end fnArtList

	function fnSearchList(){
		$('#search_btn').click(function(){
			let query = $('#query').val();
			if($('#query').val() == ''){
				alert('검색어를 입력주세요.');
				$('#query').focus();
				return;
			}
			
			let state = $('#artStateArrage').is(':checked');
			
			var theme =  $('input:radio[name="theme"]:checked').val();
			let arrange = $('#arrange').val();
			
			$.ajax({
				url: '/art/page/' + page +'/state/' + state + '/arrange/' + arrange + '/theme/' + theme + '/query/' + query ,
			   type: 'get',
		   dataType: 'json',
			 success: function(map){
					fnPrintArtList(map);
					fnPrintPaging(map.pageUtils);
			 }, 
			error: function(){
				 alert('검색 실패');
			 }
			});
			
		});
	}  // end fnSearchList
	
	function fnPrintArtList(map){
		fnInit();
		$.each(map.list, function(i, art){
			if(art.state == 1){
				$('<div class="art_wrapper" data-artNo="'+ art.artNo +'" onclick="fnArtInfo" >')
				.append($('<ul>')
				.append($('<img class="imgs" src="'+ art.path +'">'))
				.append($('<li>').text(art.artName))
				.append($('<li>').html(art.author != null ? art.author.authorName : '&nbsp;'))
				.append($('<li class="rentalPossible">').text('● 렌탈 가능')))
				.appendTo('#art_list');				
			} else{
				$('<div class="art_wrapper" data-artNo="'+ art.artNo +'" onclick="fnArtInfo" >')
				.append($('<ul>')
				.append($('<img class="imgs" src="'+ art.path +'">'))
				.append($('<li>').text(art.artName))
				.append($('<li>').html(art.author != null ? art.author.authorName : ''))
				.append($('<li class= "rentalImpossible">').text('● 렌탈 중')))
				.appendTo('#art_list');								
			}
		});
	}// end fnPrintArtList
	

	
	function fnPrintPaging(p){
		// 페이징 영역 초기화
		$('#paging').empty();
		// 1페이지로 이동
		if (page == 1) {
			//$('<div class="disable_link">&lt;&lt;</div>').appendTo('#paging');
			$('<div>').addClass('disable_link').html('&lt;&lt;').appendTo('#paging');
		} else {
			//$('<div class="enable_link" data-page="1">&lt;&lt;</div>').appendTo('#paging');
			$('<div>').addClass('enable_link').html('&lt;&lt;').attr('data-page', 1).appendTo('#paging');
		}
		// 이전 블록으로 이동
		if (page <= p.pagePerBlock) {
			$('<div class="disable_link">&lt;</div>').appendTo('#paging');
		} else {
			$('<div class="enable_link" data-page="'+(p.beginPage-1)+'">&lt;</div>').appendTo('#paging');
		}
		// 페이지 번호
		for (let i = p.beginPage; i <= p.endPage; i++) {
			if (i == page) {
				$('<div class="disable_link now_page">'+i+'</div>').appendTo('#paging');
			} else {
				$('<div class="enable_link" data-page="'+i+'">'+i+'</div>').appendTo('#paging');
			}
		}
		// 다음 블록으로 이동
		if (p.endPage == p.totalPage) {
			$('<div class="disable_link">&gt;</div>').appendTo('#paging');
		} else {
			$('<div class="enable_link" data-page="'+(p.endPage+1)+'">&gt;</div>').appendTo('#paging');
		}
		// 마지막 페이지로 이동
		if (page == p.totalPage) {
			$('<div class="disable_link">&gt;&gt;</div>').appendTo('#paging');
		} else {
			$('<div class="enable_link" data-page="'+p.totalPage+'">&gt;&gt;</div>').appendTo('#paging');
		}
	}  // end fnPrintPaging
	
	function fnChangePage(){
		$('body').on('click', '.enable_link', function(){
			page = $(this).data('page');
			fnArtList();
		});
	}// end fnChangePage
	
	// 상세보기 이동
	function fnArtInfo(){
		$('body').on('click', '.art_wrapper', function(){
			let artNo = $(this).data('artno');
			location.href='/art/view/' + artNo;
		});
	}// end fnArtFind
	
var doubleCallsFlag = false;
	// 자동 완성 함수
	function fnAutoComplete(){
		if(doubleCallsFlag){
			console.log("막힘")
			return false;
		} else{
			$('#query').on('keyup',  function(){	
				let query = $('#query').val();
				if(query == ''){
					query = null;
				}
				console.log(query);
				doubleCallsFlag = true;
				$.ajax({
					url: '/art/autoComplete/query/' + query,
					type: 'get',
					dataType: 'json',
					success: function(map) {
						$('#auto_complete').empty();
						console.log(map);
						$.each(map.list, function(i, author){
							console.log(author.authorName);
								$('<option>').text(author.authorName)
								.appendTo('#auto_complete');
						});
						$.each(map.list2, function(i, art){
							console.log(art.artName);
								$('<option>').text(art.artName)
								.appendTo('#auto_complete');
						});
					},
					error: function(xhr) {
						
					}
				});
			});
			doubleCallsFlag = false;
		}// end fnAutoComplete		
	}
	
	function fnInit(){
		$('#art_list').empty();
		$('#art_info').empty();
		$('#paging').empty();
	}
	
	function fnSelectRadio(){
		$('.themeRadio').on('change', function(){
			let length = $('.themeRadio').length;
			for(let i=0; i< length; i++){
				if($($('input[class="themeRadio"]')[i]).is(":checked")){
					console.log('true: '+ i);
					$($('.themeRadio')[i]).next().addClass('checkedRadio');
				}else{
					console.log('false: '+ i);
					$($('.themeRadio')[i]).next().removeClass('checkedRadio');				
				}				
			}
		})
	}
	
</script>

</head>
<body>
	<jsp:include page="../component/nav.jsp"></jsp:include>
	

	<div class="list">
		<h1>작품 리스트</h1>
		<section class="artList_wrapper">
			<div class="arrange_wrapper">
				<input type="checkbox" id="artStateArrage" value="rentalPossible" onclick="fnArtList()">&nbsp;<label for="artStateArrage">렌탈가능</label>&nbsp;&nbsp;
				<select id="arrange" onchange="fnArtList()">
					<option value="RECENT">최신 목록</option>
					<option value="LOWPRICE">낮은 가격</option>
					<option value="HIGHPRICE">높은 가격</option>
				</select>
				<div>
					<input list="auto_complete" type="text" id="query" name="query" placeholder="작가명 . 작품명 검색">
					<datalist id="auto_complete"></datalist>
					<button id="search_btn">검색</button>
				</div>
				<div>
				    <ul id="themeType" onchange="fnArtList()">
				      <li>
				        <input class="themeRadio" type="radio" name="theme" value="전체보기" id="themeAll" checked="checked"><label class="themeLabel checkedRadio" for="themeAll">전체보기</label>
				      </li>
				      <li>
				        <input class="themeRadio" type="radio" name="theme" value="인물" id="themePerson" ><label class="themeLabel" for="themePerson">인물</label>
				      </li>
				      <li>
				        <input class="themeRadio" type="radio" name="theme" value="풍경" id="themSenery"><label class="themeLabel" for="themSenery">풍경</label>
				      </li>
				      <li>
				        <input class="themeRadio" type="radio" name="theme" value="정물" id="themeStillLife"><label class="themeLabel" for="themeStillLife">정물</label>
				      </li>
				      <li>
				        <input class="themeRadio" type="radio" name="theme" value="동물" id="themeAnimal"><label class="themeLabel" for="themeAnimal">동물</label>
				      </li>
				      <li>
				        <input class="themeRadio" type="radio" name="theme" value="상상" id="themeImagine"><label class="themeLabel" for="themeImagine">상상</label>
				      </li>
				      <li>
				        <input class="themeRadio" type="radio" name="theme" value="추상" id="themeAbstract"><label class="themeLabel" for="themeAbstract">추상</label>
				      </li>
				    </ul>
				</div>
			</div>
			<div class="artList_search"></div>
			<div id="art_list"></div>
			<div id="paging"></div>
		</section>
	</div>
	
	<jsp:include page="../component/footer.jsp"></jsp:include>

</body>
</html>