<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/member/findPwPage.css">
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script type="text/javascript">
	$(document).ready(function(){
		fnSendAuthCode();
		fnLogin();
	});
	// 이메일 인증코드 전송함수
	function fnSendAuthCode(){
		$('#authCode_btn').click(function(){
			let regEmail = /^[a-zA-Z0-9-_]+@[a-zA-Z0-9]+([.][a-zA-Z]{2,}){1,2}$/;
			if ( regEmail.test($('#email').val()) == false ) {
				alert('이메일 형식을 확인하세요.');
				return;
			}
			$.ajax({
				url: '/member/sendAuthCode',
				type: 'post',
				data: 'email=' + $('#email').val(),
				dataType: 'json',
				success: function(map) {
					alert(map.message);
					fnVerifyAuthCode(map.authCode);
				},
				error: function() {
					alert('인증코드 전송 실패');
				}
			});
		});
	}  // end fnSendAuthCode
	
	// 인증코드 검증 함수
	function fnLogin() {
		$('#login_btn').click(function(){
			let member = JSON.stringify({
				email : $('#email').val(),
				pw : $('#pw').val()
			});
			console.log(member);
			$.ajax({
				url : '/members/login',
				type : 'post',
				contentType : 'application/json',
				data : member,
				dataType : 'json',
				success : function(map) {
					console.log(map);
					if (map.result) {
						alert('로그인 성공');
						location.href = '/';
					} else {
						$('#email_result').text('이메일과 비밀번호를 다시 한 번 확인해주세요.');
						
					}
				},
				error : function() {

				}
			})
		});
	}  // end fnVerifyAuthCode
</script>
</head>
<body>
	<jsp:include page="../component/nav.jsp"></jsp:include>
	
	<div class="wrap">
		<h1 class="wrap_header">비밀번호 찾기 화면</h1>
		
		<form id="f" method="post">
			<div class="wrapper">
				<span class="inputSpan">가입 당시 이메일</span><br>
				<input type="text" name="email" id="email">
				<input type="button" value="임시비밀번호 발급" id="authCode_btn"><br>
				<input type="text" name="pw" id="pw">
				<input type="button" value="임시비밀번호로 로그인" id="login_btn"><br><br>
			</div>
		
		</form>
	</div>

	<jsp:include page="../component/footer.jsp"></jsp:include>
</body>
</html>