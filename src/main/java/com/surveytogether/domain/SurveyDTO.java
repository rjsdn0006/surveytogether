package com.surveytogether.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SurveyDTO {
	private Long idx;
	private String writer;
	private String title;
	private String desc;
	private String createTime;
	private String updateTime;
}
