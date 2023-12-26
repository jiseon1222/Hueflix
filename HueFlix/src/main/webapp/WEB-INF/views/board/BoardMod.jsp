<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="false" %>
<%@include file="../header.jsp"%>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <link rel="stylesheet" type="text/css" href="/ex/resources/css/boardRead.css">
<script>
$(document).ready(function() {
   var formObj = $("form[role='form']");
   console.log(formObj);
   
   $(".btn-primary").on("click", function() {
      formObj.submit();
   });
   $(".btn-warning").on("click", function() {
      formObj.attr("action", "/ex/board/notice");
      formObj.attr("method", "get");
      formObj.submit();
   });
});
</script>
<div class="main">
<form role="form" method="post">
   <div class="box-header">
      <h1 class="box-title">게시글 수정</h1>
   </div>
         <div class="form-group">
            <label for="bGroupKind">카테고리</label> <input type="text" class="form-control" id='bGroupKind' name='bGroupKind' value="공지사항" readonly>
         </div>
         <div class="form-group">
            <label for="bTitle">제목</label> <input type="text"  id='bTitle' class="form-control"  name='bTitle'  style="width:100%" value="${boardDto.bTitle }">
         </div>
         <div class="form-label">
            <label for="bContent">내용</label> <textarea class="form-control"  id="bContent" name="bContent" rows="6">${boardDto.bContent }</textarea>
         </div>
         <div class="form-group">
            <label for="userName">작성자</label> <input type="text" class="form-control" id='userName' name='userName' value="${boardDto.userName }" readonly>
         </div>
         <button type="submit" class="btn btn-primary">수정</button>
         <button type="submit" class="btn btn-warning">취소</button>
      </form>
   </div>
<%@include file="../footer.jsp"%>