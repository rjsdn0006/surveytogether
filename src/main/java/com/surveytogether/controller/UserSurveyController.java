package com.surveytogether.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

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
}
