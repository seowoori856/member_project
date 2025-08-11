<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"
language="java" %> <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>회원가입 폼</title>

    <!-- ✅ jQuery CDN -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

    <style>
      /* 기본 레이아웃 스타일 */
      .container {
        width: 500px;
        margin: 50px auto;
        padding: 20px;
        border: 1px solid #ccc;
        border-radius: 10px;
        background-color: #f9f9f9;
        font-family: Arial, sans-serif;
      }

      h2 {
        text-align: center;
      }

      label {
        display: block;
        margin-top: 15px;
      }

      input[type="text"],
      input[type="email"],
      input[type="password"],
      input[type="date"] {
        width: 100%;
        padding: 8px;
        margin-top: 5px;
        box-sizing: border-box;
      }

      .user-fields,
      .business-fields {
        margin-top: 10px;
      }

      .hidden {
        display: none;
      }

      .user-type {
        margin-top: 10px;
        text-align: center;
      }

      .submit-btn {
        width: 100%;
        margin-top: 20px;
        padding: 10px;
        background-color: #007bff;
        color: white;
        border: none;
        font-size: 16px;
        cursor: pointer;
      }

      .submit-btn:hover {
        background-color: #0056b3;
      }
    </style>
  </head>
  <body>
    <div class="container">
      <h2>회원가입</h2>

      <form id="joinForm" method="post" action="/member/insert">
        <!-- 사용자 타입 -->
        <label
          ><input type="radio" name="userType" value="normal" checked /> 일반
          사용자</label
        >
        <label
          ><input type="radio" name="userType" value="business" /> 사업자
          사용자</label
        >

        <!-- 입력 정보 -->
        <label>이름<input type="text" name="name" required /></label>
        <label>이메일<input type="email" name="email" required /></label>
		<c:if test="${not empty message}">
			<p>${message}<p><br>
		</c:if>
		<label>비밀번호<input type="password" name="password" required /></label>


        <!-- 일반 사용자 정보 -->
        <div class="user-fields">
          <label>생년월일<input type="date" name="birth" /></label>
        </div>

        <!-- 사업자 정보 -->
        <div class="business-fields hidden">
          <label>사업자 등록번호<input type="text" name="bizNo" /></label>
          <label>회사명<input type="text" name="companyName" /></label>
        </div>
		
		<!-- 사용자 주소 입력 필드 -->
		<div>
		  <label>주소<input type="text" id="address" name="address" readonl requiredy/></label>
		  </br>
		<button type="button" id="AddressPopUp">주소검색</button>
		<div id="map" style="width:300px;height:300px;margin-top:10px;display:none"></div>
		</div>
		
		<!-- 좌표 저장용 -->
		<input type="hidden" id="lat" name="lat">
		<input type="hidden" id="lng" name="lng">
		
		</br>
		 
        <button type="submit" class="submit-btn">가입하기</button>
      </form>
	
    </div>
	
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
		
		
		// 지도를 생성하는 함수
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
		
		
		<!-- ////////////////////////////////////////////////////////////// -->
		function toggleFields() {
		  let checkedValue = $("input[name='userType']:checked").val();
		  if (checkedValue === "normal") {
		    $(".user-fields").show();
		    $(".business-fields").hide();
		  } else if (checkedValue === "business") {
		    $(".business-fields").show();
		    $(".user-fields").hide();
		  }
		}

		$("input[name='userType']").change(toggleFields);
		
	   });
    </script>
  </body>
</html>
