package com.surveytogether.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.surveytogether.domain.ResultDTO;

@Mapper
public interface ResultMapper {
	public int insertResult(ResultDTO Result);
	public ResultDTO selectResult(Long surveyIdx, Long questionIdx);
}
