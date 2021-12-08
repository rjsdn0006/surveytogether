package com.surveytogether.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.surveytogether.domain.UserDTO;
import com.surveytogether.mapper.UserMapper;

@Service
public class UserServiceImpl implements UserService{

	@Autowired
	UserMapper userMapper;
	
	@Autowired
	@Lazy
	PasswordEncoder passwordEncoder;
	/*private PasswordEncoder passwordEncoder;
	Autowired
	public void setPasswordEncoder(PasswordEncoder passwordEncoder) {
		this.passwordEncoder = passwordEncoder;
	}*/
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		UserDTO user = userMapper.selectUser(username);
		user.setAuthorities(getAuthorities(username));
		return user;
	}

	@Override
	public boolean registerUser(UserDTO user) {
		int queryResult = 0;
		
		String encodePassword = passwordEncoder.encode(user.getPassword());
		user.setPassword(encodePassword);
		user.setAccountNonExpired(true);
		user.setAccountNonLocked(true);
		user.setCredentialsNonExpired(true);
		user.setEnabled(true);
		
		queryResult = userMapper.insertUser(user);
		
		user.setAuthorities(AuthorityUtils.createAuthorityList("ROLE_USER"));
		createAuthority(user);
		
		return (queryResult==1)?true:false;
	}

	@Override
	public UserDTO getUser(String username) {
		return userMapper.selectUser(username);
	}

	@Override
	public List<GrantedAuthority> getAuthorities(String username) {
		return userMapper.selectAuthorities(username);
	}

	@Override
	public boolean createAuthority(UserDTO user) {
		int queryResult = 0;
		queryResult = userMapper.createAuthority(user);
		return (queryResult==1)?true:false;
	}

}
