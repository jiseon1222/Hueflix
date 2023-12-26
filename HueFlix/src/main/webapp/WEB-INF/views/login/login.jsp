<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HUEFLIX Login</title>
<!-- Favicon -->
<link rel="icon" href="resources/img/favicon.png">
<!-- JS -->
<script src="resources/js/login.js"></script>
<!-- CSS -->
<link href="resources/css/login.css" rel="stylesheet">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
	<!-- 로고 -->
	<h1 class="logo"><a href="/ex/">H U E F L I X</a></h1><br><br>
	
	<!-- 전체 영역 -->
	<div class="container" id="container">
		
		<!-- 회원 가입 -->
		<div class="form-container sign-up-container">
		    <form action="register/process" method="post">
		      <h1>회원가입</h1><br>
		      <input type="email" id="joinUserEmail" name="userEmail" placeholder="이메일 주소" 
		      		 onblur="checkEmailAvailability();"/>
		      <span id="idMsg"></span>
		      
		      <input type="text" id="joinUserNick" name="nickname" placeholder="닉네임" 
		      		 onkeyup="checkNicknameAvailability();"/>
		      <span id="nicknameMsg"></span>
		      
		      <input type="password" id="joinPw" name="pw" placeholder="비밀번호" 
		      		 onkeyup="checkPasswordMatch();"/>
		      <span id="pwMsg"></span>
		      <input type="password" id="confirmPw" placeholder="비밀번호 확인" 
		      		 onkeyup="checkPasswordMatch();"/>
		      
		      <br><button type="submit">회원가입</button>
		   
		      <!-- 소셜 계정 가입 -->
		      <div class="social-container">
		      <span class="line-through">또는 소셜 계정으로 가입</span>
		        	<a href="#" class="social">
		        		<img src="resources/img/google.png" alt="구글" class="social-img">
		        	</a>
		        	<a href="#" class="social">
		        		<img src="resources/img/naver.png" alt="네이버" class="social-img">
		        	</a>
		        	<a href="#" class="social">
		        		<img src="resources/img/kakao.png" alt="카카오" class="social-img">
		        	</a>
		      </div>
		    </form>
	 	</div>
	 	
	 	<!-- 로그인 -->
		<div class="form-container sign-in-container">
			<c:url value="/login" var="loginUrl" />
			
			<form action="${loginUrl}" method="POST">
				<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
				
				<h1>로그인</h1><br>
				<input type="text" id="userEmail" name="userEmail" placeholder="ID" /> 
				<input type="password" id="pw" name="pw" placeholder="Password" />
				
				<c:if test="${param.error != null}">
	        		<span class="error">아이디 또는 비밀번호가 잘못되었습니다.</span>
				</c:if>
				<br><button>로그인</button>
					
				<!-- 소셜 계정 로그인 -->
				<div class="social-container">
				<span class="line-through">또는 소셜 계정으로 로그인</span>
					<a href="#" class="social">
						<img src="resources/img/google.png" alt="구글" class="social-img">
					</a>
			       	<a href="#" class="social">
			       		<img src="resources/img/naver.png" alt="네이버" class="social-img">
			       	</a>
			    	<a href="#" class="social">
			    		<img src="resources/img/kakao.png" alt="카카오" class="social-img">
			    	</a>
				</div>
			</form>
		</div>
		<!-- 변형 컨테이너 -->
		<div class="overlay-container">
			<div class="overlay">
				<!-- 회원 가입 창에서 로그인 유도 메시지 -->
				<div class="overlay-panel overlay-left">
			        <h1>계정이 있으신가요?</h1>
			        <p>HUEFLIX에서 더 많은 영화 소식과 리뷰를 확인하고 싶다면 로그인하세요.</p>
			        <button class="ghost" id="signIn">로그인</button>
	      		</div>
				<!-- 로그인 창에서 가입 유도 메시지 -->
				<div class="overlay-panel overlay-right">
					<h1>당신의 영화 이야기를 들려주세요.</h1>
					<p>간편한 가입으로 HUEFLIX에서 다른 영화 팬들과 함께 소통해보세요!</p>
					<button class="ghost" id="signUp">회원가입</button>
				</div>
			</div>
		</div>
	</div>

</body>
</html>