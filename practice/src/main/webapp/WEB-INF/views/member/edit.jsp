<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>회원정보 수정</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="/js/jquery-3.7.1.min.js"></script>
</head>
<body class="container py-5">

    <h2 class="mb-4">회원정보 수정</h2>

    <!-- 수정 폼 -->
    <form action="/member/edit" method="post" class="card p-4">
        <!-- 아이디는 수정 불가 -->
        <div class="mb-3">
            <label for="email" class="form-label">아이디</label>
            <input type="text" class="form-control" id="email" name="email" value="${member.email}" readonly>
        </div>

        <!-- 비밀번호 -->
        <div class="mb-3">
            <label for="password" class="form-label">비밀번호</label>
            <input type="password" class="form-control" id="password" name="password" placeholder="새 비밀번호 입력">
        </div>

        <!-- 이름 -->
        <div class="mb-3">
            <label for="name" class="form-label">주소</label>
            <input type="text" class="form-control" id="name" name="name" value="${member.name}">
        </div>
		
		<div class="mb-3">
		  <label for="address" class="form-label">주소</label>
		  <input type="text" class="form-control" id="address" name="address" readonl>
		  
		  </br>
		<button type="button" id="AddressPopUp">주소검색</button>
		<div id="map" style="width:300px;height:300px;margin-top:10px;display:none"></div>
		</div>

		<!-- 좌표 저장용 -->
		<input type="hidden" id="lat" name="lat">
		<input type="hidden" id="lng" name="lng">
		
        <!-- 권한 (숨김 처리) -->
        <input type="hidden" name="userType" value="${member.userType}">

        <!-- 전송 버튼 -->
        <div class="d-flex justify-content-between">
            <button type="submit" class="btn btn-primary">수정 완료</button>
            <a href="/member/myPage" class="btn btn-secondary">취소</a>
        </div>
    </form>

	<!-- 카카오맵 API 스크립트 페이지 -->
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0b0a28ac306bcd212e1f400b0ea32cf6&libraries=services"></script>
	<!-- 다음 주소 API 스크립트 페이지 -->
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
		
		// 초기 상태 반영
		$(document).ready(function () {

		// 주소 검색 버튼을 클릭 시 다음 주소 팝업창과 지도를 생성
				$("#AddressPopUp").click(function(){
					new daum.Postcode({
				        oncomplete: function(data) {
							//condole.log(data.address);
				         $("#address").val(data.address)
						 
						 createMap(data.address);

				        }
				    }).open();
					
				});
				
		function createMap(address){
			// 주소를 좌표로 변경하는 객체
			let geocoder = new kakao.maps.services.Geocoder();
			
			// 주소를 좌표 변경 함수
			geocoder.addressSearch(address, function(result, status) {
			     if (status === kakao.maps.services.Status.OK) {
					$("#map").show();
					console.log(result);
			 		 //위도 경도 값 설정
			         $("#lat").val(result[0].y);
			         $("#lng").val(result[0].x);
					 
					 let coords = new kakao.maps.LatLng(result[0].y, result[0].x);
					 
					 let container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
					 let options = { //지도를 생성할 때 필요한 기본 옵션
					 	center: coords, //지도의 중심좌표.
					 	level: 3 //지도의 레벨(확대, 축소 정도)
					 };

					 let map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
					 
					 let marker = new kakao.maps.Marker({
					     map: map,
					     position: coords
					 });
			     }
			 });
			
		} 
		
		});
		
	</script>
	
</body>
</html>
