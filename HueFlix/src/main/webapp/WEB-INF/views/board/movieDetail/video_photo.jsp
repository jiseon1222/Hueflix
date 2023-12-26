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
            const tmdbTitle = urlParams.get('tmdbTitle');
			const tmdbReleaseDate = urlParams.get('tmdbReleaseDate');;
			
			console.log(tmdbTitle);
			
			// TMDB의 데이터와 KMDB의 데이터를 더 정확하게 연결하기 위해 영화명과 개봉일자가 같은 데이터의 포토/영상만 추출
			tmdbReleaseDts = new Date(tmdbReleaseDate);
			
			// Date 객체를 YYYYMMDD 형식의 문자열로 변환
			function formatDateToYYYYMMDD(date) {
			    const year = date.getFullYear();
			    const month = String(date.getMonth() + 1).padStart(2, '0');
			    const day = String(date.getDate()).padStart(2, '0');
			    return `${year}${month}${day}`;
			}
			
			// 변환된 문자열 사용
			const kmdbReleaseDateString = formatDateToYYYYMMDD(tmdbReleaseDts);
			console.log("kmdbReleaseDateString", kmdbReleaseDateString);

			    $.ajax({
			        url: "http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp",
			        method: "GET",
			        dataType: "json",
			        data: {
			            collection: "kmdb_new2",
			            detail: "Y",
			            title: tmdbTitle,
			            releaseDts: kmdbReleaseDateString,
			            ServiceKey: "87TL96BZ5N9JWB39CL28"
			        },
			        success: function (kmdbData) {
			            if (kmdbData && kmdbData.Data && kmdbData.Data[0] && kmdbData.Data[0].Result) {
			            	console.log('KMDB API 응답:', kmdbData);
			            	
			            	// KMDB에서 얻은 영화 정보를 사용하여 스틸컷 이미지와 동영상을 표시
			                displayKMDBContent(kmdbData);
			            } else {
			                console.log('KMDB API 응답 형식 오류');
			            }
			        },
			        error: function () {
			            console.log('KMDB API 요청 실패');
			        }
			    });

			    function displayKMDBContent(kmdbData) {
			        // 버튼 누를 때마다 영상/포토가 추가되는 것을 방지하기 위해 #menuShow의 자식 요소들을 지움
			        $('#menuShow').empty();

			        const result = kmdbData.Data[0].Result[0];

			        // 이미지 표시
			         $('#menuShow').append('<h2>포토</h2><hr>');
			        if (result && result.stlls) {
			            const stillCutUrls = result.stlls.split('|');
			            console.log("스틸컷",stillCutUrls)
			            const photoContainer = $('<div class="movie-photo">');
			            const imgTag = $('<img>');

			            for (let i = 0; i < stillCutUrls.length; i++) {
			                imgTag.attr('src', stillCutUrls[i]);
			                imgTag.on('error', function () {
			                    $(this).attr('src', '../resources/img/NoImage.png');
			                });
			                photoContainer.append(imgTag.clone()); // clone()을 사용하여 이미지 태그 복사 후 추가
			            }

			            $('#menuShow').append(photoContainer);
			            console.log('스틸컷', result.stills);
			        }

			        // 동영상 표시
			        const videoUrls = result && result.vods && result.vods.vod;
			        if (videoUrls && videoUrls.length > 0) {
			            const videoSection = $('<div class="video-section">');
			            videoSection.append('<h2>영상</h2><hr>');

			            for (const video of videoUrls) {
			                const videoUrl = video.vodUrl;
			                const videoClass = video.vodClass;

			                // vodUrl이 비어있는 경우 스킵
			                if (!videoUrl) {
			                    continue;
			                }

			                // 비디오를 삽입하기 위한 <iframe> 요소 생성
			                const videoIframe = $('<iframe>');
			                videoIframe.attr('src', videoUrl);
			                videoIframe.attr('frameborder', '0');
			                videoIframe.attr('allowfullscreen', 'true');

			                const videoContainer = $('<div class="movie-video">');
			                videoContainer.append(videoIframe);

			                const videoTitle = $('<div class="video-title">');
			                videoTitle.text(videoClass);

			                videoContainer.append(videoTitle);
			                videoSection.append(videoContainer);
			            }

			            $('#menuShow').append(videoSection);
			            console.log('영상', result.vods);
			        }
			        
			    }
			    $(document).on('click', '.movie-photo img', function () {
			        const imageUrl = $(this).attr('src');

			        // 팝업 창을 생성합니다
			        const popup = $('<div class="popup">');
			        const enlargedImage = $('<img>').attr('src', imageUrl);
			        popup.append(enlargedImage);

			        // body에 팝업을 추가합니다
			        $('body').append(popup);

			        // 팝업을 클릭하면 닫히도록 하는 클릭 이벤트를 추가합니다
			        popup.on('click', function () {
			            $(this).remove();
			        });
			    });

        });
    </script>
    <%@include file="../../footer.jsp"%>
</body>
