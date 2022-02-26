<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <link rel="stylesheet" href="//code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
  <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
  <script src="https://code.jquery.com/ui/1.13.1/jquery-ui.js"></script>
  <link rel="stylesheet" href="/css/rental/rental.css">
<script>
	$(document).ready(function(){
		fnArtInfo();
		fnAddRental();
		fnSamePerson();
	});
	
	// map으로 만들기 전에 XXS작업을 하기 위한 코드
	function fnXXS(str){
		str1 = str + '';
		console.log(str1)
		// javacript 문자열 제거
		if(str1.indexOf('javascript') > -1){
			str1 = str.replaceAll('javascript', '');
		}
		// script 문자열 제거
		if(str1.indexOf('script') > -1){
			str1 = str1.replaceAll('script', '');
		}
		
		// html 태그 제거
		if(str1.indexOf('<') > -1 || str1.indexOf('>') > -1){
			str1 = str1.replaceAll('<', '&lt;');
			str1 = str1.replaceAll('>', '&gt;');
		}
		console.log('변경?' + str1);
		return str1;
	}// XXS
	
	// 작품 정보
	function fnArtInfo(){
		// 장바구니에서 넘기는 경우 배열로 받는 것이 필요함.
		let artNo = [];
		artNo.push( ${ artNo } );
		$.ajax({
			url: '/rental/' + artNo,
			type: 'get',
			dataType: 'json',
			success: function(map){
				if(map.list == null){
					alert('작품을 볼러오지 못했습니다.');
				} else{
					fnPrintArtInfo(map);		
				}
			}
		});
	}// fnArtInfo
	
	function fnPrintArtInfo(map){		
				$.each(map.list, function(i, artwork){
					$('<div class="artwork_list">')
					.append($('<span>').html('<img class="img" src="'+ artwork.path +'">'))
					.append($('<ul>').html('<li class="artName"><h4>'+ artwork.artName +'</h4></li><li class="artNo" data-aNo="'+ artwork.artNo +'">' + artwork.artNo + '</li><li>' + artwork.price + '원</li>'))
					.appendTo($('#artworkInfo'));					
				});
				$('#header_totalCount').text('/ '+ map.totalCount +' 점');
				$('#totalCount').text('작품 수: ' + map.totalCount + '점');
				$('#totalPrice').text('총 렌탈가격: ' + map.totalPrice );
				$('#Rental').html('<input type="button" class="rentalBtn" id="addRental" value="렌탈">');
		} // fnPrintArtInfo
		
	function fnSamePerson(){
		$('#samePerson').click(function(){
			if($(this).is(':checked') == true){
				$('#recieverName').val('${loginUser.userName}');
				let userTel = '${loginUser.tel}';
				let recieverTel = userTel.split('-');
				$('#recieverTel1').val(recieverTel[0]);
				$('#recieverTel2').val(recieverTel[1]);
				$('#recieverTel3').val(recieverTel[2]);
			}else{
				$('#recieverName').val('');
				$('#recieverTel1').val('');
				$('#recieverTel2').val('');
				$('#recieverTel3').val('');
			}
		});
	}
			
	// 정규식	
	function fnReg(){
		let regResult = 0;
		let regName = /^[가-힣]{2,}$/;
		let regTel = /^[0-9]{3,4}$/;
		
		if(regName.test($('#recieverName').val())){
			regResult += 1;
		}
		if($('#address').val() != '' && $('#detailAddress').val() != ''){
			regResult += 2;
		}
		if(regTel.test($('#recieverTel1').val()) == true &&
						  regTel.test($('#recieverTel2').val()) == true &&
						  regTel.test($('#recieverTel3').val())== true){
			regResult += 4;
		}
		if($('#to').val() != ''){
			regResult += 8;
		}
		return regResult;
	}
	
	// 렌탈하기
	function fnAddRental(){
		$('body').on('blur', 'input' , function(){
			let regResult = fnReg();
			console.log(regResult);
		});
		$('body').on('click', '#addRental' , function(){
				if(fnReg() == 0 ||fnReg() == 2 || fnReg() == 4 || fnReg() == 6 || fnReg() == 8 || fnReg() == 10 || fnReg() == 12 || fnReg() == 14){
					alert('이름 형식을 맞추어 주세요.');
					return false;
				} else if(fnReg() == 1 || fnReg() == 5 || fnReg() == 9 || fnReg() == 13){
					alert('주소창를 확인해 주세요.');
					return false;
				} else if(fnReg() == 3 || fnReg() == 11){
					alert('전화번호를 확인해주세요.');
					return false;
				} else if(fnReg() == 7){
					alert('반납 일정을 입력해주세요.(최소 1달 이후)');
					return false;
				} else if(fnReg() == 15){
						var rentalData = [];			
						$('body .artNo').each(function(i, obj) {
							let aNo = $($('.artNo')[i]).data('ano');
							let xxsRName = $('#recieverName').val();
							let recieverName = fnXXS(xxsRName);
							let xxsTel = $('#recieverTel1').val() + '-' + $('#recieverTel2').val() + '-' + $('#recieverTel3').val();
							let recieverTel = fnXXS(xxsTel);
							let xxsAddress = $('#address').val() + ' ' + $('#detailAddress').val();
							let address = fnXXS(xxsAddress);
							let xxsRequirement = $('#requirement').val();
							let requirements = fnXXS(xxsRequirement);
							
							rental = {
								userNo : '${loginUser.userNo}',
								artNo : aNo,
								recieverName : recieverName,
								recieverTel : recieverTel,
								address : address,
								startDate : $('#from').val(),
								endDate : $('#to').val(),
								requirements : requirements
							};
							rentalData.push(rental);		
						});
						rentalData = JSON.stringify({
							rentalData : rentalData
						})
						$.ajax({
							url: '/rental',
							type: 'post',
							data: rentalData,	
							contentType : 'application/json',
							dataType : 'json',
							success : function(map){	
							if(map.status == 200){
								alert(map.message);		
							} else if(map.status = 402){
								let artMap = []
								$.each(map.list, function(i, art){
									artMap.push(art.artwork.artName);
								});
								alert(artMap + "은 이미 렌탈 중인 작품입니다.")
							}
							location.href = '/rental/orderList'
							// 결제 완료 후, 홈화면으로 전환하는 location 추가
						}
					});	 					
				} else{
					alert('입력창을 확인 해주세요');
				}
		});
	}
	
	// DAUM 주소 찾기 API 
    function execDaumFindAddress() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById("address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("detailAddress").focus();
            }
        }).open();
    }
	
    var $j = jQuery.noConflict();
    $( function() {
	    $j( "#to" ).datepicker({ minDate: "+1M", maxDate: "+1Y" });
	    let today = new Date();
	    let year = today.getFullYear();
	    let month = today.getMonth() + 1;
	    let todate = today.getDate();
	    
	    // 날짜 두자리 수 만들기
	    if (month < 10) { month = "0" + month; } 
	    if (todate < 10) { todate = "0" + todate; }
    	console.log(todate)
	    $('#from').val(month + '/' + todate + "/" + year)
        var dateFormat = "mm/dd/yy",

          to = $j( "#to" ).datepicker({
            defaultDate: "+1M",
            changeMonth: true,
            numberOfMonths: 2
          })
  
        function getDate( element ) {
          var date;
          try {
            date = $.datepicker.parseDate( dateFormat, element.value );
          } catch( error ) {
            date = null;
          }
          return date;
        }
    } );
</script>
<style>
	label {
		display: inline-block;
		width: 100px;
	}
	.artwork_list{
		display: flex;
	}
</style>
</head>
<body>
	<jsp:include page="../component/nav.jsp"></jsp:include>
	
	<div class="container">
		<div class="wrap">
			<div>
				<h3 class="info">주문자 정보</h3>
				<label>주문자명</label> ${loginUser.userName} <br>
				<label for="tel">전화번호</label><input type="text" id="tel" placeholder="${loginUser.tel}"><br>
				<label>이메일</label> ${loginUser.email}  <br>				
			</div>
			<hr>
			<div class="samePersonCheck">
				<input type="checkbox" id="samePerson"/><label class="samePersonLabel" for="samePerson">주문자 정보 동일</label>
			</div>
			
			<div>
				<h3 class="info">수취인 정보</h3>
				<label>수취인명</label><input type="text" id="recieverName" placeholder="수취인명"><br>
				<label for="address">주소</label><input type="text" id="address" placeholder="주소">
				<input type="button" class="findAdderss" onclick="execDaumFindAddress()" value="주소 찾기"><br>
				<label for="detailAdrress">상세주소</label><input class="address" type="text" id="detailAddress" placeholder="상세주소">
				<input type="text" id="extraAddress" placeholder="참고항목"><br>
				<label>핸드폰</label><input class="tel" type="text" id="recieverTel1" maxlength="3"> - <input class="tel" type="text" id="recieverTel2" maxlength="4"> - <input class="tel" type="text" id="recieverTel3" maxlength="4"><br>
				<label class="message">메시지</label><textarea rows="3" cols="45" id="requirement"></textarea><br>
				<hr>
			</div>
			
			
			
			<label for="from" class="date">작품 렌탈일</label>
			<input type="text" class="inputdate" id="from" name="from" readonly="readonly">
			<label for="to" class="date">작품 반납일</label>
			<input type="text" class="inputdate" id="to" name="to" readonly="readonly">
			<br><br>
			<div id="Rental"></div>			
		</div>
			<div class="artinfo_wrap">
				<header class="infoHeader">
					<h3 class="info">주문 작품 정보 <span id="header_totalCount"></span></h3>
				</header>
				<section id="artwork_wrap">
					<div id="artworkInfo"></div>
					<div class="artwork_footer">
						<div id="totalCount"></div>
						<div id="totalPrice"></div>
					</div>
					<br><br>
				</section>
			</div>
	</div>
	
	<jsp:include page="../component/footer.jsp"></jsp:include>
</body>
</html>