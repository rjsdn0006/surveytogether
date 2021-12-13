package com.surveytogether.service;

import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.surveytogether.domain.SurveyDTO;
import com.surveytogether.mapper.SurveyMapper;

@Service
public class SurveyServiceImpl implements SurveyService {

	@Autowired
	SurveyMapper surveyMapper;
	
	@Override
	public boolean registerSurvey(SurveyDTO survey) {
		int queryResult = 0;
		
		if(survey.getSuIdx()==null) {
			queryResult = surveyMapper.insertSurvey(survey);
		}else {
			queryResult = surveyMapper.updateSurvey(survey);
		}
		return (queryResult==1)?true:false;
	}

	@Override
	public boolean deleteSurvey(Long idx) {
		int queryResult = 0;
		
		SurveyDTO survey = getSurveyDetail(idx);
		if(survey!=null) {
			queryResult = surveyMapper.deleteSurvey(idx);
		}
		return (queryResult==1)?true:false;
	}

	@Override
	public SurveyDTO getSurveyDetail(Long idx) {
		return surveyMapper.selectSurveyDetail(idx);
	}

	@Override
	public List<SurveyDTO> getSurveyList(SurveyDTO survey) {
		List<SurveyDTO> surveyList = Collections.emptyList();
		int count = surveyMapper.selectSurveyTotalCount(survey);
		if(count>0) {
			surveyList = surveyMapper.selectSurveyList(survey);
		}
		return surveyList;
	}

}
