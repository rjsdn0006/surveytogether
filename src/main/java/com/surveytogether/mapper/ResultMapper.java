package com.surveytogether.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.surveytogether.domain.ResultDTO;

@Mapper
public interface ResultMapper {
	public Long findMaxReIdx();
	public int insertResult(ResultDTO Result);
	public ResultDTO selectResult(@Param("surveyIdx") Long surveyIdx,@Param("questionIdx") Long questionIdx);
}
