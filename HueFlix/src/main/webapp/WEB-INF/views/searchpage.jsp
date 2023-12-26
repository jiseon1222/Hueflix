<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>검색</title>
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <link href="/ex/resources/css/searchpage.css?after" rel="stylesheet">
    <link href="/ex/resources/css/standard.css?after" rel="stylesheet">
    <script type="text/javascript">

        $(document).ready(function () {
        	
        	searchMovies();
        	            
            var currentTab = "all";
            var searchData = {};
            
            // URL에서 매개변수 읽기
            var queryString = window.location.search;
            var urlParams = new URLSearchParams(queryString);

            // 검색어 가져오기
            var searchTerm = urlParams.get('searchTerm');
            
            console.log(searchTerm);

            // 검색어가 있을 경우 자동으로 검색 수행
            if (searchTerm) {
                $("#searchTerm").val(searchTerm);
                searchMovies();
            }

            function searchMovies() {
                // AJAX 요청 및 결과 표시 등의 코드
                $.ajax({
                    method: "GET",
                    url: "https://api.themoviedb.org/3/search/multi",
                    data: { 
                        api_key: "d266bc87db778e91facf58b4bcde4f31",
                        language: "ko-kr",
                        query: $("#searchTerm").val(), // 현재 입력된 검색어 사용
                        region: "KR"
                    }
                })
                .done(function (res) {
                    // 예시: 검색 결과를 표시하는 코드
                    displayResults(res.results);
                    $("#searchResultText").html("'" + $("#searchTerm").val() + "'의 검색결과");

                    // 추가: 현재 탭 활성화 표시
                    $(".tabItem").removeClass("activeTab");
                    $("#" + currentTab).addClass("activeTab");
                })
                .fail(function (xhr, status, error) {
                    console.error("AJAX request failed:", status, error);
                });
            }
            
            $("#searchTerm").keypress(function(event) {
                if (event.which === 13) {
                    $("#searchButton").click();
                }
            });

            $("#searchButton").click(function () {
                // 검색 결과를 초기화
                $("#coverimg").html("");
                $(".card-title").html("");
                $(".card-text").html("");
                $("#searchResultText").html("");

                // AJAX 요청
                $.ajax({
                    method: "GET",
                    url: "https://api.themoviedb.org/3/search/multi",
                    data: { 
                        api_key: "d266bc87db778e91facf58b4bcde4f31",
                        language: "ko-kr",
                        query: $("#searchTerm").val(),
                        region: "KR"
                    }
                })
                .done(function (res) {
                    // 응답이 결과를 포함하는지 확인
                    if (res.results.length > 0) {
                        // 각 탭에 해당하는 결과를 표시
                        displayResults(res.results);
                        $("#searchResultText").html("'" + $("#searchTerm").val() + "'의 검색결과");
                        // 추가: 현재 탭 활성화 표시
                        $(".tabItem").removeClass("activeTab");
                        $("#" + currentTab).addClass("activeTab");
                    } else {
                        alert("검색 결과가 없습니다.");
                    }
                })
                .fail(function (xhr, status, error) {
                    console.error("AJAX request failed:", status, error);
                });
            });

            function displayResults(results) {
                // 결과를 표시하기 전에 해당 요소의 내용 초기화
                $("#coverimg").html("");
                $(".card-title").html("");
                $(".card-text").html("");

                results.forEach(function (result) {
                	console.log(result.media_type);
                    if (result.media_type === "movie" && (currentTab === "all" || currentTab === "movie")) {
                        displayMovie(result);
                    } else if (result.media_type === "person" && (currentTab === "all" || currentTab === "person")) {
                        displayPerson(result);
                    }
                });
            }


            function displayMovie(result) {
                var movieLink = $("<a>")
                    .attr("href", "include/subHeader?movieId=" + result.id)
                    .append("<img class='movie-poster' data-id='" + result.id + "' src='https://image.tmdb.org/t/p/w500" + result.poster_path + "'/>");

                // 각각의 영화에 대한 카드 생성
                var movieCard = $("<div class='card mb-3' style='max-width: 60%; border: none;'>");
                var rowDiv = $("<div class='row g-0'>");
                var posterDiv = $("<div class='col-md-4' id='coverimg'>").append(movieLink);
                var infoDiv = $("<div class='col-md-8'>");
                var cardBody = $("<div class='card-body'>");
                
                // 각각의 영화에 대한 정보 추가
                cardBody.append("<h5 class='card-title'>" + result.title + "</h5>");
                if (result.release_date) {
                    cardBody.append("<p class='card-text'>개봉일: " + result.release_date + "</p>");
                }
                if (result.genre_ids && result.genre_ids.length > 0) {
                    cardBody.append("<p class='card-text'>장르: " + getGenres(result.genre_ids) + "</p>");
                }

                // 러닝타임 정보를 가져와 추가
                $.ajax({
                    method: "GET",
                    url: "https://api.themoviedb.org/3/movie/" + result.id,
                    data: { 
                        api_key: "d266bc87db778e91facf58b4bcde4f31",
                        language: "ko-kr"
                    }
                })
                .done(function (movieDetails) {
                    if (movieDetails.runtime) {
                        cardBody.append("<p class='card-text'>러닝타임: " + movieDetails.runtime + "분</p>");
                    }
                })
                .fail(function (xhr, status, error) {
                    console.error("Failed to fetch movie details:", status, error);
                });

                // 각각의 영화에 대한 카드를 표시
                infoDiv.append(cardBody);
                rowDiv.append(posterDiv).append(infoDiv);
                movieCard.append(rowDiv);
                $("#coverimg").append(movieCard);
            }


            // 장르 ID를 받아와 해당하는 장르 이름으로 변환하는 함수
            function getGenres(genreIds) {
                const genres = {
                    28: "액션",
                    12: "모험",
                    16: "애니메이션",
                    35: "코미디",
                    80: "범죄",
                    99: "다큐멘터리",
                    18: "드라마",
                    10751: "가족",
                    14: "판타지",
                    36: "역사",
                    27: "공포",
                    10402: "음악",
                    9648: "미스터리",
                    10749: "로맨스",
                    878: "공상 과학 소설",
                    10770: "TV 영화",
                    53: "스릴러",
                    10752: "전쟁",
                    37: "서부"
                };

                return genreIds.map(id => genres[id]).join(", ");
            }
            
            function displayPerson(result) {
                var profilePath = result.profile_path ? "<img src='https://image.tmdb.org/t/p/w500" + result.profile_path + "'/>" : "";
                
                // 각각의 영화인에 대한 카드 생성
                var personCard = $("<div class='card mb-3' style='max-width: 100%; border: none;'>");
                var rowDiv = $("<div class='row g-0'>");
                var posterDiv = $("<div class='col-md-4' id='coverimg'>").append(profilePath);
                var infoDiv = $("<div class='col-md-8'>");
                var cardBody = $("<div class='card-body'>");
                
                // 각각의 영화인에 대한 정보 추가
                cardBody.append("<h5 class='card-title'>" + result.name + "</h5>");
                if (result.biography) {
                    cardBody.append("<p class='card-text'>" + result.biography + "</p>");
                }
                if (result.known_for_department === "Acting" && result.known_for && result.known_for.length > 0) {
                    cardBody.append("<p class='card-text'><strong>필모그래피:</strong></p>");
                    result.known_for.forEach(function (work) {
                        cardBody.append("<p class='card-text'>" + work.title + " (" + (work.release_date ? work.release_date.substring(0, 4) : "미상") + ")</p>");
                    });
                }

                // 각각의 영화인에 대한 카드를 표시
                infoDiv.append(cardBody);
                rowDiv.append(posterDiv).append(infoDiv);
                personCard.append(rowDiv);
                $("#coverimg").append(personCard);
            }

            $(document).on('click', '.movie-poster', function() {
                var movieId = $(this).data('id');
                window.location.href = "subHeader.jsp?type=movie&id=" + movieId;
            });

            $(".tabItem").click(function () {
                $(".tabItem").removeClass("activeTab");
                $(this).addClass("activeTab");
                currentTab = $(this).attr("id");
                
                // 검색을 다시 수행
                searchMovies();
            });
        });
    </script>
</head>
<body>
    <%@include file="/WEB-INF/views/header.jsp"%>
    <br>

	<div style="height: 180px;"></div>

    <!-- 추가: 검색 결과 텍스트 표시 영역 -->
    <div id="searchResultText"></div>

    <!-- 추가: 탭 바 -->
    <div class="tabBar">
        <div class="tabItem activeTab" id="all">전체</div>
        <div class="tabItem" id="movie">영화</div>
        <div class="tabItem" id="person">영화인</div>
    </div>

    <!-- 검색 결과를 표시할 카드 디자인입니다. -->
    <div class="card mb-3" style="max-width: 60%; border: none;">
        <div class="row g-0">
            <!-- 영화 포스터 또는 인물 사진을 표시할 디브 -->
            <div class="col-md-4" id="coverimg"></div>
            <div class="col-md-8">
                <!-- 영화 제목 또는 인물 이름과 개요를 표시할 카드 본문 -->
                <div class="card-body">
                    <h5 class="card-title" id="resultType"></h5>
                    <p class="card-text"></p>
                    <!-- 원하는 만큼의 세부 정보를 추가하세요. -->
                </div>
            </div>
        </div>
    </div>
    <%@include file="footer.jsp"%>
</body>
</html>
