package com.surveytogether.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import com.surveytogether.domain.QuestionDTO;
import com.surveytogether.domain.QuestionOptionDTO;
import com.surveytogether.mapper.QuestionMapper;
import com.surveytogether.mapper.QuestionOptionMapper;

@Service
public class QuestionServiceImpl implements QuestionService {

	@Autowired
	QuestionMapper questionMapper;
	
	@Override
	public boolean registerQuestion(QuestionDTO question) {
		
		int queryResult = 0;
		
		if(question.getIdx() == null) {
			// 새로운 질문등록일경우
			queryResult = questionMapper.insertQuestion(question); 	
		}else {
			// 질문수정일 경우 
			queryResult = questionMapper.updateQuestion(question);
		}
		
		return (queryResult==1?true:false);
	}

	@Override
	public boolean deleteQuestion(Long idx) {
		
		int queryResult = 0;
		
		QuestionDTO question = questionMapper.selectQuestionDetail(idx);
		if(question!=null) {
			questionMapper.deleteQuestion(idx);
		}
		return (queryResult==1?true:false);
	}

	@Override
	public List<QuestionDTO> getQuestionList(Long surveyIdx) {
		return questionMapper.selectQuestionList(surveyIdx);
	}

	@Override
	public QuestionDTO getQuestionDetail(Long idx) {
		return questionMapper.selectQuestionDetail(idx);
	}
	
}
