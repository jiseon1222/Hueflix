<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HUEFLIX</title>
<!-- Favicon -->
<link rel="icon" href="${pageContext.request.contextPath}/resources/img/favicon.png">
<!-- CSS -->
<link href="${pageContext.request.contextPath}/resources/css/edit.css" rel="stylesheet">
<!-- 아이콘 CDN 라이브러리 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<!-- JS -->
<script src="${pageContext.request.contextPath}/resources/js/userEdit.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
<!-- Header -->
<%@include file="../header.jsp"%>

	<div class="user-info-container">
		<h2>내 정보 수정</h2>
		<hr>
		<form action="/ex/member/editMyInfo" method="post">
		<input type="hidden" name="userEmail" value="${userEmail}"/>
			<table>
				<tr>
					<th><h4>아이디</h4></th>
					<td><span id="mail">${userEmail}</span></td>
				</tr>
				<tr>
					<th><h4>가입일</h4></th>
					<td>${regdate}</td>
				</tr>
				<tr>
					<th><h4>닉네임</h4></th>
					<td>
						<input type="text" id="nickname" name="nickname" value="${nickname}">
					</td>
				</tr>
				
				<tr>
					<th><h4>패스워드 변경</h4></th>
					<td>
					<input type="password" id="changePw" name="pw" 
							   placeholder="변경할 비밀번호" onkeyup="checkPasswordMatch();"/></td>
				</tr>
				<tr>
					<th><h4>패스워드 확인</h4></th>
					<td><input type="password" id="confirmChangePw" 
							   placeholder="비밀번호 확인" onkeyup="checkPasswordMatch();"/>
					</td>	      		 
				</tr>
				<tr>
					<th></th>
					<td><span id="changePwError"></span></td>
				</tr>
				
			</table>
			<div class="button-container">
				<button type="submit" id="submit">수정</button>
			</div>
		</form>	
	</div>
<!-- Footer -->
<%@include file="../footer.jsp"%>
</body>
</html>