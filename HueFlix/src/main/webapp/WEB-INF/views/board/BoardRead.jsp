<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="false"%>
<link rel="stylesheet" type="text/css" href="/ex/resources/css/boardRead.css">
<%@include file="../header.jsp"%>

<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="/ex/resources/css/boardRead.css">
<script>
	$(document).ready(function() {
		var formObj = $("form[role = 'form']");
		console.log(formObj);

		$(".btn-warning").on("click", function() {
			formObj.attr("action", "/ex/board/BoardMod");
			formObj.attr("method", "get");
			formObj.submit();
		});

		$(".btn-danger").on("click", function() {
			formObj.attr("action", "/ex/board/remove");
			formObj.submit();
		});

		$(".btn-primary").on("click", function() {
			self.location = "/ex/board/notice";
		});
	})
</script>
<div class="main">
	<div class="table">
		<h1>공지사항</h1>
		<form role="form" method="post">
			<input type="hidden" name="bid" value="${boardDto.bid }"> <input
				type="hidden" name="page" value="${pageMaker.page }"> <input
				type="hidden" name="perPageNum" value="${pageMaker.perPageNum }">
			<input type="hidden" name="searchType"
				value="${pageMaker.searchType }"> <input type="hidden"
				name="keyword" value="${pageMaker.keyword }">
		</form>

		<div class="form-group">
			<label for="bGroupKind">카테고리</label> <input type="text"
				class="form-control" id='bGroupKind' name='bGroupKind' value="${boardDto.bGroupKind }" readonly>
		</div>
		<div class="form-group">
			<label for="bTitle">제목</label> <input type="text" id='bTitle'
				class="form-control" name='bTitle' style="width: 100%"
				value = "${boardDto.bTitle }" readonly>
		</div>
		<div class="form-group">
			<label for="bContent">내용</label>
			<textarea class="form-control" id="bContent" name="bContent" rows="6" 
			readonly>${boardDto.bContent }</textarea>
		</div>
		<div class="form-group">
			<label for="userName">작성자</label> <input type="text"
				class="form-control" id='userName' name='userName'
				value="${boardDto.userName }" readonly>
		</div>
		<div class="box-footer">
		<c:choose>
			<c:when test="${userRole.contains('ADMIN')}">
				<button type="submit" class="btn btn-warning">수정</button>
				<button type="submit" class="btn btn-danger">삭제</button>
				<button type="submit" class="btn btn-primary">목록보기</button>
			</c:when>

			<c:otherwise>
				<button type="submit" class="btn btn-primary">목록보기</button>
			</c:otherwise>
		</c:choose>
		</div>
	</div>
</div>
<%@include file="../footer.jsp"%>