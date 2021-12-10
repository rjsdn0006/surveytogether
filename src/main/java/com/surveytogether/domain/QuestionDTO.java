package com.surveytogether.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class QuestionDTO {
	private Long idx;
	private Long surveyIdx;
	private String title;
	private String format;
}
