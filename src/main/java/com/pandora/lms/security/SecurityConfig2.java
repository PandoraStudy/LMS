package com.pandora.lms.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.NoOpPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import com.pandora.lms.service.AdminLoginService;
import com.pandora.lms.service.LoginService;

@Configuration
@EnableWebSecurity
@Order(2)
public class SecurityConfig2 extends WebSecurityConfigurerAdapter {
	
	
	
	@Autowired
	private AuthenticationSuccessHandler authenticationSuccessHandler;
	
//	@Autowired
//	private LoginService loginService;
//	
//    
//	@Autowired
//	public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
//	     auth.userDetailsService(loginService);
//	}
//	
//    @Bean
//    public UserDetailsService LoginService() {return new LoginService();} 
//    
//	@Bean
//	public PasswordEncoder passwordEncoder2() {
//		return new BCryptPasswordEncoder();
//	}
//
//	@Bean
//	public DaoAuthenticationProvider authenticationProvider2() {
//		DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
//		authProvider.setUserDetailsService(LoginService());
//		authProvider.setPasswordEncoder(passwordEncoder2());
//
//		return authProvider;
//	}

    @Override
    protected void configure(HttpSecurity http) throws Exception {
    	
    	http.csrf().disable();
        http.authorizeRequests()
        	.antMatchers("/css/**").permitAll()
        	.antMatchers("/scss/**").permitAll()
        	.antMatchers("/vendor/**").permitAll()
        	.antMatchers("/js/**").permitAll()
        	.antMatchers("/img/**").permitAll()
        	.antMatchers("/join").permitAll()
        	.antMatchers("/resources/**").permitAll()
            .anyRequest().authenticated();

        http.formLogin()
            .loginPage("/login")
            .usernameParameter("id")
            .passwordParameter("pw")
            .loginProcessingUrl("/login")
            .successHandler(authenticationSuccessHandler)
            .permitAll();

        
            http
            .sessionManagement()
            .sessionFixation().changeSessionId()
            .maximumSessions(1)
            .expiredUrl("/login")
            .maxSessionsPreventsLogin(true);
            
            
            http
            .logout()
            .logoutSuccessUrl("/login")
            .invalidateHttpSession(true)
            .clearAuthentication(true)
            .permitAll();
            
    }

}
