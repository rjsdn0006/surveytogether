package com.surveytogether.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class StringAnswerDTO {
	private Long straIdx;
	private Long straQuestionIdx;
	private String straWriter;
	private String straAnswer;
}
