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
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import com.pandora.lms.service.AdminLoginService;
import com.pandora.lms.service.LoginService;

@Configuration
@EnableWebSecurity
@Order(1)
public class SecurityConfig extends WebSecurityConfigurerAdapter {
	
	@Autowired
	private AuthenticationSuccessHandler authenticationSuccessHandler;
	
//	@Autowired
//	private LoginService LoginService;
    
	@Autowired
	private LoginService LoginService;
	
//    @Bean
//    public UserDetailsService AdminLoginService() {return new AdminLoginService();} 
//    

//    
//    @Bean
//	public DaoAuthenticationProvider authenticationProvider1() {
//		DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
//		authProvider.setUserDetailsService(AdminLoginService());
//		authProvider.setPasswordEncoder(passwordEncoder());
//
//		return authProvider;
//	}
//  @Bean
//  public ServletListenerRegistrationBean<HttpSessionEventPublisher> httpSessionEventPublisher() {
//    return new ServletListenerRegistrationBean<>(new HttpSessionEventPublisher());
//  }
	
	
	@Autowired
	public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
		auth.userDetailsService(LoginService);
	}
	  
    @Override
    protected void configure(HttpSecurity http) throws Exception {
    	http.authorizeRequests().antMatchers("/").permitAll();
    	http.csrf().disable();
        http.antMatcher("/admin/**").authorizeRequests()
        	.antMatchers("/css/**").permitAll()
        	.antMatchers("/scss/**").permitAll()
        	.antMatchers("/vendor/**").permitAll()
        	.antMatchers("/js/**").permitAll()
        	.antMatchers("/img/**").permitAll()
        	.antMatchers("/join").permitAll()
        	.antMatchers("/resources/**").permitAll()
            .anyRequest().hasAnyAuthority("30");

        http.formLogin()
            .loginPage("/admin/login")
            .usernameParameter("id")
            .passwordParameter("pw")
            .loginProcessingUrl("/admin/loginaction")
            .defaultSuccessUrl("/admin/page1")
            .permitAll();

        
            http
            .sessionManagement()
            .sessionFixation().changeSessionId()
            .maximumSessions(1)
            .expiredUrl("/admin/login")
            .maxSessionsPreventsLogin(true);
            
            
            http
            .logout()
            .logoutSuccessUrl("/admin/login")
            .invalidateHttpSession(true)
            .clearAuthentication(true)
            .permitAll();
            
    }
    

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }




}
