<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <title>로그인</title>
    <link rel="stylesheet" href="/resources/css/style.css" />
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
      <h2>로그인</h2>
      <form action="/member/login" method="post">
        <label for="email">이메일</label>
        <input type="email" id="email" name="email" required />

        <label for="password">비밀번호</label>
        <input type="password" id="password" name="password" required />

        <button type="submit" class="btn-login">로그인</button>
		<c:if test="${not empty message}">
			<p>${message}<p><br>
		</c:if>
		
      </form>

      <div class="form-footer">
        계정이 없으신가요? <a href="/member/join">회원가입</a>
      </div>
    </div>
  </body>
</html>
