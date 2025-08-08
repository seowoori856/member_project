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

        <button type="submit" class="submit-btn">가입하기</button>
      </form>
	
    </div>

    <script>
      function preventSubmitEvent(e) {
        e.preventDefault(); // 실제 제출 막기
        alert("회원가입이 되었습니다.");
      }
<!--      $("#joinForm").submit(preventSubmitEvent); // 폼에서 submit 막기-->

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

      // 초기 상태 반영
      $(document).ready(toggleFields);
    </script>
  </body>
</html>
