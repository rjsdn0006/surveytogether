package com.surveytogether.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import com.surveytogether.domain.AnswerDTO;
import com.surveytogether.domain.QuestionDTO;
import com.surveytogether.domain.QuestionOptionDTO;
import com.surveytogether.domain.SurveyDTO;
import com.surveytogether.mapper.QuestionMapper;
import com.surveytogether.mapper.QuestionOptionMapper;
import com.surveytogether.mapper.SelectAnswerMapper;
import com.surveytogether.mapper.StringAnswerMapper;
import com.surveytogether.mapper.SurveyMapper;
import com.surveytogether.paging.PaginationInfo;

@Service
public class SurveyServiceImpl implements SurveyService {

	@Autowired
	SurveyMapper surveyMapper;
	@Autowired
	QuestionMapper questionMapper;
	@Autowired
	QuestionOptionMapper questionOptionMapper;
	@Autowired
	StringAnswerMapper stringAnswerMapper;
	@Autowired
	SelectAnswerMapper selectAnswerMapper;
	
	@Override
	public boolean registerSurvey(SurveyDTO survey) {
		int queryResult = 0;
		
		List<QuestionDTO> questionList = survey.getQuestionList();
		List<QuestionOptionDTO> questionOptionList = Collections.emptyList();
		
		System.out.println(survey.getSuIdx());
		if(survey.getSuIdx()==null) { // idx가 없으니 새글
			queryResult = surveyMapper.insertSurvey(survey); // 1. survey를 등록해준다. 이때, suIdx값이 survey에 저장된다. (useGeneratedKey 사용했으므로)
			
			for(QuestionDTO q:questionList) { // 2. q에는 QuestionDTO가 저장되어 순서대로 불러와진다. 
				q.setQuSurveyIdx(survey.getSuIdx()); // 3. QuestionDTO가 속한 survey의 idx를 지정해준다. 
				questionMapper.insertQuestion(q); // 4. QuestionDTO를 등록해준다. 이때, quIdx값이 q에 저장된다. (useGeneratedKey 사용했으므로)
				
				if(q.getQuestionOptionList() != null) { // +) 만약, option이 존재하는 질문유형이라면 
					questionOptionList = q.getQuestionOptionList(); // 5. QuestionDTO에서 optionList를 가져온다.
				
					for(QuestionOptionDTO o:questionOptionList) { // 6. o에는 QuestionOptionDTO가 저장되어 순서대로 불러와진다.
						o.setOpQuestionIdx(q.getQuIdx()); // 7. QuestionOptionDTO가 속한 question의 idx를 지정해준다.
						questionOptionMapper.insertQuestionOption(o);
					}
				}
			}
			
		}else {
			/* idx가 있으니 수정작업
			 * survey는 그대로 업데이트만 해주고 question과 option은 다삭제하고 새로등록하는 방식을 사용한다.
			 * 현재 나에게 존재하는 suIdx. 이걸통해서 quesiton을 모두삭제할수있다.
			 * option은 question과 CASCADE 로 연결되어있어 자동삭제된다. 
			 */
			queryResult = surveyMapper.updateSurvey(survey);
			questionMapper.deleteQuestionAll(survey.getSuIdx()); // question과 option 다같이 삭제.
			
			for(QuestionDTO q:questionList) { 
				q.setQuSurveyIdx(survey.getSuIdx());
				questionMapper.insertQuestion(q); 
				
				if(q.getQuestionOptionList() != null) {
					questionOptionList = q.getQuestionOptionList(); 
				
					for(QuestionOptionDTO o:questionOptionList) { 
						o.setOpQuestionIdx(q.getQuIdx());
						questionOptionMapper.insertQuestionOption(o);
					}
				}
			}
			
		}
		return (queryResult==1)?true:false;
	}

	@Override
	public boolean deleteSurvey(Long idx) {
		int queryResult = 0;
		
		SurveyDTO survey = getSurveyDetail(idx);
		if(survey!=null) {
			queryResult = surveyMapper.deleteSurvey(idx);
		}
		return (queryResult==1)?true:false;
	}

	@Override
	public SurveyDTO getSurveyDetail(Long idx) {
		return surveyMapper.selectSurveyDetail(idx);
	}

	@Override
	public List<SurveyDTO> getMySurveyList(SurveyDTO survey) {
		List<SurveyDTO> surveyList = Collections.emptyList();
		int count = surveyMapper.selectMySurveyTotalCount(survey);
		
		PaginationInfo paginationInfo = new PaginationInfo(survey);
		paginationInfo.setTotalRecordCount(count);
		survey.setPaginationInfo(paginationInfo);
		
		
		if(count>0) {
			surveyList = surveyMapper.selectMySurveyList(survey);
		}
		return surveyList;
	}
	@Override
	public List<SurveyDTO> getSurveyList(SurveyDTO survey) {
		List<SurveyDTO> surveyList = Collections.emptyList();
		int count = surveyMapper.selectSurveyTotalCount(survey);
		
		PaginationInfo paginationInfo = new PaginationInfo(survey);
		paginationInfo.setTotalRecordCount(count);
		survey.setPaginationInfo(paginationInfo);
		
		if(count>0) {
			surveyList = surveyMapper.selectSurveyList(survey);
		}
		return surveyList;
	}

	@Override
	public List<QuestionDTO> getQuestionList(Long surveyIdx) {
		List<QuestionDTO> questionList =  questionMapper.selectQuestionList(surveyIdx);
		return questionList;
	}

	@Override
	public List<QuestionOptionDTO> getOptionList(Long questionIdx) {
		List<QuestionOptionDTO> optionList = questionOptionMapper.selectQuestionOptionList(questionIdx);
		return optionList;
	}

	@Override
	public boolean saveAnswer(AnswerDTO answer) {
		int queryResult;
		if(answer.getSelectAnswer().getSelaAnswer()!=null) {
			// selectAnswer이 존재한다면 
			queryResult = selectAnswerMapper.saveAnswer(answer.getSelectAnswer());
		}else if(answer.getStringAnswer().getStraAnswer()!=null) {
			// stringAnswer이 존재한다면
			queryResult = stringAnswerMapper.saveAnswer(answer.getStringAnswer());
		}else {
			queryResult = 0;
		}
		return (queryResult==1)?true:false;
	}

	@Override
	public List<String> getAnswerPeople(Long questionIdx) {
		/* 
		 * tb_string_answer 과 tb_select_answer 테이블에 questionIdx를 전달하여 DISTINCT(writer)를 받아온다. <- List<String> 
		 * 받아온 List<String> 을 순회하며 set<String>에 넣어주어 중복을 제거하고 마지막으로 다시 List로 변환하고 반환해준다.
		 */
		List<String> listA = stringAnswerMapper.selectAnswerPeople(questionIdx);
		List<String> listB = selectAnswerMapper.selectAnswerPeople(questionIdx);

		Set<String> set = new HashSet<>();
		
		if(!listA.isEmpty()) {
			for(String s : listA) {
				set.add(s);
			}
		}
		if(!listB.isEmpty()) {
			for(String s : listB) {
				set.add(s);
			}
		}

		List<String> list = new ArrayList<>();
		list.addAll(set);
		return list;
	}

	@Override
	public List<String> getAnswer(String writer, Long questionIdx) {
		List<String> listA = stringAnswerMapper.selectAnswer(writer,questionIdx);
		List<String> listB = selectAnswerMapper.selectAnswer(writer,questionIdx);
		List<String> list = new ArrayList<String>();
		list.addAll(listA);
		list.addAll(listB);
		
		return list;
	}


}
