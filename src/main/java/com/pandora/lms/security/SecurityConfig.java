package com.pandora.lms.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.web.servlet.ServletListenerRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.session.HttpSessionEventPublisher;

import com.pandora.lms.service.LoginService;

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {
	@Autowired
	private AuthenticationSuccessHandler authenticationSuccessHandler;

    @Autowired
    private LoginService loginService;

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
        	.antMatchers("/register").permitAll()
            .anyRequest().permitAll()
            .and()
            .formLogin()
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
    
    @Bean
    public ServletListenerRegistrationBean<HttpSessionEventPublisher> httpSessionEventPublisher() {
      return new ServletListenerRegistrationBean<>(new HttpSessionEventPublisher());
    }
    @Autowired
    public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(loginService);
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}
