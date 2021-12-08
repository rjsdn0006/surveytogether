package com.surveytogether.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.surveytogether.domain.UserDTO;
import com.surveytogether.service.UserService;

@Controller
@RequestMapping("")
public class HomeController {
	@Autowired
	UserService userService;
	@Autowired
	PasswordEncoder passwordEncoder;
	
	@GetMapping("/")
	public String home() {
		return "/index";
	}
	
	@GetMapping("/signUp")
	public String gotoSignUp() {
		return "/signup";
	}
	
	@PostMapping("/signUpProcess")
	public String signUpProcess(UserDTO user) {
		boolean result = userService.registerUser(user);
		if(result) {
			System.out.println("등록완료");
		}else {
			System.out.println("등록실패");
		}
		
		return "/index";
	}
}
