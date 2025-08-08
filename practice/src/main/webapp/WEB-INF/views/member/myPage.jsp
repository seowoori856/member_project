<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <title>로그인</title>
    <link rel="stylesheet" href="/resources/css/style.css" />
	<!-- ✅ jQuery CDN -->
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <%-- 공통 스타일 --%>
    <style>
      /* 로그인 화면 전용 스타일 */
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

      input[type="email"],
      input[type="password"] {
        width: 100%;
        padding: 8px;
        margin-top: 5px;
        box-sizing: border-box;
      }

      .btn-login {
        margin-top: 20px;
        width: 100%;
        padding: 10px;
        background-color: #007bff;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-size: 16px;
      }

      .btn-login:hover {
        background-color: #0056b3;
      }

      .form-footer {
        text-align: center;
        margin-top: 15px;
      }

      .form-footer a {
        color: #007bff;
        text-decoration: none;
      }

      .form-footer a:hover {
        text-decoration: underline;
      }
    </style>
  </head>
  <body>
    <div class="container">
      <h2>내 정보</h2>
	  <p id="email1" data-email2="${loginMember.email}">이메일 : ${loginMember.email}</p>
	  <p>이름 : ${loginMember.name}</p>
	  <p>비밀번호 : ${loginMember.password}</p>
	  <p>생년월일 : ${loginMember.birth}</p>
	  <div class="form-footer">
  		<a href="/member/logout">로그아웃</a><br>
		<a href="/member/edit">수정하기</a><br>
		<a href="/member/delete">회원정보삭제</a><br>
		
		<button id="deleteBtn" type="button" class="btn-login">회원정보삭제</button>
      </div>
    </div>
	<script>
	$(document).ready(function() {
	    function deleteFunc() {
	       let emailValue = $("#email1").data("email2");
		   
		   //데이터 형식 생성 
		   let dataForm = { email3:emailValue};
		   
		   //비동기 요청 방식 ajax
		   $.ajax({
			url:"/member/delete", //<-- 요청하는 주소
			method:"post", 		  //<--요청하는 방법
			data: dataForm,		  //<-- 보내는 데이터 형식 
			success:function(response){
				alert("통신성공");
			}, // <-- 통신이 성공했을때
			error:function(){
				alert("통신실패ㄴㄴㄴ");
			},			  // <-- 통신이 실패했을
		   });
		   
		   
		   
		   
		   
		   
		   
		   
		   //console.log(emailValue);
		   //서버 통신 방법은 달라도 보내는 데이터 형식은 같다
<!--		   let dataForm = { email:emailValue};-->
		   
<!--		   $.ajax({-->
<!--			url:"/member/delete",-->
<!--			method:"POST",-->
<!--			data: dataForm,-->
<!--			success:function(response){-->
<!--				console.log(response);-->
<!--				if(response === "success"){-->
<!--					alert("회원 정보가 삭제 되었습니다.");-->
<!--					location.href = "/member/login";// <a태그>-->
<!--				}-->
<!--			},-->
<!--			error:function(){-->
<!--				alert("서버 통신 실패");-->
<!--			}-->
<!--		   });-->
		   
	    }

	    $("#deleteBtn").click(deleteFunc);
	});
	</script>

  </body>
</html>
