package com.surveytogether.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.surveytogether.domain.SelectAnswerDTO;


@Mapper
public interface SelectAnswerMapper {
	public int saveAnswer(SelectAnswerDTO answer);
}
