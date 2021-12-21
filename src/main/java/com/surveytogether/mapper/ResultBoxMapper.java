package com.surveytogether.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.surveytogether.domain.ResultBoxDTO;

@Mapper
public interface ResultBoxMapper {
	public List<ResultBoxDTO> selectResultBox(Long quIdx);
}
