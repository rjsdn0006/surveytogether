package com.surveytogether.controller;


import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.surveytogether.domain.SurveyDTO;


@Controller
@RequestMapping("/user")
public class UserSurveyController {
	
	@GetMapping("/mysurvey")
	public String gotoMysurvey() {
		return "/user/mysurvey";
	}
	
	@GetMapping("/surveyform")
	public String gotoSurveyForm() {
		return "/user/surveyform";
	}
	
	@PostMapping("/savesurvey")
	public String saveSurvey(@RequestBody Map<String,Object> params) {
		
		// survey의 데이터가 잘 전달되었는지를 확인 
		@SuppressWarnings("unchecked")
		Map<String, String> survey = (Map<String,String>) params.get("survey");
		String suTitle = survey.get("suTitle");
		String suDesc = survey.get("suDesc");
		System.out.println(suTitle);
		System.out.println(suDesc);
		

		return "/user/mysurvey";
	}

}
