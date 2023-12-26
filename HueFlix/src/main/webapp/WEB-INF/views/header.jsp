<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!-- CSS -->
<link href="${pageContext.request.contextPath}/resources/css/header.css" rel="stylesheet">
<!-- 아이콘 CDN 라이브러리 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<header>
	<!-- 상단 -->
	<div class="inner">
		<!-- 로고 클릭 시 메인 화면 복귀 -->
		<div class="logo">
			<h1><a href="/ex/">H U E F L I X</a></h1>
		</div>
		<!-- 우측 상단 메뉴 -->
		<div class="search">
			<!-- 검색창 -->
			<form id="searchForm" action="/ex/searchpage" method="GET">
			    <input id="searchTerm" name="searchTerm" type="text" placeholder="영화, 인물 검색">
			    <!-- 돋보기 아이콘 -->
			    <button id="searchButton" type="submit">
    				<i class="fas fa-search"></i>
				</button>
		    </form>
			<!-- c태그 내 주석 작성 금지 -->
			<div class="headerToggle">
				<c:choose>
		    		<c:when test="${loggedIn}">
		    		
		    			<label for="toggle">
		    				<span id="toggleNick">MY&nbsp;&nbsp;</span><i class="fa-solid fa-caret-down"></i>
		    			</label>
		    			
		    			<input type="checkbox" id="toggle">
		    			
		    			<div class="myMenu">
		    				<c:choose>
		            			<c:when test="${userRole.contains('ADMIN')}">
		            				<c:if test="${empty profile_img}">
		            					<div class="pImg"><img src = "${pageContext.request.contextPath}/resources/img/profile_default.png"></div>
		            				</c:if>
		            				<c:if test="${not empty profile_img}">
		            					<div class="pImg"><img src = "${profile_img}"></div>
		            				</c:if>
		            				<div class="myMenuProfile">
		            					<span id="nickname">${nickname}</span><br>
		            					<span id="email">${userEmail}</span>
		            				</div>
		            				<div class="myMenuLink">
				            			<a href="${pageContext.request.contextPath}/ex/logout">로그아웃</a>
		            				</div>
		            			</c:when>
		            				
		            			<c:when test="${userRole.contains('MEMBER')}">
		            				<c:if test="${empty profile_img}">
		            					<div class="pImg"><img src = "${pageContext.request.contextPath}/resources/img/profile_default.png"></div>
		            				</c:if>
		            				<c:if test="${not empty profile_img}">
		            					<div class="pImg"><img src = "${profile_img}"></div>
		            				</c:if>
		            				<div class="myMenuProfile">
		            					<span id="nickname">${nickname}</span><br>
		            					<span id="email">${userEmail}</span>
		            				</div>
		            				<div class="myMenuLink">
				            			<a href="${pageContext.request.contextPath}/member">정보 수정</a>
				            			<a href="${pageContext.request.contextPath}/ex/logout">로그아웃</a>
		            				</div>
			            		</c:when>
		            		</c:choose>	
		    			</div>	
		    				
		    		</c:when>
		    		
		        	<c:otherwise>
		            	<a id="loginLink" href="login">로그인</a>
		            </c:otherwise>
		        </c:choose>  
		        <!-- end c:choose --> 
		        
		     <!-- headerToggle div -->
			</div> 		
		<!-- search div -->	
		</div>
	<!-- inner div -->
	</div>
	<!-- 메인메뉴 -->
	<div class="lower">
		<ul id="gnb">
        	<li><a href="/ex/">홈</a></li>
            <li><a href="/ex/board/nowPlaying">현재상영중</a></li>
            <li><a href="/ex/board/upComming">개봉예정</a></li>
            <li><a href="/ex/board/notice">공지사항</a></li>
		</ul>
	</div>
</header>
<script>
//메뉴바 활성화 스크립트
document.addEventListener("DOMContentLoaded", function () {
    // 현재 페이지의 경로를 가져오기
    var currentPath = window.location.pathname;

    // 메뉴에 해당하는 링크 요소를 찾아 "active" 클래스를 추가
    var buttons = document.querySelectorAll("#gnb li a");

    buttons.forEach(function (button) {
        // 현재 경로와 버튼의 href 속성을 비교하여 일치하면 "active" 클래스 추가
        if (button.getAttribute("href") === currentPath) {
            button.classList.add("active");
        }
    });
});
</script>