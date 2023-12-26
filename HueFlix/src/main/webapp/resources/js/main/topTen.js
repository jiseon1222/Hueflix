//TMDB 관련
const API_KEY = 'd266bc87db778e91facf58b4bcde4f31';
const baseImageUrl = 'https://image.tmdb.org/t/p/original';
const baseApiInfo = 'https://api.themoviedb.org/3/';

//랭크를 요청할 주소
fetch(`${baseApiInfo}movie/now_playing?api_key=${API_KEY}&language=ko-KR&region=KR&sort_by=vote_average.desc&with_release_type=3&page=1`)
  .then(response => response.json())
  .then(data => {
	const sortMovies = data.results.sort((a, b) => b.vote_average - a.vote_average);
	const topMovies = sortMovies.slice(0, 10);
	//<div class="swiper-wrapper">
    const swiperWrapper = document.querySelector('.topTenSwiper .swiper-wrapper');
    
    topMovies.forEach((movie, index) => {
      //div 생성
      const slide = document.createElement('div');
      //div 객체들
      slide.classList.add('swiper-slide');
      //랭크 요청 주소에서 받아온 영화 ID
      let id = movie.id;
      //검색 결과엔 tagline값을 불러올 수 없으므로, id로 접근해서 요청함
      function getTagline(id) {
    	  return fetch(`${baseApiInfo}movie/${id}?api_key=${API_KEY}&language=ko-KR`)
    	  .then(response => response.json())
    	  .then(data=> {
    		  return data.tagline;
    	  })
      }
      //검색 결과엔 genres값을 불러올 수 없으므로, id로 접근해서 요청함
      function getGenres(id) {
    	  return fetch(`${baseApiInfo}movie/${id}?api_key=${API_KEY}&language=ko-KR`)
    	  .then(response => response.json())
    	  .then(data=> {
    		  return data.genres.map(genres => genres.name);
    	  })
      }
      
      //영화 배경 이미지가 존재하는 경우
      if (movie.backdrop_path) {
    	//배경 이미지 주소
        const img = document.createElement('img');
        img.src = `${baseImageUrl}${movie.backdrop_path}`;
  
        //영화 제목
        const title = document.createElement('p');
        title.classList.add('title');
        title.textContent = movie.title;
        //영화 평점
        const rating = document.createElement('span');
        rating.classList.add('rating');
        rating.textContent = `평점: ${movie.vote_average.toFixed(1)}   /`;
        //영화 장르
        const genres = document.createElement('span');
        genres.classList.add('genres');
        //장르 불러오는 함수
        getGenres(movie.id).then(movieGenres => {
        	if(movieGenres){
        		genres.textContent = `${movieGenres.join(', ')}`;
        	}
        })
        //영화 태그라인
        const tagline = document.createElement('p');
        tagline.classList.add('tagline');
        //태그라인 불러오는 함수
        getTagline(movie.id).then(movieTagline => {
        	if(movieTagline){
        		tagline.textContent = `"${movieTagline}"`;
        	}
        }) 
        //순위
        const rank = document.createElement('span');
        rank.classList.add('rank');
        rank.textContent = `${index + 1}`;
        
        //Swiper 슬라이드에 요소 추가
        slide.appendChild(img);
        slide.appendChild(title);
        slide.appendChild(rating);
        slide.appendChild(genres);
        slide.appendChild(tagline);
        slide.appendChild(rank);
        swiperWrapper.appendChild(slide);
        
        // 영화 세부 정보로 이동
        slide.addEventListener('click', function(event) {
        event.preventDefault(); // 기본 동작 방지
        location.href = '/ex/include/subHeader?movieId=' + id;
        });
      }
    });
    
    //Swiper 관련 설정
    const swiper = new Swiper('.topTenSwiper', {
      direction: "horizontal",
      loop: true,
      initialSlide: 0,
      autoplay: {
          delay: 6000,
          disableOnInteraction: false, 
      },
      pagination: {
        el: '.swiper-pagination',
        clickable: true
      },
      navigation: {
        nextEl: '.swiper-button-next',
        prevEl: '.swiper-button-prev',
      },
      spaceBetween: 0,
      slidesPerView: "1",
      centeredSlides: true,
      effect: "slide",
      breakpoints: {
    	  1280: {
    		  slidesPerView: 1.4,
    		  spaceBetween: 30
    	  }
      }
    });
  })
  .catch(error => console.error('Error fetching movies:', error));