<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/cart/list.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" integrity="sha512-9usAa10IRO0HhonpyAIVpjrylPvoDwiPUiKdWk5t3PyolY1cOd4DSE0Ga+ri4AuTroPR5aQvXU9xC6qOPnzFeg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script type="text/javascript">
	$(document).ready(function(){
		fnCartList();
		fnDeleteCart();
		fnListDelete();
		fnCheckAll();
		fnCheckRental();
	});
	
	// 장바구니 목록
	function fnCartList(){
			$.ajax({
				url: '/cart/' + '${loginUser.userNo}',
				type: 'get',
				dataType: 'json',
				success: function(map){
					fnPrintCartList(map);
				}
			});				
	}
	
	// 장바구니 목록 출력
	function fnPrintCartList(map){
		fnInit();
		if(map.status == 200){
			console.log(map)
			$.each(map.list, function(i, cart){
				$('<tr class="art_wrap">')
				.append($('<td>').html('<input type="checkbox" class="checkArt" name="checkArt" value="'+ cart.cartNo +'"><input type="hidden" value="'+ cart.artwork.artNo +'">'))
				.append($('<td class="artInfo">').html('<img src="'+ cart.artwork.path +'" style="width : 150px;"><ul class="art_info"><li><h3>'+ cart.artwork.artName +'</h3></li><ul>'))
				.appendTo($('#cart_List'));
				$('<li>').html(cart.artwork.author != null ? '<li><span>작가명: </span>'+ cart.artwork.author.authorName : '&nbsp;')
				.appendTo($('.art_info'));
				$('<td>').text(cart.artwork.price + '원')
				.appendTo($('.art_wrap'));
				$('<td>').html('<input type="hidden" value="'+cart.cartNo+'"><i class="fa-solid fa-trash-can delete_btn"></i>')
				.appendTo($('.art_wrap'));
			});
		} else{
			$('<tr>')
			.append($('<td colSpan="3">').text(map.message))
			.appendTo($('#cart_List'));
		}
		$('#totalCount').text('작품 수: ' + map.totalCount);
		$('#totalPrice').text('총 렌탈가격: ' + map.totalPrice + '원');
	}// fnPrintCartList
	
	function fnDeleteCart(){
		$('body').on('click', '.delete_btn', function(){
			if(confirm('정말로 삭제하시겠습니까?')){
				let cartNo = $(this).prev().val(); 
				$.ajax({
					url: '/cart/' + cartNo,
					type: 'delete',
					dataType: 'json',
					success: function(map){
							if(map.result > 0){
								alert('삭제 되었습니다.')						
							} else{
								alert('삭제되지 않았습니다.')
							}
						fnCartList();
					} 
				});
			} else{
				return;
			}
		});		
	}// fnDeleteCart
	
	// 체크된 목록 삭제
	function fnListDelete(){
		$('body').on('click', '#listDelete_btn', function(){
			let checkList = [];
			$('input[name="checkArt"]:checked').each(function(i){
				checkList.push($(this).val());  
			});
			if(checkList.length == 0){
				alert('삭제할 작품을 선택해주세요')
			} else{
				if(confirm('정말로 삭제하시겠습니까?')){
					$.ajax({
						url: '/cart/' + checkList,
						type: 'delete',
						dataType: 'json',
						success: function(map){
							if(map.result > 0){
								alert('삭제 되었습니다.')						
							} else{
								alert('삭제되지 않았습니다.')
							}
							fnCartList();
						}
					});
				} else{
					return;
				}
			}
		});
	}// end fnDeleteCheckbox
	
	// 체크 렌탈 (작품 중복 체크 및 렌탈페이지로 이동)
	function fnCheckRental(){
		$('body').on('click', '#listRental_btn', function(){
			let artNo = [];
			$('input[name="checkArt"]:checked').each(function(i){
				artNo.push($(this).next().val());  
			});
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
						alert(artMap + "은 이미 렌탈 중인 작품입니다.")
					} else{
						location.href= '/rental/order/' + artNo; 							
					}
				}
			});
		});
	}// fnCheckRental
	
	// 전체 체크 
	function fnCheckAll(){
		$(".checkAll_btn").click(function(){
		    if($(this).prop("checked")){
		    	$("input[name=checkAll]").prop("checked", true);
		        $("input[name=checkArt]").prop("checked",true);   // 전체 체크
		    }else{
		    	$("input[name=checkAll]").prop("checked", false);
		        $("input[name=checkArt]").prop("checked",false);  // 전체 체크 해제
		    }
		});
	} // end fnAllCheck;
	
	function fnInit(){
		$('#cart_List').empty();
		$('#totalCount').empty();
		$('#totalPrice').empty();
	}
	
	$.fn.colspan = function(rowIdx) {
		return this.each(function(){
			
			var that;
			$('tr', this).filter(":eq("+rowIdx+")").each(function(row) {
				$(this).find('td').filter(':visible').each(function(col) {
					if ($(this).html() == $(that).html()) {
						colspan = $(that).attr("colSpan") || 1;
						colspan = Number(colspan)+2;
						
						$(that).attr("colSpan",colspan);
						$(this).hide(); // .remove();
					} else {
						that = this;
					}
					
					// set the that if not already set
					that = (that == null) ? this : that;
					
				});
			});
		});
	}
</script>
</head>
<body>
		<jsp:include page="../component/nav.jsp"></jsp:include>
		
	
		<table class="cartTable" id="cart">
			<thead class="cart_header">
				<tr>
					<td>
						<input type="checkbox" name="checkAll" class="checkAll_btn">
					</td>
					<td>작품정보</td>
					<td colspan="2">렌탈가격</td>
				</tr>
			</thead>
			<tbody id="cart_List"></tbody>
			<tfoot id="carts_wrapper">
				<tr>
					<td class="cartTableFooter">
						<input type="checkbox" name="checkAll" class="checkAll_btn">
					</td>
					<td colspan="2" class="btn">
						<input class="AllDeleteBtn" type="button" id="listDelete_btn" value="삭제">
						<input class="rentalBtn" type="button" id="listRental_btn" value="렌탈하기">					
					</td>
					<td></td>
				</tr>
			</tfoot>
		</table>
		<footer class="total">
			<div><span class="totalCount" id="totalCount"></span></div>
			<div><span class="totalPrice" id="totalPrice"></span></div>
		</footer>
	<jsp:include page="../component/footer.jsp"></jsp:include>

</body>
</html>