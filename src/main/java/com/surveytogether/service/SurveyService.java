package com.surveytogether.service;

import java.util.List;

import com.surveytogether.domain.QuestionDTO;
import com.surveytogether.domain.SurveyDTO;

public interface SurveyService {
	public boolean registerSurvey(SurveyDTO survey);
	public boolean deleteSurvey(Long idx);
	public SurveyDTO getSurveyDetail(Long idx);
	public List<SurveyDTO> getSurveyList(SurveyDTO survey);
	public List<QuestionDTO> getQuestionList(Long surveyIdx);
}
