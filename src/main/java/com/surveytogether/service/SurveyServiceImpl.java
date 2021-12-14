package com.surveytogether.service;

import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.surveytogether.domain.QuestionDTO;
import com.surveytogether.domain.QuestionOptionDTO;
import com.surveytogether.domain.SurveyDTO;
import com.surveytogether.mapper.QuestionMapper;
import com.surveytogether.mapper.QuestionOptionMapper;
import com.surveytogether.mapper.SurveyMapper;

@Service
public class SurveyServiceImpl implements SurveyService {

	@Autowired
	SurveyMapper surveyMapper;
	@Autowired
	QuestionMapper questionMapper;
	@Autowired
	QuestionOptionMapper questionOptionMapper;
	
	@Override
	public boolean registerSurvey(SurveyDTO survey) {
		int queryResult = 0;
		
		List<QuestionDTO> questionList = survey.getQuestionList();
		List<QuestionOptionDTO> questionOptionList = Collections.emptyList();
		
				
		if(survey.getSuIdx()==null) { // idx가 없으니 새글
			queryResult = surveyMapper.insertSurvey(survey); // 1. survey를 등록해준다. 이때, suIdx값이 survey에 저장된다. (useGeneratedKey 사용했으므로)
			
			for(QuestionDTO q:questionList) { // 2. q에는 QuestionDTO가 저장되어 순서대로 불러와진다. 
				q.setQuSurveyIdx(survey.getSuIdx()); // 3. QuestionDTO가 속한 survey의 idx를 지정해준다. 
				questionMapper.insertQuestion(q); // 4. QuestionDTO를 등록해준다. 이때, quIdx값이 q에 저장된다. (useGeneratedKey 사용했으므로)
				
				if(q.getQuestionOptionList() != null) { // +) 만약, option이 존재하는 질문유형이라면 
					questionOptionList = q.getQuestionOptionList(); // 5. QuestionDTO에서 optionList를 가져온다.
				
					for(QuestionOptionDTO o:questionOptionList) { // 6. o에는 QuestionOptionDTO가 저장되어 순서대로 불러와진다.
						o.setOpQuestionIdx(q.getQuIdx()); // 7. QuestionOptionDTO가 속한 question의 idx를 지정해준다.
						questionOptionMapper.insertQuestionOption(o);
					}
				}
			}
			
		}else {
			// idx가 있으니 수정
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

	@Override
	public List<QuestionDTO> getQuestionList(Long surveyIdx) {
		List<QuestionDTO> questionList =  questionMapper.selectQuestionList(surveyIdx);
		return questionList;
	}

}
