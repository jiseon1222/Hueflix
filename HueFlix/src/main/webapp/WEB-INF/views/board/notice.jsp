<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="false" %>
    <link rel="stylesheet" type="text/css" href="/ex/resources/css/notice.css">
<%@include file="../header.jsp"%>

<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

<script>
var result = '${msg}';
if(result == 'success') {
	alert("처리가 완료되었습니다.");
}
$(document).ready(function(){
	$(".btn").on("click", function() {
		location.href = "/ex/board/BoardWrite"
	})
	
	$('#searchBtn').on("click", function(event){
		  alert("notice"+'${pageMaker.makePage(1)}'
				  +'&searchType='+$("select option:selected").val()
				  +"&keyword="+$('#keywordInput').val());
		  
		  window.location.href="notice"+'${pageMaker.makePage(1)}'
		  +'&searchType='+$("select option:selected").val()
		  +"&keyword="+$('#keywordInput').val();
		  
	  })
	  
});
</script>
<body style="background-color: black;">
<header>

</header>

<div class="main">

<div class="table">

<div style="text-align:center">
<h2 style="color:white ">공지사항</h2>
	<select name="searchType">
    	<option value="btnc" ${pageMaker.searchType eq 'btnc' ? 'selected' : ''}>-----</option>
    	<option value="bt" ${pageMaker.searchType eq 'bt' ? 'selected' : ''}>제목만</option>
    	<option value="bn" ${pageMaker.searchType eq 'bn' ? 'selected' : ''}>글 작성자</option>
    	<option value="bc" ${pageMaker.searchType eq 'bc' ? 'selected' : ''}>내용</option>
	</select>
	<input type="text" name="keyword" id="keywordInput" value="${pageMaker.keyword }">
	<button id="searchBtn">검색하기</button>
</div>


<div class="horizontal-line"></div>
<table class="table table-hover table-sm" style="width:100%">
	<tr class="bg-dark text-white">
		<th style="padding-left: 5px">글 번호</th>
		<th>카테고리</th>
		<th>제목</th>
		<th>작성자</th>
		<th>작성일</th>
		<th>조회수</th>
	</tr>
	<c:forEach items="${list }" var="boardDto">
	<tr class="bg-light text-dark">
		<td>${boardDto.bid }</td>
		<td>${boardDto.bGroupKind}</td>
		<td> <a href="/ex/board/BoardRead${pageMaker.makeSearch()}&bid=${boardDto.bid}">${boardDto.bTitle}</a></td>
		<td>${boardDto.userName }</td>
		<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${boardDto.bWriteTime }"/></td>
		<td><span class="badge bg-red">${boardDto.bHit }</span></td>
	</tr>
</c:forEach>
</table>
<c:choose>
	<c:when test="${userRole.contains('ADMIN')}">
		<input type="submit" class="btn bg-secondary text-white" style="width:100px" value="글쓰기">
	</c:when>
</c:choose>


<div class="pagination-container">
<div class="pagination justify-content-center text-center">
  <c:if test="${pageMaker.page != 1}">
    <div class="page-item">
      <a class="page-link" href='notice${pageMaker.makeSearch(1)}'>&laquo;</a>
    </div>
  </c:if>

  <c:if test="${pageMaker.prev}">
    <div class="page-item">
      <a class="page-link" href='notice${pageMaker.makeSearch(pageMaker.startPage-1)}'>&lt;</a>
    </div>
  </c:if>

  <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
    <div class="page-item${pageMaker.page == idx ? ' active' : ''}">
      <a class="page-link" href='notice${pageMaker.makeSearch(idx)}'>${idx}</a>
    </div>
  </c:forEach>

  <c:if test="${pageMaker.next}">
    <div class="page-item">
      <a class="page-link" href='notice${pageMaker.makeSearch(pageMaker.endPage+1)}'>&gt;</a>
    </div>
  </c:if>

  <c:if test="${pageMaker.page != pageMaker.totalEndPage}">
    <div class="page-item">
      <a class="page-link" href='notice${pageMaker.makeSearch(pageMaker.totalEndPage)}'>&raquo;</a>
    </div>
  </c:if>
</div>
</div>

</div>
</div>
<%@include file="../footer.jsp"%>
</body>