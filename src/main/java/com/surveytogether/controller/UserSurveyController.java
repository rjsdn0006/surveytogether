package com.surveytogether.controller;


import java.security.Principal;
import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.surveytogether.domain.AnswerDTO;
import com.surveytogether.domain.QuestionDTO;
import com.surveytogether.domain.QuestionOptionDTO;
import com.surveytogether.domain.SurveyDTO;
import com.surveytogether.service.SurveyService;
import com.surveytogether.util.UiUtils;


@Controller
@RequestMapping("/user")
public class UserSurveyController extends UiUtils {
	
	@Autowired
	SurveyService surveyService;
	
	// mysurvey 영역 --------------------------------------------------------------
	
	@GetMapping("/mysurvey")
	public String gotoMysurvey(SurveyDTO survey,Model model,Principal principal) {
	
		if(survey.getSuWriter() == null) {
			// 나의 survey 페이지 이므로, 내가작성한 survey만 보여야한다.
			survey.setSuWriter(principal.getName());
		}
		List<SurveyDTO> surveyList = surveyService.getMySurveyList(survey);
		/* 
		 * surveyList를 가져올때 SurveyDTO 객체를 넣어주는 이유
		 * pagination 정보 혹은 검색정보에 따라 보여지는 리스트가 달라지기 때문에 
		 * 해당 정보를 가진 SurveyDTO 객체를 통으로 넘겨줘서 처리한다. 
		 */
		model.addAttribute("surveyList",surveyList);
		model.addAttribute("survey",survey);
		return "/user/mysurvey";
	}
	
	@GetMapping("/surveyform")
	public String gotoSurveyForm() {
		return "/user/surveyform";
	}
	
	@GetMapping("surveyedit")
	public String gotoSurveyEditForm(@RequestParam("suIdx") Long suIdx,Model model) {
		// surveyform에 함께 구현도 가능하지만 페이징까지 들어가면 코드가 너무 지저분해져서 따로구현
		SurveyDTO survey = surveyService.getSurveyDetail(suIdx);
		model.addAttribute("survey",survey);
		return "/user/surveyedit";
	}
	
	@PostMapping("/savesurvey")
	public String saveSurvey(@RequestBody SurveyDTO survey,Model model) {
		surveyService.registerSurvey(survey);
		return "/user/mysurvey"; // 실질적으로 이코드는 동작하지않고 ajax에서 전달하는 링크로 이동한다.
	}
	
	@GetMapping("/loadquestion")
	public String loadQuestion(Long suIdx, @RequestParam(value="state", required = false)String state, Model model) {
		/*
		 * ajax에서 suIdx를 전달해주면 questionList를 가져와 question.jsp에 보내준다.
		 * question.jsp는 이를 토대로 문서를 만들고 그걸 그대로 다시 ajax로 반환해준다.
		 * ajax는 반환된 문서를 자신의 문서에 끼워넣으면 된다. 
		 */
		List<QuestionDTO> questionList = surveyService.getQuestionList(suIdx);
		if(state!=null && state!="") {
			// 만약 state가 존재한다면, 다른사람이 설문조사에 참여하는 경우이다.
			model.addAttribute("state",state);
		}
		model.addAttribute("questionList",questionList);
		return "/user/question";
	}
	
	@GetMapping("/loadoption")
	public String loadOption (Long quIdx,String quFormat, @RequestParam(value="state", required = false)String state, Model model) {
		List<QuestionOptionDTO> optionList = surveyService.getOptionList(quIdx);
		if(state!=null && state!="") {
			model.addAttribute("state",state);
			model.addAttribute("questionIdx",quIdx);
			/*
			 * 다른사람이 참여하는 형식이라면 question당 option의 name을 묶어줄요소가 필요하다.
			 * ( radio 같은경우 name을 기준으로 하나만 선택이 되므로 )
			 * 이때 사용하기위해 quIdx를 보내준다.
			 */
		}
		model.addAttribute("optionList",optionList);
		model.addAttribute("quFormat",quFormat);
		return "/user/option";
	}
	
	// mysurvey - answer 영역 --------------------------------------------------------
	@GetMapping("/answerlist")
	public String gotoAnswerList(@RequestParam("suIdx")Long suIdx, Model model) {
		List<QuestionDTO> questionList = surveyService.getQuestionList(suIdx);
		
		if(!questionList.isEmpty()) {
			List<String> answerPeople = surveyService.getAnswerPeople(questionList.get(0).getQuIdx());
			model.addAttribute("answerPeople",answerPeople);
			model.addAttribute("suIdx",suIdx);
		}
		
		return "/user/answerlist";
	}
	
	@GetMapping("/answer")
	public String gotoAnswer(@RequestParam("suIdx")Long suIdx, @RequestParam("writer") String writer,Model model) {
		SurveyDTO survey = surveyService.getSurveyDetail(suIdx);
		List<QuestionDTO> questionList = surveyService.getQuestionList(suIdx);
		
		model.addAttribute("questionList",questionList);
		model.addAttribute("survey",survey);
		model.addAttribute("writer",writer);
		
		return "/user/answer";
	}
	
	@GetMapping("/getanswer")
	@ResponseBody
	public List<String> getAnswer(String writer,Long quIdx) {
		List<String> answer = surveyService.getAnswer(writer, quIdx);
		return answer;
	}
	
	
	// surveyboard 영역 --------------------------------------------------------------
	@GetMapping("/surveyboard")
	public String gotoSurveyBoard(SurveyDTO survey,Model model) {
		List<SurveyDTO> surveyList = surveyService.getSurveyList(survey);
		model.addAttribute("surveyList",surveyList);
		return "/user/surveyboard";
	}
	
	@GetMapping("/surveydo")
	public String gotoSurveyDo(@RequestParam("suIdx") Long suIdx,Model model) {
		SurveyDTO survey = surveyService.getSurveyDetail(suIdx);
		model.addAttribute("survey",survey);
		return "/user/surveydo";
	}
	
	@PostMapping("/saveanswer")
	public String saveAnswer(@RequestBody AnswerDTO answer,Model model) {
		surveyService.saveAnswer(answer);
		return "/user/surveyboard";
	}
	
	@GetMapping("/checkanswer") // 이미참여한 설문조사는 참여할수 없음
	@ResponseBody
	public boolean checkAlreadyAnswer(Long suIdx,String writer, Model model) {
		boolean result = false;
		
		List<QuestionDTO> questionList = surveyService.getQuestionList(suIdx);
		List<String> answerPeople = Collections.emptyList();
		
		if(!questionList.isEmpty()) {
			answerPeople = surveyService.getAnswerPeople(questionList.get(0).getQuIdx());
		}
		if(!answerPeople.isEmpty()) {
			for(String person: answerPeople) {
				if(person.equals(writer)) {
					result = true;
				}
			}
		}
		
		return result;
	}
	
}
