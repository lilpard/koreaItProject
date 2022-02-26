<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/member/findIdPage.css">
<script src="https://code.jquery.com/jquery-3.4.1.js"integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="crossorigin="anonymous"></script>
<script type="text/javascript">
	$(document).ready(function(){
		fnFindId();
	});
	function fnFindId(){
		$('#search_btn').click(function(){
			$('#search_result').text('');
			let tel = $('#tel').val()
			$.ajax({
				url: '/member/findId/tel/' + tel,
				type: 'get',
				dataType: 'json',
				success: function(map) {
					console.log(map);
					if(map.status == 500){
						$('#search_result').text(map.message);
					}else if(map.status == 200){						
						$('<ul>')
						.append($('<li>').text('총' + map.emailCnt + '개의 아이디가 조회되었습니다.'))
						.appendTo('#search_result');
						$.each(map.email, function(i, email){			
							$('#search_result')
							.append($('<li>').text('조회된 아이디는 ' + email + ' 입니다.'));
						});
					}
				}
			});
		});
	}
</script>
</head>
<body>
	<jsp:include page="../component/nav.jsp"></jsp:include>

	<div class="wrap">
		
		<h1 class="wrap_header">아이디 찾기 화면</h1>
		가입 당시 전화번호<br>
		<input type="text" name="tel" id="tel">
		<input type="button" value="찾기" id="search_btn"><br><br>
		
		<div>
			<a href="/member/loginPage">로그인하러가기</a>
		</div>
		
		<hr>
		
		<div id="search_result"></div>
	
	</div>
	
	<jsp:include page="../component/footer.jsp"></jsp:include>
</body>
</html>