package com.surveytogether.domain;

import com.surveytogether.paging.Criteria;
import com.surveytogether.paging.PaginationInfo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CommonDTO extends Criteria {
	private PaginationInfo paginationInfo;
}
