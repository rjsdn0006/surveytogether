package com.surveytogether.service;

import java.util.List;

import com.surveytogether.domain.QuestionDTO;
import com.surveytogether.domain.QuestionOptionDTO;

public interface QuestionService {
	public boolean registerQuestion(QuestionDTO question);
	public boolean deleteQuestion(Long idx);
	public List<QuestionDTO> getQuestionList(Long surveyIdx);
	public QuestionDTO getQuestionDetail(Long idx);
}
