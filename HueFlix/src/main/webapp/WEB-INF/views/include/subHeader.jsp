<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../header.jsp"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>영화 정보 상세보기</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="//netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.css">
    <link rel="stylesheet" type="text/css" href="/ex/resources/css/subHeader.css">
    
    <script>
    document.addEventListener("DOMContentLoaded", function () {
        // 함수를 사용하여 메뉴 활성화 상태를 설정
        function setActiveButton() {
            var currentPath = window.location.pathname;

            buttons.forEach(function (button) {
                if (button.getAttribute("id") === currentPath.substr(currentPath.lastIndexOf('/') + 1)) {
                    button.classList.add("active");
                } else {
                    button.classList.remove("active");
                }
            });
        }
    });

$(document).ready(function() {
	// URL에서 쿼리 매개변수 추출
	const urlParams = new URLSearchParams(window.location.search);
	const movieId = urlParams.get('movieId');
	var tmdbTitle;
	var tmdbReleaseDate;
	
	document.getElementById("info").addEventListener("click", function() {
        window.location.href = "<%= request.getContextPath() %>/board/movieDetail/info?movieId=" + movieId;
    });

    document.getElementById("cast").addEventListener("click", function() {
        window.location.href = "<%= request.getContextPath() %>/board/movieDetail/cast?movieId=" + movieId;
    });

    document.getElementById("video_photo").addEventListener("click", function() {
    	window.location.href = "<%= request.getContextPath() %>/board/movieDetail/video_photo?movieId=" + movieId + "&tmdbTitle=" + encodeURIComponent(tmdbTitle) + "&tmdbReleaseDate=" + encodeURIComponent(tmdbReleaseDate);
    });

    document.getElementById("reply").addEventListener("click", function() {
        window.location.href = "<%= request.getContextPath() %>/board/movieDetail/reply?movieId=" + movieId;
    });
	
//영화 상세정보-------------------------------------------------------------------
	// movieId를 사용하여 영화 정보 불러오기
	$.ajax({
		url : "https://api.themoviedb.org/3/movie/" + movieId + "?language=ko-kr&api_key=d266bc87db778e91facf58b4bcde4f31",
		method : "GET",
		dataType : "json",
		success : function(data) {
			tmdbTitle = data.title;
			tmdbReleaseDate = data.release_date;
			console.log(tmdbReleaseDate);
			
			displayMovieDetails(data);
		},
		error : function() {
			console.log('API 요청 실패');
		}
	});

	function displayMovieDetails(data) {
		$('#moviePoster').attr("src", "https://image.tmdb.org/t/p/w200" + data.poster_path);
		// 제공되는 이미지가 없을 때 대체 이미지
     	$('#moviePoster').on('error', function() {
		    $(this).attr('src', '../resources/img/NoImage.png');
		});
		
		$('#movieTitle').html(data.title);
		
		// 개봉 여부
		// movieDetail에서는 url에 나라 지정이 안되서 개봉일이 국내와 달라서 nowPlaying의 release_date를 가져와야하는데....
		const releaseDate = new Date(data.release_date);
		const currentDate = new Date();
		const daysDiff = Math.ceil((releaseDate - currentDate) / (1000 * 60 * 60 * 24));
		
			//data.status === 'Released'는 우리나라와 해외의 개봉일이 달라서 미사용
		if(currentDate < releaseDate){
			$('#status').html('D-' + daysDiff);
		}else{
			$('#status').html('상영중');
		}
		
		$('#movieOriginalTitle').html(data.original_title);
		$('#movieReleaseDate').html(data.release_date);
		
		// 평점
		$('#star').html(data.vote_average.toFixed(1));
		
		// 장르 정보를 반복문을 통해 가져와 화면에 표시
		let genresHtml = '';
		for (let i = 0; i < data.genres.length; i++) {
			genresHtml += data.genres[i].name;
			if (i < data.genres.length - 1) {
				genresHtml += ', ';
			}
		}
		$('#movieGenres').html(genresHtml);
		
		$('#movieRunTime').html(data.runtime + '분');
						
		// 국가 정보를 반복문을 통해 가져와 화면에 표시
		let regionsHtml = '';
		for (let i = 0; i < data.production_countries.length; i++) {
			regionsHtml += data.production_countries[i].name;
			if (i < data.production_countries.length - 1) {
				regionsHtml += ', ';
			}
		}
		$('#movieRegion').html(regionsHtml);
	}

});
 
</script>
</head>
<body>
<!-- 영화 상세 정보 -->
	<div id="movieDetails">
		<img src="" id="moviePoster" alt="Movie Poster">
		<div id="movieInfo">
			<div class="tsContainer">
				<p id="movieTitle"></p>
				<div id="status"></div>
			</div>
			<p id="movieOriginalTitle"></p>
			<table>
				<tr>
					<th>개봉</th>
					<td id="movieReleaseDate"></td>
					<th>평점</th>
					<td id="star"></td> <!-- 전체 평균 평점 넣어주기 -->
				</tr>
				<tr>
					<th>장르</th>
					<td id="movieGenres"></td>
					<th>러닝타임</th>
					<td id="movieRunTime"></td>
				</tr>
				<tr>
					<th>국가</th>
					<td id="movieRegion"></td>
				</tr>
			</table>
		</div>
		<!-- <p id="movieOverview"></p>  -->
	</div>
<!-- 중간 메뉴 -->
	<div id="menu">
		<button id="info">줄거리</button>
		<button id="cast">출연</button>
		<button id="video_photo">영상/포토</button>
		<button id="reply">평점/댓글</button>
		<div class="bin"></div>
	</div>
	<div id="menuShow">
	
	</div>


</body>
</html>
