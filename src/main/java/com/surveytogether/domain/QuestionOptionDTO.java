package com.surveytogether.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class QuestionOptionDTO {
	private Long idx;
	private Long questionIdx;
	private String name;
}
