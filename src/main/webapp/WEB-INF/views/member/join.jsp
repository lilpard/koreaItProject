<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/member/join.css">
<script src="https://code.jquery.com/jquery-3.4.1.js"integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="crossorigin="anonymous"></script>
<script>
	$(document).ready(function() {
		fnInit();
		fnAuthCode();
		//fnCheckMember();
		fnAddMember();
	});
	
	function fnAuthCode(){
		$('.mail_code_button').on('click', function(){
			
		});
	}
	
	// 경고 메시지 초기화 함수
	function fnInit(){
		$('input').focus(function(){
			$('#email_result').text('');
			$('#pw_result').text('');
			$('#pwck_result').text('');
			$('#name_result').text('');
			$('#nickName_result').text('');
			$('#tel_result').text('');
		});
	} // end fnInit
	
	//정규식 및 회원가입 함수
	function fnAddMember() {
		$('#join_btn').click(function(){
			// 정규식 이메일 체크
			let regEmail = /^[a-z]+[a-z0-9]{5,19}$/g;
			if ( regEmail.test($('#emailId').val()) == false) {
				$('#email_result').text('이메일을 입력해주세요.');
				return true;
			}
			
			// 비밀번호 정규식, 길이체크
			let regPw = /^(?=.*[a-zA-Z])(?=.*[0-9]).{6,16}$/;
			if ( $('#pw').val().length <= 5) {
				$('#pw_result').text('비밀번호는 6자 이상 입력하셔야 합니다.');
				return true;
			}
			
			// 비밀번호 동일한 지 체크
			if ( $('#pw').val() != $('#pwck').val()) {
				$('#pwck_result').text('비밀번호가 동일하지 않습니다.');
				return true;
			}
			
			// 이름 정규식 체크
			let regName = /^[가-힣]{2,4}$/;
			if ( regName.test($('#userName').val()) == false) {
				$('#name_result').text('이름을 입력해주세요.');
				return true;
			}
			
			// 닉네임 정규식 체크
			let regNickName = /^[가-힣ㄱ-ㅎa-zA-Z0-9._ -]{2,}$/;
			if ( regNickName.test($('#nickName').val()) == false) {
				$('#nickName_result').text('닉네임을 입력해주세요.');
				return true;
			}
			// 전화번호 정규식 체크
			let regTel = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
			if ( regTel.test($('#tel').val()) == false) {
				$('#tel_result').text('전화번호를 입력해주세요.');
				return true;
			}
			
			let member = JSON.stringify({
				email: $('#emailId').val()+ '@' + $('#textEmail').val(),
				pw: $('#pw').val(),
				userName: $('#userName').val(),
				nickName: $('#nickName').val(),
				tel: $('#tel').val()
			});
			$.ajax({
				url: '/members/join',
				type: 'post',
				contentType: 'application/json',
				data: member,
				dataType: 'json',
				success: function(map){
					if (map.result > 0) {
						alert('회원 등록이 되었습니다.');
						location.href = '/';
					} else {
						alert('회원이 등록되지 않았습니다.');
					}
				},
				error: function(xhr){
					if (xhr.status == 500) {
						alert(xhr.responseText);
					} else if (xhr.status == 501) {
						alert(xhr.responseText);
					}
				}
			});
		});
	} // end fnAddMember
	
	// 도메인(이메일) 변경 함수
	$(function(){
		$('#select').change(function(){
			if ($('#select').val() == 'directly') {
				$('#textEmail').attr("disabled", false);
				$('#textEmail').val("").attr('#select');
				$('#textEmail').focus();
			} else {
				$('#textEmail').val($('#select').val());
			}
		});
	});
	
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
			<div class="subjecet">
				<input type="hidden" name="userNo" id="userNo">
				<span>회원가입</span>
			</div>
			<div class="email_wrap">
				<div class="email_name">이메일</div>
				<div class="email_input_box">
					 <input type="text" id="emailId" value="" placeholder="이메일 입력"> 
					 <span>@</span>
					 <input id="textEmail" placeholder="이메일을 선택하세요."> 
				<div class="email_check">
					<select id="select">
			            <option value="" disabled selected>E-Mail 선택</option>
			            <option value="naver.com" id="naver.com">naver.com</option>
			            <option value="hanmail.net" id="hanmail.net">hanmail.net</option>
			            <option value="gmail.com" id="gmail.com">gmail.com</option>
			            <option value="nate.com" id="nate.com">nate.com</option>
			            <option value="directly" id="textEmail">직접 입력하기</option>
		        </select>
				</div>
				</div>
			</div>
			<div class="mail_code_wrap">
				<div class="mail_code_input_box">
					<input class="mail_code_input">
				</div>
				<div class="mail_code_button">
					<span>인증번호 전송</span>
				</div>
				<div class="clearfix"></div>
			</div>
			<div class="pw_wrap">
				<div class="pw_name">비밀번호</div>
				<div class="pw_input_box">
					<input class="pw_input" id="pw">
				</div>
			</div>
			<div class="pwck_wrap">
				<div class="pwck_name">비밀번호 확인</div>
				<div class="pwck_input_box">
					<input class="pwck_input" id="pwck">
				</div>
			</div>
			<div class="user_wrap">
				<div class="user_name">이름</div>
				<div class="user_input_box">
					<input class="user_input" id="userName">
				</div>
			</div>
			<div class="nick_wrap">
				<div class="nick_name">닉네임</div>
				<div class="nick_input_box">
					<input class="nick_input" id="nickName">
				</div>
			</div>
			<div class="tel_wrap">
				<div class="tel_name">전화번호</div>
				<div class="tel_input_box">
					<input class="tel_input" id="tel">
				</div>
			<div class="error_result">
				<span id="email_result"></span>
				<span id="pw_result"></span>
				<span id="pwck_result"></span>
				<span id="name_result"></span>
				<span id="nickName_result"></span>
				<span id="tel_result"></span>
			</div>	
			</div>
			<div class="join_btn_wrap">
				<input type="button" class="join_btn" id="join_btn" value="가입하기">
			</div>
		</div>
	</div>

	<jsp:include page="../component/footer.jsp"></jsp:include>
</body>
</html>