package com.surveytogether.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.surveytogether.domain.StringAnswerDTO;

@Mapper
public interface StringAnswerMapper {
	public int saveAnswer(StringAnswerDTO answer);
}
