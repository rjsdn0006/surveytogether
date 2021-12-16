package com.surveytogether.domain;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SelectAnswerDTO {
	private Long selaIdx;
	private Long selaQuestionIdx;
	private String selaWriter;
	private List<String> selaAnswer;
}
