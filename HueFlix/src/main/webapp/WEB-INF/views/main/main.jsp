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
<link href="resources/css/standard.css" rel="stylesheet">

<!-- API -->


<!-- JS -->

</head>
<body>
<!-- Header -->
<%@include file="../header.jsp"%>

<!-- top 10 상영작 -->
<div class="topTen">
	<%@include file="topTen.jsp"%>
</div>

<!-- 개봉 예정작 -->
<h1 class="section">개봉 예정 신작들</h1>
<div class="newest">
	<%@include file="newest.jsp"%>
</div>

<!-- 인기순 -->
<h1 class="section">인기작</h1>
<div class="popularity">
	<%@include file="popularity.jsp"%>
</div>
<!-- 평점순 -->
<h1 class="section">평점순</h1>
<div class="ratings">
	<%@include file="ratings.jsp"%>
</div>

<!-- Footer -->
<%@include file="../footer.jsp"%>
</body>
</html>