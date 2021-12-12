package com.surveytogether.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.surveytogether.domain.QuestionOptionDTO;
import com.surveytogether.mapper.QuestionOptionMapper;

@Service
public class QuestionOptionServiceImpl implements QuestionOptionService {
	@Autowired
	QuestionOptionMapper questionOptionMapper;

	@Override
	public boolean registerQuestionOption(QuestionOptionDTO option) {
		
		int queryResult = 0;
		
		if(option.getIdx() == null) {
			// 새로운 옵션등록일경우
			queryResult = questionOptionMapper.insertQuestionOption(option); 	
		}else {
			// 질문수정일 경우 
			queryResult = questionOptionMapper.updateQuestionOption(option);
		}
		
		return (queryResult==1?true:false);
	}

	@Override
	public boolean deleteQuestionOption(Long idx) {
		
		int queryResult = 0;
		
		QuestionOptionDTO option = questionOptionMapper.selectQuestionOptionDetail(idx);
		if(option!=null) {
			questionOptionMapper.deleteQuestionOption(idx);
		}
		return (queryResult==1?true:false);
	}

	@Override
	public List<QuestionOptionDTO> getQuestionOptionList(Long questionIdx) {
		return questionOptionMapper.selectQuestionOptionList(questionIdx);
	}

	@Override
	public QuestionOptionDTO getQuestionOptionDetail(Long idx) {
		return questionOptionMapper.selectQuestionOptionDetail(idx);
	}
	
	
}
