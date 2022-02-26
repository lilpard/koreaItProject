<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
  <script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
<script>
	$(document).ready(function(){
		// 렌탈중인 작품
		fnRentalInfo();
		fnRChangePage();
		// 반납된 작품
		fnReturnedInfo();
		fnTChangePage();
		// 리뷰 작성
		fnWriteReview();
		// 내역 삭제
		fnDeleteRental();
	});
	
	// 렌탈 중인 목록
	function fnRentalInfo(){
		$.ajax({
			url: '/rental/rentalPage/' + rentalPage,
			type: 'get',
			dataType: 'json',
			success: function(map){
				if(map.list == null){
					alert('렌탈 중인 목록을 볼러오지 못했습니다.');
				} else{
					fnPrintArtInfo(map.list);		
					fnRentalPaging(map.rentalUtils);
				}
			}
		});
	}// fnArtInfo
	
	// 렌탈목록 출력
	function fnPrintArtInfo(list){
		$('#rentalList').empty();
		$.each(list, function(i, item){
			$('<tr>')
			.append($('<td>').text(item.rentalNo))
			.append($('<td>').html($('<span class="art"><img class="artImg" src="'+ item.artwork.path +'"><ul><li class="boldFont">' + item.artwork.artName +'</li><li class="smallfont">'+ item.artwork.author.authorName +'</li></ul></span>')))
			.append($('<td>').text(item.startDate))
			.append($('<td>').text(item.endDate))
			.append($('<td>').html('<span class="etc_btn"><input type="button" class="writeReview" value="후기작성"><input type="hidden" class="rentalNo" value="'+ item.rentalNo +'"><span class="etc_btn">'))
			.appendTo('#rentalList');
			$('<tr data-rentalNo="'+ item.rentalNo +'">')
			.append('<td colspan="5" class="insertReview undisplay"><span>리뷰내용</span><textarea rows="5" cols="100" id="review_content"></textarea><input type="button" class="review_btn" value="작성완료"><input type="hidden" value="'+ item.artwork.artNo +'"></td>')
			.appendTo('#rentalList')
		});
	} // fnPrintArtInfo

	var rentalPage = 1;
	function fnRentalPaging(p){
		// 페이징 영역 초기화
		$('#rentalPaging').empty();
		// 1페이지로 이동
		if (rentalPage == 1) {
			//$('<div class="disable_link">&lt;&lt;</div>').appendTo('#paging');
			$('<div>').addClass('disable_link').html('&lt;&lt;').appendTo('#rentalPaging');
		} else {
			//$('<div class="enable_link" data-page="1">&lt;&lt;</div>').appendTo('#paging');
			$('<div>').addClass('r_enable_link').html('&lt;&lt;').attr('data-page', 1).appendTo('#rentalPaging');
		}
		// 이전 블록으로 이동
		if (rentalPage <= p.pagePerBlock) {
			$('<div class="disable_link">&lt;</div>').appendTo('#rentalPaging');
		} else {
			$('<div class="r_enable_link" data-page="'+(p.beginPage-1)+'">&lt;</div>').appendTo('#rentalPaging');
		}
		// 페이지 번호
		for (let i = p.beginPage; i <= p.endPage; i++) {
			if (i == rentalPage) {
				$('<div class="disable_link now_page">'+i+'</div>').appendTo('#rentalPaging');
			} else {
				$('<div class="r_enable_link" data-page="'+i+'">'+i+'</div>').appendTo('#rentalPaging');
			}
		}
		// 다음 블록으로 이동
		if (p.endPage == p.totalPage) {
			$('<div class="disable_link">&gt;</div>').appendTo('#rentalPaging');
		} else {
			$('<div class="r_enable_link" data-page="'+(p.endPage+1)+'">&gt;</div>').appendTo('#rentalPaging');
		}
		// 마지막 페이지로 이동
		if (rentalPage == p.totalPage) {
			$('<div class="disable_link">&gt;&gt;</div>').appendTo('#rentalPaging');
		} else {
			$('<div class="r_enable_link" data-page="'+p.totalPage+'">&gt;&gt;</div>').appendTo('#rentalPaging');
		}
	}  // end fnPrintPaging
	
	function fnRChangePage(){
		$('body').on('click', '.r_enable_link', function(){
			rentalPage = $(this).data('page');
			fnRentalInfo();
		});
	}// fnRChangePage

<%-- ---------------------------------------------------------------------------------------------------------- --%>
	// 반납된 작품 정보
	function fnReturnedInfo(){
		$.ajax({
			url: '/rental/returnPage/' + returnPage,
			type: 'get',
			dataType: 'json',
			success: function(map){
				if(map.list == null){
					alert('렌탈 중인 목록을 볼러오지 못했습니다.');
				} else{
					fnPrintReturnInfo(map.list);		
					fnReturnPaging(map.returnUtils);
				}
			}
		});
	}
	
	// 반납된 목록 출력
	function fnPrintReturnInfo(list){
		$('#returnList').empty();
		$.each(list, function(i, item){
			$('<tr>')
			.append($('<td>').text(item.rentalNo))
			.append($('<td>').html($('<span class="art"><img class="artImg" src="'+ item.artwork.path +'"><ul><li class="boldFont">' + item.artwork.artName +'</li><li class="smallfont">'+ item.artwork.author.authorName +'</li></ul></span>')))
			.append($('<td>').text(item.startDate))
			.append($('<td>').text(item.endDate))
			.append($('<td>').html('<span class="etc_btn"><input type="button" class="writeReview" value="후기작성"><input type="button" value="내역삭제" class="deleteRentalList"><input type="hidden" class="rentalNo" value="'+ item.rentalNo +'"></span>'))
			.appendTo('#returnList');
			$('<tr data-rentalNo="'+ item.rentalNo +'">')
			.append('<td colspan="5" class="insertReview undisplay"><span>리뷰내용</span><textarea rows="5" cols="100" id="review_content"></textarea><input type="button" class="review_btn" value="작성완료"><input type="hidden" value="'+ item.artwork.artNo +'"></td>')
			.appendTo('#returnList')
		});
	} // fnPrintArtInfo

	var returnPage = 1;
	function fnReturnPaging(p){
		// 페이징 영역 초기화
		$('#returnPaging').empty();
		// 1페이지로 이동
		if (returnPage == 1) {
			//$('<div class="disable_link">&lt;&lt;</div>').appendTo('#paging');
			$('<div>').addClass('disable_link').html('&lt;&lt;').appendTo('#returnPaging');
		} else {
			//$('<div class="enable_link" data-page="1">&lt;&lt;</div>').appendTo('#paging');
			$('<div>').addClass('t_enable_link').html('&lt;&lt;').attr('data-page', 1).appendTo('#returnPaging');
		}
		// 이전 블록으로 이동
		if (returnPage <= p.pagePerBlock) {
			$('<div class="disable_link">&lt;</div>').appendTo('#returnPaging');
		} else {
			$('<div class="t_enable_link" data-page="'+(p.beginPage-1)+'">&lt;</div>').appendTo('#returnPaging');
		}
		// 페이지 번호
		for (let i = p.beginPage; i <= p.endPage; i++) {
			if (i == returnPage) {
				$('<div class="disable_link now_page">'+i+'</div>').appendTo('#returnPaging');
			} else {
				$('<div class="t_enable_link" data-page="'+i+'">'+i+'</div>').appendTo('#returnPaging');
			}
		}
		// 다음 블록으로 이동
		if (p.endPage == p.totalPage) {
			$('<div class="disable_link">&gt;</div>').appendTo('#returnPaging');
		} else {
			$('<div class="t_enable_link" data-page="'+(p.endPage+1)+'">&gt;</div>').appendTo('#returnPaging');
		}
		// 마지막 페이지로 이동
		if (returnPage == p.totalPage) {
			$('<div class="disable_link">&gt;&gt;</div>').appendTo('#returnPaging');
		} else {
			$('<div class="t_enable_link" data-page="'+p.totalPage+'">&gt;&gt;</div>').appendTo('#returnPaging');
		}
	}  // end fnPrintPaging
	// 반납 페이지 변경
	function fnTChangePage(){
		$('body').on('click', '.t_enable_link', function(){
			returnPage = $(this).data('page');
			fnReturnedInfo();
		});
	}// fnRChangePage
	
	// 리뷰 작성
	function fnWriteReview(){
		$('body').on('click', '.writeReview', function(){
				$('[data-rentalNo="'+ $(this).parent().find('.rentalNo').val() +'"]').children().toggleClass('undisplay');			
		});		
		$('body').on('click', '.review_btn', function(){
			console.log($(this).prev().val())
			let loginNo = '${loginUser.userNo}'
			let rArtNo = $(this).next().val();
			let review = JSON.stringify({
				artNo : rArtNo,
				userNo : loginNo ,
				reviewContent : $(this).prev().val(),  
				starRating : 1
			})
			$.ajax({
				url : '/reviews',
				type : 'post',
				data : review,
				contentType: 'application/json',
				dataType: 'json',
				success : function(map){
					if(map.result > 0){
						if(confirm('리뷰가 등록되었습니다. 확인하러 이동하시겠습니까?')){
							location.href='/art/view/' + rArtNo;
						}else{
							return;
						}
					} else{
						alert('리뷰 등록 실패');
					}
				}						
			});			
		});		
	}// fnWriteReview
	
	function fnDeleteRental() {
		$('body').on('click', '.deleteRentalList', function(){
			if(confirm('구매내역을 삭제하면 후기를 작성하실 수 없습니다. 그래도 삭제하시겠습니까?')){
				let rentalNo = $(this).next().val();
				$.ajax({
					url: '/rental/return/' + rentalNo,
					type: 'get',
					datatype: 'json',
					success: function(map){
						alert(map.message);
						fnReturnedInfo();
					}				
				});				
			};
		});
	}
	
</script>
<style>
	li {
		list-style-type: none;
	}
	label {
		display: inline-block;
		width: 100px;
	}
	.artwork_list{
		display: flex;
	}
	table{
		width: 800px;
		margin: 0 auto;
		text-align: center;
		border-collapse: collapse;
		border-top: 2px solid black;
	}
	thead{
		background-color: rgb(237, 237, 238);
	}
	.artImg{
		width: 80px;
		height: 80px;
	}
	.art{
		display: flex;
	}
	.smallfont{
		font-size: 12px;
		color: darkgray;
	}
	.boldFont{
		font-weight: bold;
		font-size: 14px;
	}
	.etc_btn{
		display: inline-grid;
		
	}
	#rentalPaging{
		display: flex;
		justify-content: center;
	}
	#rentalPaging div{
		padding-right: 5px;
	}
	#returnPaging{
		display: flex;
		justify-content: center;
	}
	#returnPaging div{
		padding-right: 5px;
	}
	.disable_link {
		color: lightgray;
	}
	.r_enable_link {
		cursor: pointer;
	}
	.t_enable_link {
		cursor: pointer;
	}
	.now_page {
		color: red;
	}
	.undisplay{
		display: none;
	}
</style>
</head>
<body>
	<jsp:include page="../component/nav.jsp"></jsp:include>


	<h3>${loginUser.userName}님 반갑습니다.</h3>
	<hr>
	<section class="orderList_wrapper">
		<table class="rental_orderList" border="1"">
			<caption><h3>현재 렌탈 중인 작품</h3></caption>
			<thead>
				<tr>
					<td>주문번호</td>
					<td>주문작품</td>
					<td>주문일자</td>
					<td>반납예정일</td>
					<td>기타</td>
				</tr>
			</thead>
			<tbody id="rentalList"></tbody>
			<tfoot>
				<tr>
					<td colspan="5"><span id="rentalPaging"></span></td>
				</tr>
			</tfoot>
		</table>
		<table class="returned_orderList" border="1">
			<caption><h3>반납이 완료된 작품</h3></caption>
			<thead>
				<tr>
					<td>주문번호</td>
					<td>주문작품</td>
					<td>주문일자</td>
					<td>반납예정일</td>
					<td>기타</td>
				</tr>		
			</thead>
			<tbody id="returnList"></tbody>
			<tfoot>
				<tr>
					<td colspan="5"><span id="returnPaging"></span></td>
				</tr>
			</tfoot> 
		</table>
	</section>
	
	<jsp:include page="../component/footer.jsp"></jsp:include>
</body>
</html>