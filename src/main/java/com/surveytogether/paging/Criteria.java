package com.surveytogether.paging;

import java.util.LinkedHashMap;
import java.util.Map;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Criteria {
	private int currentPageNo; // 현재페이지
	private int recordsPerPage; // 페이지당 게시글수
	private int pageSize; // 화면 하단에 표시될 페이지 갯수 
	private String searchKeyword; // 검색키워드
	private String searchType; // 검색유형
	
	public Criteria() {
		this.currentPageNo = 1;
		this.recordsPerPage = 10;
		this.pageSize = 5;
	}
	
	public String makeQueryString(int pageNo) {
		// jsp에서 controller로 전달할때 사용할 메서드 
		UriComponents uriComponents = UriComponentsBuilder.newInstance()
				.queryParam("currentPageNo", pageNo)
				.queryParam("recordsPerPage", recordsPerPage)
				.queryParam("pageSize", pageSize)
				.queryParam("searchType", searchType)
				.queryParam("searchKeyword", searchKeyword)
				.build()
				.encode();
		
		return uriComponents.toUriString();
	}
	
	public Map<String,Object> getPagingParams(Criteria criteria){
		// showMessageWithRedirect시 전달해줄 요소들을 만들어주는 역할
		Map<String,Object> params = new LinkedHashMap<>();
		params.put("currentPageNo", criteria.getCurrentPageNo());
		params.put("recordsPerPage", criteria.getRecordsPerPage());
		params.put("pageSize", criteria.getPageSize());
		params.put("searchType", criteria.getSearchType());
		params.put("searchKeyword", criteria.getSearchKeyword());
		return params;
	}
}
