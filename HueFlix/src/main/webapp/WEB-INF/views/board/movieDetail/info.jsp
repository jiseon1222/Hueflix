<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="false"%>
<%@include file="../../include/subHeader.jsp"%>
	<body>
    <script>
        $(document).ready(function() {
            // URL에서 쿼리 매개변수 추출
            const urlParams = new URLSearchParams(window.location.search);
            const movieId = urlParams.get('movieId');

            $.ajax({
                url: "https://api.themoviedb.org/3/movie/" + movieId + "?language=ko-kr&api_key=d266bc87db778e91facf58b4bcde4f31",
                method: "GET",
                dataType: "json",
                success: function(data) {
                    // 영화 개요를 메뉴에 추가
                	$('#menuShow').empty();
        			$('#menuShow').html('<div class="tagline">'+data.tagline + '</div><div class="overview">' + data.overview + '</div>');
                },
                error: function() {
                    console.log('API 요청 실패');
                }
            });
        });
    </script>
   <%@include file="../../footer.jsp"%>
</body>

