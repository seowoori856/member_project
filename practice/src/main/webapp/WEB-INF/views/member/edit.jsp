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
            <label for="name" class="form-label">이름</label>
            <input type="text" class="form-control" id="name" name="name" value="${member.name}">
        </div>
		
        <!-- 권한 (숨김 처리) -->
        <input type="hidden" name="userType" value="${member.userType}">

        <!-- 전송 버튼 -->
        <div class="d-flex justify-content-between">
            <button type="submit" class="btn btn-primary">수정 완료</button>
            <a href="/member/myPage" class="btn btn-secondary">취소</a>
        </div>
    </form>

</body>
</html>
