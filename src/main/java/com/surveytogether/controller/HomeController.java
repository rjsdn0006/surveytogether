package com.surveytogether.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.surveytogether.domain.UserDTO;
import com.surveytogether.service.UserService;
import com.surveytogether.util.Method;
import com.surveytogether.util.UiUtils;

@Controller
@RequestMapping("")
public class HomeController extends UiUtils {
	@Autowired
	UserService userService;
	@Autowired
	PasswordEncoder passwordEncoder;
	
	@GetMapping("/")
	public String gotoLoginPage() {
		return "/index";
	}
	
	@GetMapping("/signup")
	public String gotoSignUp() {
		return "/signup";
	}
	
	@PostMapping("/signupProcess")
	public String signupProcess(UserDTO user,Model model) {
		
		boolean result = userService.registerUser(user);

		if(result) {
			return showMessageWithRedirect("가입완료", "/", Method.GET, null, model);
		}else {
			return showMessageWithRedirect("가입실패", "/", Method.GET, null, model);
		}
	}
	
	@GetMapping("/home")
	public String gotoHome() {
		return "/user/home";
	}
}
