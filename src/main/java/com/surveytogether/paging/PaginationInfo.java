package com.surveytogether.paging;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PaginationInfo {
	private Criteria criteria;
	private int totalRecordCount; // 전체 게시글 수 
	private int totalPageCount; // 전체 페이지 수 
	private int firstPage; // 하단리스트의 첫 페이지 
	private int lastPage; // 하단리스트의 마지막페이지
	private int firstRecordIndex; // 이미 읽어온 게시글을 제외하고 읽어올 첫번째 인덱스
	private boolean hasPreviousPage;
	private boolean hasNextPage;
	
	public PaginationInfo(Criteria criteria) {
		if(criteria.getCurrentPageNo() < 1) {
			criteria.setCurrentPageNo(1);
		}
		if(criteria.getRecordsPerPage() < 1 || criteria.getRecordsPerPage() > 10) {
			criteria.setRecordsPerPage(10);
		}
		if(criteria.getPageSize() < 1 || criteria.getPageSize() > 5) {
			criteria.setPageSize(5);
		}
		this.criteria = criteria;
	}
	
	public void setTotalRecordCount(int totalRecordCount) {
		this.totalRecordCount = totalRecordCount;
		if(totalRecordCount>0) {
			cal();
		}
	}
	
	public void cal() {
		totalPageCount = ((totalRecordCount-1) / criteria.getRecordsPerPage())+1;
		if(criteria.getCurrentPageNo() > totalPageCount) {
			criteria.setCurrentPageNo(totalPageCount);
		}
		firstPage = (criteria.getCurrentPageNo()-1)/criteria.getPageSize()*criteria.getPageSize()+1;
		lastPage = firstPage + criteria.getPageSize() - 1;
		if(lastPage > totalPageCount) {
			lastPage = totalPageCount;
		}
		firstRecordIndex = (criteria.getCurrentPageNo()-1)*criteria.getRecordsPerPage();
		hasPreviousPage = firstPage != 1;
		hasNextPage = lastPage<totalPageCount?true:false;
	}
}
