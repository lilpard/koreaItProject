<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/member/login.css"> 
<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
<script type="text/javascript">
	$(document).ready(function() {
		fnInit();
		fnLogin();

	});
	// 경고 메시지 초기화 함수
	function fnInit(){
		$('input').focus(function(){
			$('#email_result').text('');
			$('#pw_result').text('');
		});
	} // end fnInit

	// 정규식 및 로그인
	function fnLogin() {
		$('#login_btn').click(function() {
			
			// 이메일, 비밀번호 정규식 체크
			let regEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
			let regPw = /^(?=.*[a-zA-Z])(?=.*[0-9]).{6,16}$/;
			if ( regEmail.test($('#email').val()) == false &&
				 regEmail.test($('#email').val()) == false ) {
				$('#email_result').text('이메일 또는 비밀번호가 올바르지 않습니다.');
				return true;
			}
			
			let member = JSON.stringify({
				email : $('#email').val(),
				pw : $('#pw').val()
			});
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
	}
</script>
<style type="text/css">
	.error_result span {
		color : red;
	}
</style>
</head>
<body>
	<jsp:include page="../component/nav.jsp"></jsp:include>
	

	<div class="wrapper">
		<div class="wrap">
			<div class="logo_wrap">
				<span>로그인</span>
			</div>
			<div class="login_wrap">
				<div class="id_wrap">
					<div class="id_input_box">
						<input class="id_input" id="email">
					</div>
				</div>
				<div class="pw_wrap">
					<div class="pw_input_box">
						<input class="pw_iput" id="pw">
					</div>
				</div>
				<div class="login_btn_wrap">
					<div class="error_result">
						<span id="email_result"></span><br>
					</div>	
						<input type="button" class="login_btn" id="login_btn" value="로그인">
				</div>
				<footer class="findIdPw">
					<span>아직 회원이 아니시라면</span>
					<a href="/member/joinPage">회원가입</a><br>
					<a href="/member/findIdPage">아이디</a> /
					<a href="/member/findPwPage">비밀번호</a> 찾기
				</footer>
			</div>
		</div>
	</div>

	<jsp:include page="../component/footer.jsp"></jsp:include>
</body>
</html>