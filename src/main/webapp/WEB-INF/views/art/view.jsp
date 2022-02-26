<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<link href="/css/artwork/view.css" rel="stylesheet" type="text/css">
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script> 
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script type="text/javascript">
	$(document).ready(function(){
		fnArtInfo();
		fnAddCart();
		fnArtRental();
		fnFindAllReview();
		fnToggleCommentInput();
		fnCommentsList();
		fnAddComment();
		fnToggleCommentModify();
		fnModifyComment();
		fnRemoveComment();
	});
	var artURL = '${pageContext.request.serverName}:${pageContext.request.serverPort}/art/view/';
	
	function fnArtInfo(){
			let artNo = '${artNo}';
			$.ajax({
				url: '/art/' + artNo,
				type: 'get',
				dataType: 'json',
				success: function(map){
					console.log(map);
					let artwork = map.artwork;
					fnInit();
					$('<ul class="art_Title">')
					.append($('<li>').html('<h2 id="title">'+artwork.artName+'</h2>'))
					.appendTo('#art_info');
					$('<ul>')
					.append($('<li id="author">').html(artwork.author != null ? '<span class="info">작가명</span> ' + artwork.author.authorName : '&nbsp;'))
					.append($('<li>').html('<input type="hidden" id="theme" value="' + artwork.theme + '">'))
					.append($('<li>').html('<span class="info">렌탈가</span>' + artwork.price + '원'))	
					.appendTo('.art_detail');
					$('<ul class="art_button">')					
					.append($('<li>').html('<input type="button" class="addCart" value="장바구니에 등록"><input type="hidden" id="artNo" name="artNo" value="'+ artwork.artNo +'"><input type="button" class="artRental" value="렌탈하기">'))	
					.appendTo('.art_detail');
					$('#art_img').html('<img class="art_img" id="imgPath" src="' + artwork.path + '"><input type="hidden" value="' + artwork.path + '">');
			
				}				
			}); // ajax	
	}// end fnArtFind
	
	function fnAddCart(){
		$('body').on('click', '.addCart', function(){
			if( '${loginUser == null}' == 'true' ){
				swal("로그인이 필요합니다!", "You clicked the button!", "error");
				return;
			}else{
				let cart = JSON.stringify({
					artNo : $(this).next().val(),
					userNo : '${loginUser.userNo}'
				});
				$.ajax({
					url: '/cart',
					type: 'post',
					contentType: 'application/json',
					data: cart,
					dataType: 'json',
					success: function(map){
						Swal.fire({
							  title: map.message,
							  text: "장바구니 목록으로 이동하시겠습니까?",
							  icon: 'warning',
							  showCancelButton: true,
							  confirmButtonColor: '#3085d6',
							  cancelButtonColor: '#d33',
							  confirmButtonText: '장바구니'
							}).then((result) => {
							  if (result.isConfirmed) {
								  location.href='/cart/';		
							  }
							})
					}
				});							
			}
		});
	}// end fnAddCart
	
	function fnArtRental(){
		
		$('body').on('click', '.artRental', function(){
			if( '${loginUser == null}' == 'true' ){
				swal("로그인이 필요합니다!", "You clicked the button!", "error");
				return;
			} else{
				let artNo = [];
				artNo.push( $(this).prev().val() );				
				$.ajax({
					url:  '/rental/check/' + artNo,
					type: 'get',
					dataType: 'json',
					success: function(map){
						if(map.status == 402){
							let artMap = []
							$.each(map.list, function(i, rental){
								artMap.push(rental.artwork.artName);
							});
							swal(artMap + "은 이미 렌탈 중인 작품입니다.", "You clicked the button!", "error");
						} else{
							let timerInterval
							Swal.fire({
							  title: '주문하러 이동합니다.',
							  html: '페이지 이동 중',
							  timer: 1000,
							  timerProgressBar: true,
							  didOpen: () => {
							    Swal.showLoading()
							    const b = Swal.getHtmlContainer().querySelector('b')
							    timerInterval = setInterval(() => {
							      b.textContent = Swal.getTimerLeft()
							    }, 100)
							  },
							  willClose: () => {
							    clearInterval(timerInterval)
							  }
							}).then((result) => {
							  /* Read more about handling dismissals below */
							  location.href= '/rental/order/' + artNo;
							})
							 							
						}
					}
				});			
			}
		});		
		
	}// fnArtRental
	
	function fnInit(){
		$('#art_list').empty();
		$('#art_info').empty();
		$('#paging').empty();
	}
	
	// 카카오톡 링크복사
	function fnKaKaoLink(){
	    // SDK를 초기화 합니다. 사용할 앱의 JavaScript 키를 설정해 주세요.
        Kakao.init('69be99100c920c1a01740a6e40e2b8f8');
        // SDK 초기화 여부를 판단합니다.
        console.log(Kakao.isInitialized());

        let artTitle = $('#title').text(); 
		let author = $('#author').text();
		let theme = $('#theme').val();
		let artNo = $('#artNo').val();
		let path = $('#imgPath').next().val();
        
		Kakao.Link.createDefaultButton({
			container: '#create-kakao-link-btn',
			objectType: 'feed',
			content: {
				title:  'Practice_project: ' + artTitle,
				description: '#'+ author + ' #'+ artTitle + ' #' + theme,
			    imageUrl: path,
			    link: {
			      mobileWebUrl: artURL + artNo,
			      webUrl: artURL + artNo,
			    },
			},
			    
			buttons: [
				{
			    	title: '웹으로 보기',
			        link: {
			       		mobileWebUrl:artURL + artNo,
			          	webUrl: artURL + artNo,
			        },
			      }
			 ],
		});
	}
	
	function fnClipboard(){
		let artNo = $('#artNo').val();
		var url = '';
		var textarea = document.createElement("textarea");
		document.body.appendChild(textarea);
		url = window.document.location.href;
		textarea.value = artURL + artNo;
		textarea.select();
		document.execCommand("copy");
		document.body.removeChild(textarea);
		alert("URL이 복사되었습니다.");
	}
	
	// 날짜 함수
	function getDateFormat(date) {
		var d = new Date(date);
		var year = d.getFullYear();
		var month = '' + (d.getMonth() + 1);
		var day = '' + d.getDate();
		if (month.length < 2) {
			month = '0' + month;
		}
		if (day.length < 2) {
			day = '0' + day;
		}
		return [year, month, day].join('-');
	}
	
	// 리뷰 목록 함수
	function fnFindAllReview(){
		let artNo = '${artNo}';
		$.ajax({
			url : '/reviews/' + artNo,
			type : 'get',
			dataType : 'json',
			success : function(map){
				$('#review_list').empty();
				//console.log("리뷰");
				//console.log(map);
				if (map.reviewList.length > 0) {
					$.each(map.reviewList, function(i, review){
						$('<div class="review_content">')
						/* 리뷰 + 댓글박스 버튼*/
						.append($('<div class="review_content_header">')
									.append($('<span class="nickname">').text(review.member.nickName))
									.append($('<span>').html(review.starRating + '<br>')))
						.append($('<button class="comment_input_btn">').html(review.reviewContent))
						.appendTo($('#review_list'));
						/* 댓글 입력 박스 영역*/
						$('<div class="comment_wrap">')
						.append($('<span class="comment_inputBox">').html('<textarea name="" id="comment_content" cols="45" rows="10"></textarea><input type="hidden" id="nickName" name="nickName" value="'+ review.member.nickName +'"><br>'))
						.append($('<span>').html('<input type="hidden" class="reviewNo" value="' + review.reviewNo +'">'))
						.append($('<span>').html('<input type="button" class="comment_insert_btn" value="댓글 등록">'))
						.append($('<div class="comment_list" data-reviewno="'+ review.reviewNo +'">').html(fnCommentsList(review.reviewNo)
																		.then(function(map){ 
																			$.each(map.list, function(i, comments){
																				//console.log("댓글");
																				console.log(map.list);
																				//console.log(review.reviewNo);
																				//console.log($('[data-reviewno="'+ review.reviewNo +'"]'));
																				/* 댓글 + 수정+ 삭제 버튼*/
																				$('<div class="comment_content">')
																				.append($('<span class="comment_commentContent">').text(comments.commentContent))
																				.append($('<span class="comment_nickname">').text(comments.member.nickName))
																				.append($('<span class="comment_created">').text(getDateFormat(comments.commentCreated)))
																				.append($('<span>').html('<input type="button" class="comment_update_btn" value="수정">'))
																				.append($('<span>').html('<input type="button" class="comment_delete_btn" value="삭제"><br>'))
																				.appendTo($('[data-reviewno="'+ review.reviewNo +'"]'));
																				/* 댓글 수정 박스 영역*/
																				//$('.update_comment_wrap').empty();
																				$('<div class="update_comment_wrap">')
																				.append($('<span class="comment_modifyBox">').html('<textarea name="" id="update_content" cols="45" rows="5"></textarea><br>'))
																				.append($('<span>').html('<input type="hidden" class="commentNo" value="' + comments.commentNo +'">'))
																				.append($('<span>').html('<input type="button" class="comment_modify_btn" value="등록">'))
																				.appendTo($('.comment_list'));
																			});
																			})
																		.catch(function(errorMessage){ console.log(errorMessage); })))
						.appendTo($('#review_list'));
					});
				} else {
					$('<div class="review_content">')
					.append($('<span>').text('이 작품에는 현재 리뷰가 없습니다'))
					.append($('<span>').html(''))
					.appendTo($('#review_list'));
				}
			} 
		});
	} // end fnFindAllReview
	
	// 댓글박스 on/off 함수
	function fnToggleCommentInput(){
		$('body').on('click', '.comment_input_btn', function(){
			if($(this).parent().next().css('display') == 'none') {
				$(this).parent().next().show();
			} else {
				$(this).parent().next().hide();
			}
		});
	} // end fnToggleCommentinput
	
	// 댓글 목록 출력 함수
	function fnCommentsList(reviewNo){
		if(reviewNo != null){
			return new Promise(function(resolve, reject){  
				$.get('/comments/' + reviewNo, function(map){
					if (map.list.length > 0 ){
						resolve(map);
					} else {
						reject('request failed');
					}
				});
			});
		}
	}   // end fnCommentsList
	
	// 댓글 삽입 함수
	function fnAddComment(){
		
		$('body').on('click', '.comment_insert_btn', function(){
			if( '${loginUser == null}' == 'true' ){
					alert('댓글을 달기 위해서는 로그인이 필요합니다.');
					return;
			}else{
				let commentReviewNo = $(this).parent().prev().find('.reviewNo').val();
				let comments = JSON.stringify({ 
					commentContent: $(this).parent().prev().prev().find('#comment_content').val(),
					reviewNo: commentReviewNo,
					userNo: '${loginUser.userNo}',
					nickName: '${loginUser.nickName}',
					depth: 0,
					groupNo: 0,
					commentOrd: 0
				});
				console.log(comments);
				$.ajax({
					url: '/comments',
					type: 'post',
					contentType: 'application/json',
					data: comments,
					dataType: 'json',
					success: function(map) {
						if (map.result > 0) {
							alert('댓글이 작성 되었습니다.');
							fnFindAllReview();
						} else {
							alert('허허');
						}
					}
				});
			}
		});
	} // end fnAddComment
	
	
	// 댓글 수정박스 on/off 함수
	function fnToggleCommentModify(){
		$('body').on('click', '.comment_update_btn', function(){
			if($(this).parent().parent().next().css('display') == 'none') {
				$(this).parent().parent().next().show();
			} else {
				$(this).parent().parent().next().hide();
			}
		});
	} // end fnToggleCommentModify
	
	// 댓글 수정 함수
	function fnModifyComment(){
		$('body').on('click', '.comment_modify_btn', function(){
			let comments = JSON.stringify({
				commentContent: $(this).parent().prev().prev().find('#update_content').val(),
				commentNo: $(this).parent().prev().find('.commentNo').val(),
				userNo: '${loginUser.userNo}',
			});
			$.ajax({
				url: '/comments',
				type: 'put',
				contentType: 'application/json',
				data: comments,
				dataType: 'json',
				success: function(map){
					if (map.result > 0) {
						alert('댓글이 수정 되었습니다.');
						fnFindAllReview();
					} else {
						alert('댓글 수정이 불가능합니다')
					}
				}
			})
		});
	} // end FnModifyComment
	
	// 댓글 삭제 함수
	function fnRemoveComment(){
		$('body').on('click', '.comment_delete_btn', function(){
			let commentNo = $(this).parent().parent().next().find('.commentNo').val();
			if (confirm('댓글을 삭제 하시겠습니까?')) {
				$.ajax({
					url: '/comments/' + commentNo,
					type: 'delete',
					dataType: 'json',
					success: function(map){
						if (map.result > 0) {
							alert('댓글이 삭제 되었습니다');
							$('.comment_wrap').load('/comments/' + commentNo);
							$('#review_list').empty();
							$('.comment_list').empty();
							fnFindAllReview();
							 // $('.comment_wrap').load(location.href+' .comment_wrap>*',"");
						} else {
							alert('댓글이 삭제되지 않았습니다');
						}
					}
				});
			}
		});
	}
	
	function fnInit(){
		$('#art_list').empty();
		$('#art_info').empty();
		$('#paging').empty();
		$('#review_list').empty();
		$('.comment_list').empty();
	}
	
	
</script>
<style type="text/css">
	*{
		margin: 0px;
		padding: 0px;
		box-sizing: border-box;
	}
	a{
		text-decoration: none;
	}
	#create-kakao-link-btn > img {
		border-radius: 100%;
	}
	.fa-link{
		width: 34px;
		height: 35px;
		text-align: center;
		font-size: 20px;
		line-height: 35px;
		color: white;
		background-color: slategray;
		border: 1px solid gray;
		border-radius: 100%;
	}
	.fa-link:hover{
		cursor: pointer;
	}
	.link_wrapper{
		display: flex;
	}
	#create-kakao-link-btn{
		padding-right: 10px
	}
	.comment_input_btn {
		cursor: pointer;
		background-color:transparent;
		border: none;
	}
	.comment_wrap {
		display: none;
	}
	
	.update_comment_wrap {
		display: none;
	}
	
</style>
</head>
<body>
	<jsp:include page="../component/nav.jsp"></jsp:include>
	

	<div class="art_container">
		<div class="selectArt">
			<div id="art_img"></div>
		</div>
		<div class="art_info">
			<div id="art_info"></div>
			<div class="link_wrapper">
				<a id="create-kakao-link-btn" href="javascript:;">
				  <img src="https://developers.kakao.com/assets/img/about/logos/kakaolink/kakaolink_btn_small.png" onclick="fnKaKaoLink();"/>
				</a>
				<i class="fas fa-link" onclick="fnClipboard();"></i>
			</div>
			<div class="art_detail"></div>
		</div>
	</div>
	
	<hr>
	<!-- 리뷰 게시판 -->
	<div class="review_wrap">
		<h1 class="review_header">리뷰</h1>
		<div id="review_list"></div>
	</div>
	
	<jsp:include page="../component/footer.jsp"></jsp:include>
</body>
</html>