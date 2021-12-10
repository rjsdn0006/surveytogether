package com.surveytogether.service;

import java.util.List;

import com.surveytogether.domain.QuestionDTO;

public interface QuestionService {
	public boolean createQuestion(QuestionDTO question);
	public boolean deleteQuestion(Long idx);
	public List<QuestionDTO> selectQuestionList(Long surveyIdx);
	public QuestionDTO selectQuestionDetail(Long idx);
}
