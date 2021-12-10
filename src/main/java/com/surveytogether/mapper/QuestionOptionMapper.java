package com.surveytogether.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.surveytogether.domain.QuestionOptionDTO;

@Mapper
public interface QuestionOptionMapper {
	public int insertQuestionOption(QuestionOptionDTO question);
	public int updateQuestionOption(QuestionOptionDTO question);
	public int deleteQuestionOption(Long idx);
	public List<QuestionOptionDTO> selectQuestionOptionList(Long questionIdx);
	public QuestionOptionDTO selectQuestionOptionDetail(Long idx);
}
