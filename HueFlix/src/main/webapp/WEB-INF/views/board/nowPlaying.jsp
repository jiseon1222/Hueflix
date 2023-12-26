<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="false"%>
<%@include file="/WEB-INF/views/header.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
    <link rel="stylesheet" type="text/css" href="/ex/resources/css/nowPlaying.css">
    <script>
        $(document).ready(function () {
        	
        	// 넘치는 글씨 중략 표시 함수
            function truncateText(text, maxLength) {
			    if (text.length > maxLength) {
			        return text.substring(0, maxLength) + '...';
			    }
			    return text;
			}
        	
            var currentPage = 1;
            var totalPages = 1;
//loadPage시작---------------------------------------------------------------------------
            function loadPage(page) {
            	var url = 'https://api.themoviedb.org/3/movie/now_playing?language=ko-kr&region=kr&page=' + page + '&api_key=d266bc87db778e91facf58b4bcde4f31';

                $.ajax({
                    url: url,
                    type: 'get',
                    success: function (res) {
                        console.log(res);
                        
                        totalPages = res.total_pages;
                        
                     	// 현재 날짜 추출
                        var currentDate = new Date().toISOString().split('T')[0];
                        
                        // 응답 코드의 maximum, minimum 날짜 현재 날짜로 변경
                        res.dates.maximum = currentDate;
                        res.dates.minimum = currentDate;

                     	// 영화 정보를 vote_average 기준으로 내림차순 정렬
                        res.results.sort(function(a, b) {
                            return b.vote_average - a.vote_average;
                        });
                                                
                        $('#movieContainer').empty();
			            
			            res.results.forEach(function (movie) {
                            var movieInfoDiv = $('<div>').addClass('movie-info');

                         	// 포스터 이미지 추가
							var imgElement = $('<img>', {
							    'id': 'poster',
							    'src': 'https://image.tmdb.org/t/p/w200/' + movie.poster_path,
							    'alt': 'Movie Poster',
							    'data-movieid': movie.id
							});
                         	// 제공되는 이미지가 없을 때 대체 이미지
                         	imgElement.on('error', function() {
							    $(this).attr('src', '/ex/resources/img/NoImage.png');
							});
							movieInfoDiv.append(imgElement);

                            // 관련 정보 추가
                            movieInfoDiv.append('<div class="detail" data-movieid="' + movie.id + '">' + truncateText(movie.title, 12) +'</div>'); // 최대 12자로 축약
                            
                            movieInfoDiv.append('<div>'+movie.id+'</div>');
                            
                            movieInfoDiv.append('<span>평점 </span>');
                            movieInfoDiv.append('<span class="average">'+movie.vote_average.toFixed(1)+'</span>'); //.toFixed(1): 소수점 아래 첫째자리까지 출력
                            
                            movieInfoDiv.append('<div class="release">개봉 '+movie.release_date+'</div>');
                            
                            // 영화 세부 정보
                            movieInfoDiv.append('<div class="overview" data-movieid="' + movie.id + '">'+truncateText(movie.overview, 100)+'</div>');
                                                                                      
                            $('#movieContainer').append(movieInfoDiv);
                           
                        });
			         	// 현재 페이지 갱신
		                $('#currentPage').text(page);
		                updateNextButtonState();
                    },
                    error: function () {
                        console.log('통신 실패');
                    }
                });
             	                                
            }
//loadPage끝---------------------------------------------------------------------------
            loadPage(currentPage);

            $('#nextBtn').click(function () {
            	currentPage++;
                loadPage(currentPage);
                $('#prevBtn').prop('disabled', false); // 이전 버튼 활성화
            });

            $('#prevBtn').click(function () {
            	if (currentPage > 1) {
                    currentPage--;
                    loadPage(currentPage);
                    if (currentPage === 1) {
                        $('#prevBtn').prop('disabled', true); // 현재 페이지가 1이면 이전 버튼 비활성화
                    }
                }
            });
            
            function updateNextButtonState() {
            	// 현재페이지가 마지막페이지면 다음 버튼 비활성화
                $('#nextBtn').prop('disabled', currentPage === totalPages);
            }
            
            // 영화 세부 정보로 이동
            $('#movieContainer').on('click', '.detail, #poster, .overview', function (event) {
                event.preventDefault(); // 기본 동작 방지
                var movieId = $(this).attr('data-movieid');
                location.href = '/ex/include/subHeader?movieId=' + movieId;
            });
            
        });
    </script>
</head>
<body>
 
    <!-- 영화 정보 출력할 장소 -->
    <div id="movieContainer"></div>
    
	<div class="move2">
		<button id="prevBtn" disabled>이전</button>
	    <span id="currentPage"></span>
	    <button id="nextBtn">다음</button>
	</div>
	<%@include file="../footer.jsp"%>
</body>
</html>
