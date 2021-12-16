package com.surveytogether.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AnswerDTO {
	private SelectAnswerDTO selectAnswer;
	private StringAnswerDTO stringAnswer;
}
