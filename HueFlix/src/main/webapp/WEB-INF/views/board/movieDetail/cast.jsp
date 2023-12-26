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
            var tmdbTitle;
			var tmdbReleaseDate;

			$.ajax({
			    url: "https://api.themoviedb.org/3/movie/" + movieId + "/credits?language=ko-kr&region=KR&api_key=d266bc87db778e91facf58b4bcde4f31",
			    method: "GET",
			    dataType: "json",
			    success: function (data2) {
			        // 배우 id 찾기(5순위까지 검색)
			        // 주연은 0,1로 가정
			        const leadActorIds = findLeadActorIds(data2.cast, [0, 1]); 
        			console.log("주연 배우들의 id:", leadActorIds);
        			
        			// 조연은 2,3,4로 가정
        			const supportingActorIds = findSupportingActorIds(data2.cast, [2, 3, 4]);
        	        console.log("조연 배우들의 id:", supportingActorIds);
			
			        // 배우 정보 표시
			        menuShow(data2, leadActorIds, supportingActorIds);
			    },
			    error: function () {
			        console.log('API 요청 실패');
			    }
			});
			
			// 주연 배우의 id들을 찾는 함수
			function findLeadActorIds(cast, leadOrder) {
			    const leadActorIds = [];
			
			    for (let i = 0; i < cast.length; i++) {
			        if (leadOrder.includes(cast[i].order)) {
			            leadActorIds.push(cast[i].id);
			        }
			    }
			    return leadActorIds;
			}
			
			// 조연 배우의 id들을 찾는 함수
			function findSupportingActorIds(cast, supportingOrder) {
			    const supportingActorIds = [];
			
			    for (let i = 0; i < cast.length; i++) {
			        if (supportingOrder.includes(cast[i].order)) {
			        	supportingActorIds.push(cast[i].id);
			        }
			    }
			    return supportingActorIds;
			}
			
			function menuShow(data2, leadActorIds, supportingActorIds) {
			    	let leadActorProfiles = [];
			        let supportingActorProfiles = [];

			        function processActor(actorId, isLead) {
			            const actorData = data2.cast.find(function (actor) {
			                return actor.id === actorId;
			            });

			            if (actorData) {
			                getKoreanName(actorId, function (koreanName) {
			                    let actorGroupHtml = '';
			                    actorGroupHtml += '<img class="actorImage" src="https://image.tmdb.org/t/p/w200' + actorData.profile_path + '" onerror="this.src=\'../resources/img/NoImage.png\'">';
			                    actorGroupHtml += '<div class="cast">';
			                    actorGroupHtml += '<div class="name">' + koreanName + '</div>';
			                    actorGroupHtml += '<div class="char">' + actorData.character + '역</div>';
			                    actorGroupHtml += '</div>';

			                    // 주어진 조건에 따라서 actor-group1 또는 actor-group2에 배우 정보 추가
			                    if (isLead) {
			                        leadActorProfiles.push(actorGroupHtml);
			                    } else {
			                        supportingActorProfiles.push(actorGroupHtml);
			                    }

			                 	// 모든 주연 및 조연 배우가 로드되면 프로필 HTML을 적용
			                    if (leadActorProfiles.length + supportingActorProfiles.length === leadActorIds.length + supportingActorIds.length) {
			                        const leadActorHtml = '<h2>주연</h2><hr><div class="actor-group1">' + leadActorProfiles.join('') + '</div>';
			                        const supportingActorHtml = '<h2>출연</h2><hr><div class="actor-group2">' + supportingActorProfiles.join('') + '</div>';
			
			                        $('#menuShow').html(leadActorHtml + supportingActorHtml);
			                        console.log('프로필 HTML 적용');
			                    }
			                }, function (error) {
			                    console.error('한글 이름을 가져오는 동안 오류 발생:', error);
			                });
			            }
			        }

			        // 주연 배우 처리
			        for (let i = 0; i < leadActorIds.length; i++) {
			            processActor(leadActorIds[i], true);
			        }

			        // 조연 배우 처리
			        for (let i = 0; i < supportingActorIds.length; i++) {
			            processActor(supportingActorIds[i], false);
			        }
			}
			
			// 배우의 한글 이름을 가져오는 함수
			function getKoreanName(actorId, successCallback, errorCallback) {
			    $.ajax({
			        url: "https://api.themoviedb.org/3/person/" + actorId + "?language=ko-kr&api_key=d266bc87db778e91facf58b4bcde4f31",
			        method: "GET",
			        dataType: "json",
			        success: function (actorInfo) {
			            // 한글 이름이 also_known_as 배열의 첫 번째 요소에 위치함
			            const koreanName = actorInfo.also_known_as[0] || actorInfo.name;
			            successCallback(koreanName);
			        },
			        error: function (error) {
			            errorCallback(error);
			        }
			    });
			}
        });
    </script>
    <%@include file="../../footer.jsp"%>
</body>

