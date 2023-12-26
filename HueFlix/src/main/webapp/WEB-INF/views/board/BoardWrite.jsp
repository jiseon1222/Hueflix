<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="false" %>
<%@include file="../header.jsp"%>
<link rel="stylesheet" type="text/css" href="/ex/resources/css/boardRead.css">
<div class="main">
<form role="form" method="post">
	<div class="box-header">
		<h1 class="box-title">게시글 작성</h1>
	</div>
			<div class="form-group">
				<label for="bGroupKind">카테고리</label> 
				<input type="text" class="form-control" id="bGroupKind" name="bGroupKind" value="공지사항">
			</div>
			<div class="form-group">
				<label for="bTitle">제목</label> 
				<input type="text"  id="bTitle" class="form-control"  name="bTitle"  style="width:100%" placeholder="제목을 입력해주세요">
			</div>
			<div class="form-label">
				<label for="bContent">내용</label> 
				<textarea class="form-control"  id="bContent" name="bContent" rows="6" placeholder="내용을 입력해주세요"></textarea>
			</div>
			<div class="form-group">
				<input type="hidden" name="userName" value="${nickname}">
				<label for="userName">작성자</label>
				<input type="text" class="form-control" id="userName" placeholder="${nickname}" readonly>
				</div>
			<button type="submit" class="btn btn-primary">글쓰기</button>
			</form>
	</div>
	

<%@include file="../footer.jsp"%>