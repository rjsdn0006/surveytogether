package com.surveytogether.service;

import java.util.List;

import com.surveytogether.domain.AnswerDTO;
import com.surveytogether.domain.QuestionDTO;
import com.surveytogether.domain.QuestionOptionDTO;
import com.surveytogether.domain.ResultBoxDTO;
import com.surveytogether.domain.ResultDTO;
import com.surveytogether.domain.SurveyDTO;

public interface SurveyService {
	public boolean registerSurvey(SurveyDTO survey);
	public boolean deleteSurvey(Long idx);
	public SurveyDTO getSurveyDetail(Long idx);
	public List<SurveyDTO> getMySurveyList(SurveyDTO survey);
	public List<SurveyDTO> getSurveyList(SurveyDTO survey);
	public List<QuestionDTO> getQuestionList(Long surveyIdx);
	public List<QuestionOptionDTO> getOptionList(Long questionIdx);
	public boolean saveAnswer(AnswerDTO answer);
	public List<String> getAnswerPeople(Long questionIdx);
	public List<String> getAnswer(String writer, Long questionIdx);
	public void insertResult(ResultDTO result);
	public List<ResultBoxDTO> getResultBox(Long quIdx);
}
