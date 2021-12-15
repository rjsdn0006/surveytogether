package com.surveytogether.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.surveytogether.domain.SurveyDTO;

@Mapper
public interface SurveyMapper {
	public int insertSurvey(SurveyDTO survey);
	public int updateSurvey(SurveyDTO survey);
	public int deleteSurvey(Long idx);
	public SurveyDTO selectSurveyDetail(Long idx);
	public List<SurveyDTO> selectMySurveyList(SurveyDTO survey);
	public List<SurveyDTO> selectSurveyList(SurveyDTO survey);
	public int selectMySurveyTotalCount(SurveyDTO survey);
	public int selectSurveyTotalCount(SurveyDTO survey);
	
}
