package com.surveytogether.service;

import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetailsService;

import com.surveytogether.domain.UserDTO;

public interface UserService extends UserDetailsService {
	public boolean registerUser(UserDTO user);
	public UserDTO getUser(String username);
	
	public List<GrantedAuthority> getAuthorities(String username);
	public boolean createAuthority(UserDTO user);
}
