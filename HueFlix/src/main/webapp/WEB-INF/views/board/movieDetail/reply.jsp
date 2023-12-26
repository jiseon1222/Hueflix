<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="false"%>
<%@include file="../../include/subHeader.jsp"%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

   <body>
   <!-- 댓글/평점 -->
   <div id="comment">
      <li class="comment-form">  
         <fieldset class="rate" id="starRating">
            <h4>댓글쓰기</h4>
            
            <input type="radio" id="rating10" name="rating" value="5"><label for="rating10" title="5점"></label>
               <input type="radio" id="rating9" name="rating" value="4.5"><label class="half" for="rating9" title="4.5점"></label>
               <input type="radio" id="rating8" name="rating" value="4"><label for="rating8" title="4점"></label>
               <input type="radio" id="rating7" name="rating" value="3.5"><label class="half" for="rating7" title="3.5점"></label>
               <input type="radio" id="rating6" name="rating" value="3"><label for="rating6" title="3점"></label>
               <input type="radio" id="rating5" name="rating" value="2.5"><label class="half" for="rating5" title="2.5점"></label>
               <input type="radio" id="rating4" name="rating" value="2"><label for="rating4" title="2점"></label>
               <input type="radio" id="rating3" name="rating" value="1.5"><label class="half" for="rating3" title="1.5점"></label>
               <input type="radio" id="rating2" name="rating" value="1"><label for="rating2" title="1점"></label>
               <input type="radio" id="rating1" name="rating" value="0.5"><label class="half" for="rating1" title="0.5점"></label>
               <div id="averageRating">
               <span id="averageValue">0</span>
            </div>
         </fieldset>
         <p></p>         
          <span class="name_box">
            <input type="text" id="nickname" value="${nickname }" class="int" name="nickname" disabled/>
         </span><br>
         
         <span class="re_box">
            <textarea placeholder="댓글을 입력해주세요" class="int" id="newContent" name="rContent"></textarea> 
         </span> 
       <button id="addBtn" class="btn">등록</button>
   
      </li>

  <!--   <div>내용: <textarea style="width:100%"name="rContent" rows="8" id="newContent" placeholder="내용을 입력해주세요"></textarea></div>-->
      
   </div>
   
  <ul id="replies"></ul>
   <div class="pagination"></div>
   
    <script>
         var page = 1;
         var perPageNum= 10;
         const urlParams = new URLSearchParams(window.location.search);
            const movieId = urlParams.get('movieId');
        $(document).ready(function() {
            // URL에서 쿼리 매개변수 추출
            
            function calculateAverageRating() {
            const ratings = document.querySelectorAll('input[name="rating"]');
            let totalRating = 0;
            let numberOfRatings = 0;

            // 각 라디오 버튼을 선택하고 해당 값들을 합산하며 선택된 라디오 버튼의 수를 증가시킴
            ratings.forEach(function(rating) {
               if (rating.checked) {
                  totalRating += parseFloat(rating.value);
                  numberOfRatings++;
               }
            });

            // 선택된 라디오 버튼이 하나 이상인 경우, 총 평점을 라디오 버튼의 수로 나눠 평균 평점을 계산
            const averageRating = numberOfRatings > 0 ? totalRating / numberOfRatings : 0;
            const averageValueElement = document.getElementById('averageValue');
            
            // 계산된 평균 평점을 소수점 두 자리까지 반올림하여 "averageValue" ID를 가진 요소에 표시
            averageValueElement.textContent = averageRating.toFixed(2);
         }
         
         // 라디오 버튼에 변경 이벤트 리스너를 추가하여 라디오 버튼을 새로 선택하거나 변경할 때마다 평균 평점을 다시 계산
         const ratingInputs = document.querySelectorAll('input[name="rating"]');
         ratingInputs.forEach(function(input) {
            input.addEventListener('change', calculateAverageRating);
         });

         // 초기에 평균 평점을 계산하여 설정
         calculateAverageRating();

        });
        
           var result = '${msg}';
           if (result == 'success') {
              alert("처리가 완료되었습니다.");
           }
           
           getPageList(page);
           
        // 등록 버튼
           $("#addBtn").on("click", function () {
               var starScore = $("#averageValue").text(); // Use text() instead of val()
               var rContent = $("#newContent").val();
               var nickname = $("#nickname").text();

               $.ajax({
                   type: 'post',
                   url: '/ex/comment/',
                   headers: {
                       "Content-Type": "application/json"
                   },
                   dataType: 'text',
                   data: JSON.stringify({
                       movieId: movieId,
                       nickname: nickname,
                       rContent: rContent,
                       starScore: starScore
                   }),
                   success: function (result) {
                       if (result == 'SUCCESS') {
                           alert("댓글이 등록되었습니다.");
                           getPageList(page);
                           resetCommentForm();
                       }
                   }
               });
           });
        
        // 어떤 댓글인지 식별하는 데 사용(한 페이지에 10개씩 페이징 나누기)
           $("#replies").on("click", ".replyLi button", function() {
              var rId = $(this).parent().attr("data-rId");
              var rContent = $(this).siblings(".rContent").text();
              
              $("#rContent").val(rContent);
              $("#replyUdc").show("slow");
           })
           
           $(".pagination").on("click","a",function(event){
              event.preventDefault();
              page=$(this).attr("href");
              getPageList(page);
           });
        
           // 삭제 버튼 클릭 이벤트
           $(document).on("click", ".rRemove", function () {
        	   var rId = $(this).parent().attr("data-rId");

               $.ajax({
                   type: 'delete',
                   url: '/ex/comment/' + rId,
                   headers: {
                       "Content-Type": "application/json"
                   },
                   dataType: 'text',
                   data: JSON.stringify({
                       rId: rId,
                   }),
                   success: function (result) {
                       if (result == 'SUCCESS') {
                           alert("댓글이 삭제되었습니다.");
                           getPageList(page);
                       }
                   }
               });
           });

        
            function getPageList(page) {
               var str = "";
               // 4294/1

               $.getJSON("/ex/comment/" + movieId + "/" + page, function (data) {
            	   console.log(data);
                   $(data.list).each(function () {
                       var rWriteTime = new Date(this.rWriteTime);
                       var formattedDateTime = rWriteTime.getFullYear() + "-" +
                           ('0' + (rWriteTime.getMonth() + 1)).slice(-2) + "-" +
                           ('0' + rWriteTime.getDate()).slice(-2) + " " +
                           ('0' + rWriteTime.getHours()).slice(-2) + ":" +
                           ('0' + rWriteTime.getMinutes()).slice(-2) + ":" +
                           ('0' + rWriteTime.getSeconds()).slice(-2);
                           
                        // 평점을 별 아이콘으로 변환
                           var starIcons = '';
                        
                           for (var i = 1; i <= 5; i++) {
                               if (i <= this.starScore) {
                                   starIcons += '<i class="fas fa-star"></i>';
                               } else if (i - 0.5 === this.starScore) {
                                   starIcons += '<i class="fas fa-star-half-alt"></i>';
                               } else {
                                   starIcons += '<i class="far fa-star"></i>';
                               }
                           }
                           
                           // 평점과 별 아이콘을 함께 표시
                           var starRatingHtml = '<div class="starRating" style="color: red;">' + starIcons + ' ' + this.starScore + '</div>';
                           var isAdmin = isAdminUser(); // 관리자 여부 확인
                           
                        // HTML 조건부 추가: 관리자인 경우 삭제 버튼을 보여줌
                           var deleteButton = isAdmin ? "<button class='rRemove' style='display: inline-block; margin-left: 10px;'>삭제</button>" : "";
                           
                           
                           str += "<div data-rId='" + this.rId + "' class='replyLi' style='width: calc(100% - " + (this.rIndent * 20) + "px); margin-left: " + (this.rIndent * 20) + "px;'>" +
                           starRatingHtml +
                           "<div class='name-box'>작성자: " + this.nickname + "</div> " +
                           "<div class='newContent'>내용: " + this.rContent + "</div> " +
                           "<div class='rWriteTime' style='display: inline-block;'>작성시간: " + formattedDateTime + "</div>" +
                           deleteButton + "</div><br>"; // 관리자인 경우에만 삭제 버튼 추가
							
                   });
                   

              function format(num) {
                       return num < 10 ? "0" + num : num;
                   }
                   $("#replies").html(str);
                   str = "";
                   /* console.log(data.pageMaker)
                   console.log(data)
                   alert(data.pageMaker.prev); */
                   if (data.pageMaker.prev) {
                       str += "<a href='" + (data.pageMaker.startPage - 1) + "'> << </a>";
                   }

                   for (var i = data.pageMaker.startPage; i <= data.pageMaker.endPage; i++) {
                       var strClass = data.pageMaker.page == i ? 'class=active' : '';

                       str += "<a " + strClass + " href='" + i + "'>" + i + "</a>" +"&nbsp;"
                   }
                   if (data.pageMaker.next) {
                       str += "<a href='" + (data.pageMaker.endPage + 1) + "'> << </a>";
                   }
                   // alert(str);
                   $(".pagination").html(str);

               });
           } 
         // 댓글 양식 초기화 함수
            function resetCommentForm() {
                $("#newContent").val('');
                $("#averageValue").text("0.00");
                $('input[name="rating"]').prop('checked', false);
            }
         // 사용자 역할에 "ADMIN"이 포함되어 있는지 확인
            function isAdminUser() {
                var userRole = "${userRole}"; // userRole에는 해당 사용자의 역할이 문자열로 들어가야 합니다.
 
                return userRole.includes('ADMIN');
            }
    </script>
<%@include file="../../footer.jsp"%>
</body>
