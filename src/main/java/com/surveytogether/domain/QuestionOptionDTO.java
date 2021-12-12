package com.surveytogether.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class QuestionOptionDTO {
	private Long opIdx;
	private Long opQuestionIdx;
	private String opName;
}
