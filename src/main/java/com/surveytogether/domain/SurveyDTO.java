package com.surveytogether.domain;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SurveyDTO {
	private Long suIdx;
	private String suWriter;
	private String suTitle;
	private String suDesc;
	private String suCreateTime;
	private String suUpdateTime;
	private List<QuestionDTO> questionList;
}
