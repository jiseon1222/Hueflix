package com.human.vo;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

public class PageMaker {

	// category

	private int page = 1; // 현재 페이지
	private int perPageNum = 10; // 페이지 당 데이터 개수
	private String searchType; // 검색할 컬럼
	private String keyword; // 검색내용

	private int totalCount; // 전체 데이터 개수 계산: 전체 데이터 totalcount 53, perPageNum=10. 53/10 = 5.3 소수점 지우면 5 +1
							// =6page
	private int totalStartPage = 1;
	private int totalEndPage;
	private int startPage;
	private int endPage;
	private boolean prev; // 이전 페이지 번호 목록 이름
	private boolean next; // 다음 페이지 번호 목록 이름
	private int displayPageNum = 10; // 사용자에게 제공하는 화면에서 보여줄 페이지 개수
	private String bGroupKind;
	private String categoryType;

	private int movieId;

	public int getMovieId() {
		return movieId;
	}

	public void setMovieId(int movieId) {
		this.movieId = movieId;
	}

	public String getCategoryType() {
		return categoryType;
	}

	public void setCategoryType(String categoryType) {
		this.categoryType = categoryType;
	}

	public String getbGroupKind() {
		return bGroupKind;
	}

	public void setbGroupKind(String bGroupKind) {
		this.bGroupKind = bGroupKind;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		if (page <= 0) {
			page = 1;
		}
		this.page = page;
	}

	public int getPerPageNum() {
		return perPageNum;
	}

	public void setPerPageNum(int perPageNum) {
		if (perPageNum <= 0 || perPageNum > 100) {
			perPageNum = 10;
		}
		this.perPageNum = perPageNum;
	}

	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		calcData();
	}

	public int getTotalStartPage() {
		return totalStartPage;
	}

	public void setTotalStartPage(int totalStartPage) {
		this.totalStartPage = totalStartPage;
	}

	public int getTotalEndPage() {
		return totalEndPage;
	}

	public void setTotalEndPage(int totalEndPage) {
		this.totalEndPage = totalEndPage;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public boolean isPrev() {
		return prev;
	}

	public void setPrev(boolean prev) {
		this.prev = prev;
	}

	public boolean isNext() {
		return next;
	}

	public void setNext(boolean next) {
		this.next = next;
	}

	public int getDisplayPageNum() {
		return displayPageNum;
	}

	public void setDisplayPageNum(int displayPageNum) {
		this.displayPageNum = displayPageNum;
	}

	@Override
	public String toString() {
		return "PageMaker [page=" + page + ", perPageNum=" + perPageNum + ", searchType=" + searchType + ", keyword="
				+ keyword + ", totalCount=" + totalCount + ", totalStartPage=" + totalStartPage + ", totalEndPage="
				+ totalEndPage + ", startPage=" + startPage + ", endPage=" + endPage + ", prev=" + prev + ", next="
				+ next + ", displayPageNum=" + displayPageNum + ", movieId=" + movieId + ", categoryType="
				+ categoryType + "]";
	}

	private void calcData() {
		totalStartPage = 1;
		// ceil 올림 floor 내림 round 반올림
		totalEndPage = (int) Math.ceil(totalCount / (double) perPageNum);
		endPage = (int) (Math.ceil(page / (double) displayPageNum) * displayPageNum);
		// 페이지번호를 표시할 범위의 시작페이지를 계산
		startPage = endPage - displayPageNum + 1;
		// endPage가 totalEndPage보다 초과하면 endPage를 totalEndPage로 설정
		if (totalEndPage < endPage) {
			endPage = totalEndPage;
		}

		if (startPage < 1) {
			startPage = 1;
		}
		// 시작페이지 1이면 이전 페이지로 갈 수 없음
		if (startPage == 1) {
			prev = false;
		} else {
			prev = true;
		}

		if (endPage == totalEndPage) {
			next = false;
		} else {
			next = true;
		}
	}

	public String makeSearch() {
		UriComponents u = UriComponentsBuilder.newInstance().queryParam("page", page)
				.queryParam("bGroupKind", bGroupKind)
				.queryParam("page", page)
				.queryParam("perPageNum", perPageNum)
				.queryParam("searchType", searchType)
				.queryParam("keyword", keyword).build();
		return u.toUriString();
	}

	public String makeSearch(int page) {
		UriComponents u = UriComponentsBuilder.newInstance().queryParam("page", page)
				.queryParam("bGroupKind", bGroupKind)
				.queryParam("page", page)
				.queryParam("perPageNum", perPageNum)
				.queryParam("searchType", searchType)
				.queryParam("keyword", keyword).build();
		return u.toUriString();
	}

	public String makePage(int page) {
		UriComponents u = UriComponentsBuilder.newInstance().queryParam("movieId", movieId).queryParam("page", page)
				.queryParam("bGroupKind", bGroupKind)
				.queryParam("page", page)
				.queryParam("perPageNum", perPageNum).build();
		return u.toUriString();
	}
}
