package com.surveytogether.mapper;

import java.util.List;
import java.util.Set;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.surveytogether.domain.StringAnswerDTO;

@Mapper
public interface StringAnswerMapper {
	public int saveAnswer(StringAnswerDTO answer);
	public List<String> selectAnswerPeople(Long questionIdx);
	public List<String> selectAnswer(@Param("writer") String writer,@Param("questionIdx") Long questionIdx);
}
