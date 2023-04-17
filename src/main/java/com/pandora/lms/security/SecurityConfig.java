package com.pandora.lms.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

import com.pandora.lms.service.loginService;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(securedEnabled = true)
public class SecurityConfig extends WebSecurityConfigurerAdapter{
	
	@Autowired
	private loginService loginservice;
	
	@Bean //스프링 시큐리티의 로그인 프로세스에서 반드시 필요로하는 암호화 모듈 
	public PasswordEncoder passwordEncoder() {
		
		return new BCryptPasswordEncoder();
	}
	
	@Override //접속한 유저의 객체를 가지고 와서 userdatas에서 뭔가.. 내부에서 뭔가.. 숙덕숙덕 한 뒤 로그인을 완료해주는 메소드인것 같음
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth.userDetailsService(loginservice);
	}
	
	@Override //각 페이지의 접근을 제어하는 메소드
	protected void configure(HttpSecurity http) throws Exception {
		http.httpBasic().disable();
		http.csrf().disable();
		http.authorizeRequests()
				.antMatchers("/onlyinstr").access("hasRole('ROLE_INSTR') or hasRole('ROLE_ADMIN')")
				.antMatchers("/onlyuser").access("hasRole('ROLE_USER') or hasRole('ROLE_ADMIN')")
				.antMatchers("/onlyadmin").access("hasRole('ROLE_ADMIN')")
				.anyRequest().permitAll();
		http.formLogin()
		.loginPage("/login")//커스텀 로그인 페이지 설정
		.loginProcessingUrl("/login")//로그인 페이지에서 로그인할 때 form action 에 들어갈 주소
		.defaultSuccessUrl("/index")//로그인 성공하면 보여줄 페이지
		.failureUrl("/loginfail")//로그인이 실패하면 보여줄 페이지
		.permitAll() // 커스텀 로그인 페이지를 설정했으니 permitAll 해준다.
		.and()
		.logout()
		.logoutSuccessUrl("/index");
				
	}
}
