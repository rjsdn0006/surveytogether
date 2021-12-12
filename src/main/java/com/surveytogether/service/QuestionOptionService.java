package com.surveytogether.service;

import java.util.List;

import com.surveytogether.domain.QuestionOptionDTO;

public interface QuestionOptionService {
	public boolean registerQuestionOption(QuestionOptionDTO option);
	public boolean deleteQuestionOption(Long idx);
	public List<QuestionOptionDTO> getQuestionOptionList(Long questionIdx);
	public QuestionOptionDTO getQuestionOptionDetail(Long idx);
}
