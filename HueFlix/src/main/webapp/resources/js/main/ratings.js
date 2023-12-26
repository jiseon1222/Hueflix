fetch(`${baseApiInfo}discover/movie?api_key=${API_KEY}&language=ko-KR&region=KR&sort_by=vote_average.desc&vote_count.gte=1000&with_release_type=3&page=1`)
  .then(response => response.json())
  .then(data => {
    const sortMovies = data.results.sort((a, b) => b.vote_average - a.vote_average);
    const rankedMovies = sortMovies;
    const swiperWrapper = document.querySelector('.ratingSwiper .swiper-wrapper'); // HTML에서 swiper-wrapper 클래스 찾기

    function getGenres(id) {
      return fetch(`${baseApiInfo}movie/${id}?api_key=${API_KEY}&language=ko-KR`)
        .then(response => response.json())
        .then(data => {
          return data.genres.map(genres => genres.name);
        });
    }

    function getReleaseYear(id) {
      return fetch(`${baseApiInfo}movie/${id}?api_key=${API_KEY}&language=ko-KR`)
        .then(response => response.json())
        .then(data => {
          const date = new Date(data.release_date);
          return date.getFullYear();
        });
    }

    function fetchMovieInfo(movie, index) {
      const rYearPromise = getReleaseYear(movie.id);
      const genresPromise = getGenres(movie.id);

      return Promise.all([rYearPromise, genresPromise])
        .then(([rYear, movieGenres]) => {
          const slide = document.createElement('div');
          slide.classList.add('swiper-slide');

          if (movie.poster_path) {
            const img = document.createElement('img');
            img.src = `${baseImageUrl}${movie.poster_path}`;

            const textOverlay = document.createElement('div');
            textOverlay.classList.add('slide-text');

            const title = document.createElement('div');
            title.classList.add('title');
            textOverlay.appendChild(title);
            
            const titleP = document.createElement('p');
            titleP.textContent = `${movie.title}(${rYear})`;
            title.appendChild(titleP);

            const genres = document.createElement('div');
            genres.classList.add('genres');
            textOverlay.appendChild(genres);
            
            const genresP = document.createElement('p');
            if (movieGenres) {
              genresP.textContent = `${movieGenres.join(', ')}`;
            }
            genres.appendChild(genresP);
            
            const rank = document.createElement('div');
            rank.classList.add('rank');
            textOverlay.appendChild(rank);
            
            const rankP = document.createElement('p');
            rankP.textContent = `${index + 1}`;
            rank.appendChild(rankP);
            
            slide.appendChild(textOverlay);
            slide.appendChild(img);
            
            slide.addEventListener('click', function(event) {
                event.preventDefault();
                const id = rankedMovies[index].id; // 해당 슬라이드의 영화 ID
                location.href = `/ex/include/subHeader?movieId=${id}`;
            });

            return slide;
          }
        })
        .catch(error => console.error('영화 정보를 가져오는 중 에러 발생:', error));
    }

    // 각 영화 정보를 가져와 swiper에 추가
    Promise.all(rankedMovies.map((movie, index) => fetchMovieInfo(movie, index)))
      .then(slides => {
        slides.forEach(slide => {
          if (slide) {
            swiperWrapper.appendChild(slide);
          }
        });
      })
      .then(() => {
        // Swiper 인스턴스 생성
        const swiper = new Swiper('.ratingSwiper', {
          slidesPerView: '2',
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
          },
        });
      })
      .catch(error => console.error('영화 정보를 가져오는 중 에러 발생:', error));
  })
  .catch(error => console.error('영화 정보를 가져오는 중 에러 발생:', error));