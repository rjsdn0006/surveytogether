package com.surveytogether.mapper;

import java.util.List;
import java.util.Set;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.surveytogether.domain.SelectAnswerDTO;


@Mapper
public interface SelectAnswerMapper {
	public int saveAnswer(SelectAnswerDTO answer);
	public List<String> selectAnswerPeople(Long questionIdx);
	public List<String> selectAnswer(@Param("writer") String writer,@Param("questionIdx") Long questionIdx);
}
