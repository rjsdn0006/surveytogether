package com.surveytogether.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class QuestionDTO {
	private Long quIdx;
	private Long quSurveyIdx;
	private String quTitle;
	private String quFormat;
}
