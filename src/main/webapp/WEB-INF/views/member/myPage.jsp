<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/member/myPage.css"> 
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" integrity="sha512-9usAa10IRO0HhonpyAIVpjrylPvoDwiPUiKdWk5t3PyolY1cOd4DSE0Ga+ri4AuTroPR5aQvXU9xC6qOPnzFeg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
<script type="text/javascript">
	$(document).ready(function(){
		fnModifyPw();
		fnModifyTel();
		fnDeleteMember();
	});
	
	// 비밀번호 변경
	function fnModifyPw(){
		$('#changePw_btn').click(function(){
			let regPw = /^(?=.*[a-zA-Z])(?=.*[0-9]).{6,16}$/;
			if ( $('#now_pw').val().length <= 5 && $('#new_pw').val().length <= 5 ) {
				alert('비밀번호는 6자 이상 입력하셔야 합니다.');
				return;
			}
			
			if ($('#now_pw').val() == "") {
				alert ('입력하신 값이 잘못되었습니다. 다시 한 번 시도해주세요.');
				return;
			}
			
			if ( $('#new_pw').val() != $('#new_pwck').val()) {
				alert('비밀번호가 일치하지 않습니다.');
				return;
			}
			
			let member = JSON.stringify({
				email : $('#email').val(),
				pw : $('#new_pw').val()
			});
			$.ajax({
				url : '/members/changePw',
				type : 'put',
				contentType : 'application/json',
				data : member,
				dataType : 'json',
				success : function(map){
					if (map.result > 0) {
						alert('비밀번호 변경완료');
						location.reload();
					}
					else if ('${loginUser.pw}' != $('#now_pw').val()) {
						alert('기존비밀번호가 올바르지 않습니다.');
					}
				}
			});
		});
	} // end fnModifyMember
	
	// 휴대폰 번호 변경 
	function fnModifyTel(){
		$('#changeTel_btn').click(function(){
			let regTel = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
			if ( regTel.test($('#new_tel').val()) == false) {
				alert('전화번호를 입력해주세요.');
				return;
			}
			if ($('#new_tel').val() == "") {
				alert ('입력하신 값이 잘못되었습니다. 다시 한 번 시도해주세요.');
				return;
			}
			
			let member = JSON.stringify({
				email : $('#email').val(),
				tel : $('#new_tel').val()
			});
			$.ajax({
				url : '/members/changeTel',
				type : 'put',
				contentType : 'application/json',
				data : member,
				dataType : 'json',
				success : function(map) {
					if (map.result > 0) {
						alert('휴대폰번호 변경완료');
						location.reload();
					} else {
						alert('휴대폰번호 변경실패');
					}
				}
			});
		});
	} // end fnModifyTel
	
	// 회원 삭제 함수
	function fnDeleteMember(){
		$('#delete_member_btn').click(function(){
			if(confirm('정말 탈퇴하실건가요?'))	{
				$.ajax({
					url : '/members/' + $('#userNo').val(),
					type : 'delete',
					contentType : 'application/json',
					dataType: 'json',
					success: function(map){
						if (map.result > 0) {
							alert('탈퇴 되었습니다. ㅜㅜ');
							location.href = '/';
						} else {
							alert('문제가 발생 했습니다.');
						}
					}
				});
			}
		});
	} // end fnDeleteMember
	
	
	
	
</script>
</head>
<body>
	<jsp:include page="../component/nav.jsp"></jsp:include>

	<div class="member_info_box">
		<div class="helloUser">
			<h4>${loginUser.userName}님 반갑습니다</h4>
		</div>
		<br>
		<hr>
		<div class="content">
			<header>
				<h1>회원 정보</h1>
				<h5>고객님과 관련된 정보입니다.</h5>
			</header>
			
			<hr>
			
			<div class="info_row">
				<div class="info_wrap">
					<div class="row">
						<div class="columnName"><i class="fa-solid fa-star star"></i>이메일</div>
						${loginUser.email}
						<div>
							<input type="hidden" id="email" value="${loginUser.email}">
							<input type="hidden" id="userNo" value="${loginUser.userNo}">
						</div>	
					</div>
					<div class="row">
					    <div class="columnName"><i class="fa-solid fa-star star"></i>비밀번호</div>
						<input class="column" type="text" id="now_pw" placeholder="기존 비밀번호"><br>
					</div>
					<div class="row marginLeft_row">
						<input class="column" type="text" id="new_pw" placeholder="새 비밀번호"><br>
					</div>
					<div class="row marginLeft_row">
						<input class="column" type="text" id="new_pwck" placeholder="새 비밀번호 확인">
						<input type="button" class="changeBtn" id="changePw_btn" value="변경">
					</div>
					<div class="row">
						<span class="columnName"><i class="fa-solid fa-star star"></i>이름</span>
						<div class="column">
							${loginUser.userName}
						</div>
					</div>
					<div class="row">
					    <div class="columnName"><i class="fa-solid fa-star star"></i>휴대폰</div>
						<div class="column">
							${loginUser.tel}<br>
						</div>
					</div>
					<div class="row marginLeft_row">
						<input type="text" id="new_tel" placeholder="새 전화번호">
						<input type="button" class="changeBtn" id="changeTel_btn" value="변경">
					</div>
					<hr>
				</div>
			</div>
			<input type="button" class="deleteBtn" value="탈퇴" id="delete_member_btn">
			<input type="button" class="saveBtn" value="저장">
		</div>
	</div>
	
	<jsp:include page="../component/footer.jsp"></jsp:include>

</body>
</html>