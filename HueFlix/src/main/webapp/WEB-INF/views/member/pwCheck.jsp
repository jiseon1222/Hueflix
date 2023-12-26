<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HUEFLIX</title>
<!-- Favicon -->
<link rel="icon" href="resources/img/favicon.png">
<!-- CSS -->
<link href="resources/css/checkPw.css" rel="stylesheet">
</head>
<body>
	<!-- Header -->
	<%@include file="../header.jsp"%>
	
	<div class="checkPw">
		<h2 id="title">계정 비밀번호를 입력해주세요.</h2>
		<span id="yourPwPlease">회원님의 안전한 개인정보 보호를 위해<br>비밀번호를 다시 한번 확인합니다.</span>
		
		<form action="${pageContext.request.contextPath}/member/checkPassword" method="POST">
			<div class=pwForm>
				<input type="hidden" name="userEmail" value="${userEmail}"/>
				<input type="password" id="checkPw" name="pw" placeholder="비밀번호"/>
				<button id="pwSubmit" type="submit">확인</button><br>
				<c:if test="${not empty error}">
        			<span class="errorPw">${error}</span>
   	 			</c:if>		
			</div>
		</form>
	</div>
	
	<!-- Footer -->
	<%@include file="../footer.jsp"%>
</body>
</html>