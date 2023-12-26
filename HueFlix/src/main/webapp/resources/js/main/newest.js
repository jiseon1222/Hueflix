fetch(`${baseApiInfo}discover/movie?api_key=${API_KEY}&language=ko-KR&region=KR&sort_by=release_date.desc&with_release_type=3&page=1`)
  .then(response => response.json())
  .then(data => {
    const newestMovies = data.results; 
    const swiperWrapper = document.querySelector('.newestSwiper .swiper-wrapper'); // HTML에서 swiper-wrapper 클래스 찾기
    
    newestMovies.forEach(movie => {
      const slide = document.createElement('div'); // 새로운 슬라이드 요소 생성
      slide.classList.add('swiper-slide'); // 클래스 추가
      
      let id = movie.id;
      
      //장르
      function getGenres(id) {
    	  return fetch(`${baseApiInfo}movie/${id}?api_key=${API_KEY}&language=ko-KR`)
    	  .then(response => response.json())
    	  .then(data=> {
    		  return data.genres.map(genres => genres.name);
    	  })
      }

      if (movie.poster_path) {
    	//포스터
        const img = document.createElement('img');
        img.src = `${baseImageUrl}${movie.poster_path}`;
        
        //텍스트 요소 div
        const textOverlay = document.createElement('div');
        textOverlay.classList.add('slide-text');
        
        Promise.all([
        	getGenres(movie.id)
        ]).then(([movieGenres]) => {
        	//제목
            const title = document.createElement('div');
            title.classList.add('title');
            textOverlay.appendChild(title);
            
            const titleP = document.createElement('p');
            titleP.textContent = movie.title;
            title.appendChild(titleP)
            //개봉 예정일
            const releaseDate = document.createElement('div');
            releaseDate.classList.add('releaseDate');
            textOverlay.appendChild(releaseDate);
            
            const releaseDateP = document.createElement('p');
            releaseDateP.textContent = `개봉일 : ${movie.release_date}`;
            releaseDate.appendChild(releaseDateP);
            //장르
            const genres = document.createElement('div');
            genres.classList.add('genres');
            textOverlay.appendChild(genres);
            
            const genresP = document.createElement('p');
            genresP.textContent = `${movieGenres.join(', ')}`;
            genres.appendChild(genresP);
           
            slide.appendChild(textOverlay);
            slide.appendChild(img);
            swiperWrapper.appendChild(slide); // swiper-wrapper에 슬라이드 추가
            
            // 영화 세부 정보로 이동
            slide.addEventListener('click', function(event) {
                event.preventDefault(); // 기본 동작 방지
                location.href = '/ex/include/subHeader?movieId=' + id;
            });
        });     
      }    
    });

    // Swiper 인스턴스 생성
    const swiper = new Swiper('.newestSwiper', {
    	slidesPerView: 2,	
    	spaceBetween: 20,
    	navigation: {
    		nextEl: '.swiper-button-next',
    		prevEl: '.swiper-button-prev',
    	},
    	breakpoints: {
    		600: {
    			slidesPerView: 3
    		},
    		900: {
    	    	slidesPerView: 4
    	    },
    	    1024: {
    	    	slidesPerView: 5
    	    },
    	    1440: {
    	    	slidesPerView: 6
    	    },
    	    1600: {
    	    	slidesPerView: 7
    	    }
    	}
    });
  })
  .catch(error => console.error('영화 정보를 가져오는 중 에러 발생:', error));