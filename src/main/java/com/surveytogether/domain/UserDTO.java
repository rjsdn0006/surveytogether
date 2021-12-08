package com.surveytogether.domain;

import java.time.LocalDateTime;
import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class UserDTO implements UserDetails{
	private static final long serialVersionUID = 1L;
	
	private String username; // DB에는 id로 되어있다.
	private String password;
	private String name;
	private String registerDate;
	
	private boolean isAccountNonExpired;
	private boolean isAccountNonLocked;
	private boolean isCredentialsNonExpired;
	private boolean isEnabled;
	private String auth;
	private Collection<? extends GrantedAuthority> authorities;
}
