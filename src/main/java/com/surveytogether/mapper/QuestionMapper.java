package com.surveytogether.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.surveytogether.domain.QuestionDTO;

@Mapper
public interface QuestionMapper {
	public int insertQuestion(QuestionDTO question);
	public int updateQuestion(QuestionDTO question);
	public int deleteQuestion(Long idx);
	public List<QuestionDTO> selectQuestionList(Long surveyIdx);
	public QuestionDTO selectQuestionDetail(Long idx);
}
