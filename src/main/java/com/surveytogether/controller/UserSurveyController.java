package com.surveytogether.controller;


import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.surveytogether.domain.QuestionDTO;
import com.surveytogether.domain.SurveyDTO;
import com.surveytogether.mapper.SurveyMapper;
import com.surveytogether.service.SurveyService;
import com.surveytogether.util.Method;
import com.surveytogether.util.UiUtils;


@Controller
@RequestMapping("/user")
public class UserSurveyController extends UiUtils {
	
	@Autowired
	SurveyService surveySerivce;
	
	@GetMapping("/mysurvey")
	public String gotoMysurvey() {
		return "/user/mysurvey";
	}
	
	@GetMapping("/surveyform")
	public String gotoSurveyForm() {
		return "/user/surveyform";
	}
	
	
	@PostMapping("/savesurvey")
	public String saveSurvey(@RequestBody SurveyDTO survey,Model model) {
		
		boolean result = surveySerivce.registerSurvey(survey);
		if(result) {
			return showMessageWithRedirect("등록완료", "/user/mysurvey", Method.GET, null, model);
		} else {
			return showMessageWithRedirect("등록실패", "/user/mysurvey", Method.GET, null, model);
		}
	}

}
