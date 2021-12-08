package com.surveytogether.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.security.core.GrantedAuthority;

import com.surveytogether.domain.UserDTO;

@Mapper
public interface UserMapper {
	public int insertUser(UserDTO user);
	public UserDTO selectUser(String username);
	
	public List<GrantedAuthority> selectAuthorities(String username);
	public int createAuthority(UserDTO user);
}
