# HUEFLIX
API를 활용한 영화 정보 프로그램으로, 상세한 영화 정보와 평점/댓글 기능을 제공합니다. 랭킹 기능을 통해 인기 있는 영화를 확인하고, 효율적인 검색 서비스를 통해 원하는영화를 쉽게 찾을 수 있습니다.

## 목차
 - [개요](#개요)
 - [프로그램 소개](#프로그램-소개)
 - [기능 소개](#기능-소개)

## 개요
 - 프로젝트 이름: HUEFLIX
 - 프로젝트 기간: 2023.12.04 ~ 2023.12.21
 - 개발 엔진 및 언어: Apache Tomcat, Spring Tool, Oracle, JAVA, jQuery, AJAX, TMDB, KMDB, MyBatis
 - 멤버 및 역할
   - 신민하(조장): API를 활용한 영화상세정보 구현, 게시판 UI/UX 구현, PPT 제작
   - 임지선: API를 활용한 현재상영작/상영예정작 페이지 구현, 메인 UI/UX의 기능 구현, 영화상세정보 메뉴 기능 구현
   - 신수인: 메인 홈페이지 UI/UX 및 로그인/회원가입/회원정보수정 구현, 권한별 기능 구현
   - 이도민: 영화정보 UI 구현, 공지사항 CRUD 구현, RESTful을 활용한 댓글 구현, PPT 제작
   - 심기훈: 영화정보 UI/UX 구현, 공지사항 CRUD 구현, 평점 및 RESTful을 활용한 댓글 구현
   - 김보성: 영화정보 UI/UX 구현, 평점 및 RESTful을 활용한 댓글 구현, 유지/보수 작업
   - 박다진솔: API를 활용한 검색 페이지 구현, 검색 결과에서 영화상세정보로 이동기능 구현
 - 개발 목표: 로그인 없이도 영화 순위와 상세 정보를 손쉽게 확인할 수 있도록 설계하였고, 로그인 시에는 평점/댓글 기능을 추가

## 프로그램 소개
 ### ERD
 ![휴플릭스 프로젝트](https://github.com/jiseon1222/Hueflix/assets/148019130/14d0ca5f-755c-44d1-b2cd-f6cb3b41fa19)

 ### 사이트맵
 ![사이트맵](https://github.com/jiseon1222/Hueflix/assets/148019130/eb7dd29e-3e67-4da8-9be4-938d64a2b4db)

## 기능 소개

### 메인 화면
#### 1. 메인
 API를 활용하여 데이터를 읽어오며, 포스터를 클릭하면 영화 상세 정보 페이지로 이동합니다.
 ![메인](https://github.com/jiseon1222/Hueflix/assets/148019130/8c60475e-cbad-4ee3-8143-bee5f40ac447)
 - 상영작 TOP 10: 스와이프 적용
 - 개봉 예정 신작들
 - 인기작
 - 평점순
#### 2. 회원가입/로그인
 Spring Security를 사용하여 보안을 설정하고 있습니다.
 - 회원가입: 이메일 형식 일치 확인, ID/닉네임 중복 확인, 비밀번호 일치 확인, 모든 항목 입력시 회원가입 버튼 활성화
 ![회원가입](https://github.com/jiseon1222/Hueflix/assets/148019130/8f999c3d-da89-4206-a398-98b3a3610492)
 - 로그인: 권한별 로그인, DB에서 패스워드 암호화
 ```` xml
<!-- BCryptPasswordEncoder 클래스 빈 추가  -->
<beans:bean id="bcryptPasswordEncoder" class="org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder" />
<!-- provider -->
<authentication-manager>
    <authentication-provider>
        <!-- 로그인 시 비밀번호를 암호화해서 DB에서 조회한 비밀번호와 비교 -->
        <password-encoder ref="bcryptPasswordEncoder"/>
            
        <jdbc-user-service
            authorities-by-username-query="select userEmail, authority from authorities where userEmail = ?"
            users-by-username-query="select userEmail, pw, enabled from users where userEmail = ?"
            role-prefix="" data-source-ref="dataSource" />
    </authentication-provider>
</authentication-manager>
 ````
 ![로그인](https://github.com/jiseon1222/Hueflix/assets/148019130/6050d27c-76e2-4286-8e65-0b0245fc2306)
#### 3. 회원 정보 수정
![헤더토글](https://github.com/jiseon1222/Hueflix/assets/148019130/cc8223ff-9ff5-4fba-a622-ece94e69892f)
 - 사용자의 정보를 수정하기 전 비밀번호 검사
 ![정보수정(비밀번호 틀림)](https://github.com/jiseon1222/Hueflix/assets/148019130/1c1c88b7-bbaa-4601-a8ec-acc040ae2b46)
 ![정보수정(비밀번호 입력)](https://github.com/jiseon1222/Hueflix/assets/148019130/2d5c6d33-98de-46f7-99a1-3e8c16f1c923)
 
 - 닉네임/비밀번호 변경 가능, 비밀번호 유효성 검사
 ![회원정보수정 비밀번호(틀림)](https://github.com/jiseon1222/Hueflix/assets/148019130/3b41c7fc-6e01-4c3a-9b8a-e694c0f8d5ff)
 ![회원정보수정 비밀번호(안틀림)](https://github.com/jiseon1222/Hueflix/assets/148019130/25fd5c19-575c-4922-b55b-ebaf88723b4f)

### 현재상영작/개봉예정작
API를 활용하여 데이터를 읽어오며, 포스터를 클릭하면 영화 상세 정보 페이지로 이동합니다. 페이지네이션 사용
![현재상영중](https://github.com/jiseon1222/Hueflix/assets/148019130/61b7c2a0-6869-489b-8413-186bf43cccbb)
![개봉예정](https://github.com/jiseon1222/Hueflix/assets/148019130/5865f790-a23d-4921-b450-28a8a612a786)

### 공지사항
#### 1. 공지사항(사용자)
게시글 읽기와 키워드 검색만 가능, 페이지네이션 사용
![게시판(사용자)](https://github.com/jiseon1222/Hueflix/assets/148019130/9fb19fb2-b6d9-4d61-a512-2819f2d8753b)
![게시판read(사용자)](https://github.com/jiseon1222/Hueflix/assets/148019130/d52744b3-4341-42b9-8305-0ff89d219a09)

#### 2. 공지사항(관리자)
게시글 CRUD와 키워드 검색 가능, 페이지네이션 사용
![게시판(관리자)](https://github.com/jiseon1222/Hueflix/assets/148019130/1319abaa-e41a-4c76-8035-7d2e755c6d80)
![게시판read(관리자)](https://github.com/jiseon1222/Hueflix/assets/148019130/b089ea1a-7542-4e65-b9eb-fb4484e83824)

### 영화상세정보
#### 1. 줄거리
#### 2. 출연진
#### 3. 영상/포토
#### 4. 평점/댓글




