<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>검색</title>
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <style>
    	body {
            background-color: black;
            color: white;
        }
        #coverimg img {
            max-width: 100%;
            max-height: 300px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        #searchResultText {
            font-weight: bold;
            margin-bottom: 10px;
        }

        .tabBar {
            display: flex;
            justify-content: space-around;
            background-color: #000000;
            padding: 10px;
        }

        .tabItem {
            padding: 10px;
            cursor: pointer;
            border: 1px solid #ffffff;
            border-radius: 5px;
        }

        .tabItem:hover {
            background-color: #000000;
        }

        .activeTab {
            background-color: #000000;
            border: 2px solid #ffffff;
            border-bottom: none;
            border-radius: 5px 5px 0 0;
        }
        body {
    	text-align: center; 
		}

		#coverimg {
    	margin: 0 auto;
    	display: block;
		}

		#searchResultText {
    	text-align: center;
		}

		.card {
    	margin: 0 auto;
		}
		
		
    </style>
    <script type="text/javascript">
        $(document).ready(function () {
            var currentTab = "all";
            var searchData = {};
            
            $("#searchTerm").keypress(function(event) {
                if (event.which === 13) {
                    $("#search").click();
                }
            });

            $("#search").click(function () {
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
                $("#coverimg").html("");
                $(".card-title").html("");
                $(".card-text").html("");

                results.forEach(function (result) {
                    if (result.media_type === "movie" && (currentTab === "all" || currentTab === "movie")) {
                        displayMovie(result);
                    } else if (result.media_type === "person" && (currentTab === "all" || currentTab === "person")) {
                        displayPerson(result);
                    }
                });
            }

            function displayMovie(result) {
                $("#resultType").text("영화");
                $("#coverimg").append("<img src='https://image.tmdb.org/t/p/w500" + result.poster_path + "'/>");
                $(".card-title").append("<p>" + result.title + "</p>");
                $(".card-text").append("<p>" + result.overview + "</p>");
                if (result.release_date) {
                    $(".card-text").append("<p>개봉일: " + result.release_date + "</p>");
                }
            }

            function displayPerson(result) {
                $("#resultType").text("영화인");
                var profilePath = result.profile_path ? "<img src='https://image.tmdb.org/t/p/w500" + result.profile_path + "'/>" : "";
                $("#coverimg").append(profilePath);
                $(".card-title").append("<p>" + result.name + "</p>");
				
                
                if (result.biography) {
                    $(".card-text").append("<p>" + result.biography + "</p>");
                }
                if (result.known_for_department === "Acting" && result.known_for && result.known_for.length > 0) {
                    $(".card-text").append("<p><strong>필모그래피:</strong></p>");
                    result.known_for.forEach(function (work) {
                        $(".card-text").append("<p>" + work.title + " (" + (work.release_date ? work.release_date.substring(0, 4) : "미상") + ")</p>");
                    });
                }
            }


            $(".tabItem").click(function () {
                $(".tabItem").removeClass("activeTab");
                $(this).addClass("activeTab");
                currentTab = $(this).attr("id");
                // 검색을 다시 수행
                $("#search").click();
            });
        });
    </script>
</head>
<body>
    <br>
    <h1>무비무비</h1>
	
    <input id="searchTerm" type="text" placeholder="영화, 인물 검색">
    <button id="search">검색</button>

    <div style="height:50px;"></div>

    <!-- 추가: 검색 결과 텍스트 표시 영역 -->
    <div id="searchResultText"></div>

    <!-- 추가: 탭 바 -->
    <div class="tabBar">
        <div class="tabItem activeTab" id="all">전체</div>
        <div class="tabItem" id="movie">영화</div>
        <div class="tabItem" id="person">영화인</div>
    </div>

    <!-- 검색 결과를 표시할 카드 디자인입니다. -->
    <div class="card mb-3" style="max-width:60%; border:none;">
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
    <%@include file="../footer.jsp"%>
</body>
</html>
