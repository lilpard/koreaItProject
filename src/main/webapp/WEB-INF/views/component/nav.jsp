<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		fnChangePage();
	})
	
	function fnChangePage(){
		$('body').on('click', '.navPage', function(){
			location.href=$(this).data('url');
		});
	}
</script>
</head>
<body>
	<nav class="navbar navbar-inverse">
	  <div class="container-fluid">
	    <!-- Brand and toggle get grouped for better mobile display -->
	    <div class="navbar-header">
	      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
	        <span class="sr-only">Toggle navigation</span>
	        <span class="icon-bar"></span>
	        <span class="icon-bar"></span>
	        <span class="icon-bar"></span>
	      </button>
	      <a id="navPage" data-url="/" class="navbar-brand navPage" href="#">CLONE GALLERY</a>
	    </div>
	
	    <!-- Collect the nav links, other content for toggling -->
	    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
	      <ul class="nav navbar-nav">
	        <li><a class="navPage" data-url="/" href="#">HOME<span class="sr-only"></span></a></li>
	        <li><a class="navPage" data-url="/art/artPage" href="#">작품보기</a></li>
	        <c:if test="${loginUser.email == 'admin'}">
		        <li><a class="navPage" data-url="/member/list" href="#">회원관리</a></li>
	        </c:if>
	      </ul>
	      <c:if test="${loginUser != null}">
		      <ul class="nav navbar-nav navbar-right">
		        <li><a class="navPage" href="#" data-url="/cart">장바구니</a></li>
		        <li><a class="navPage" href="#" data-url="/rental/orderList">주문목록</a></li>
		        <li><a class="navPage" href="#" data-url="/member/myPage">마이페이지</a></li>
		        <li><a class="navPage" href="#" data-url="/member/logout" id="logout_btn">로그아웃</a></li>
		      </ul>
	      </c:if>
	      <c:if test="${loginUser == null}">
		      <ul class="nav navbar-nav navbar-right">
		        <li><a class="navPage" href="#" data-url="/member/loginPage">로그인</a></li>
		        <li><a class="navPage" href="#" data-url="/member/joinPage">회원가입</a></li>
		      </ul>
	      </c:if>
	    </div><!-- /.navbar-collapse -->
	  </div><!-- /.container-fluid -->
	</nav>
</body>
</html>