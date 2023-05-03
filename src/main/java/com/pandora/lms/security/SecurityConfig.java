package com.pandora.lms.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.web.servlet.ServletListenerRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.session.HttpSessionEventPublisher;
import com.pandora.lms.security.*;

@Configuration
@EnableWebSecurity
public class SecurityConfig{
	


	@Autowired
	private AuthenticationProviderConfig providerConfig;
	
	@Bean
    public ServletListenerRegistrationBean<HttpSessionEventPublisher> httpSessionEventPublisher() {
      return new ServletListenerRegistrationBean<>(new HttpSessionEventPublisher());
    }
    
    @Autowired
    public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
         auth.authenticationProvider(providerConfig.userAuthProvider())
         	.authenticationProvider(providerConfig.adminAuthProvider());
    }

    @Bean
    public PasswordEncoder PasswordEncoder() {
        return new BCryptPasswordEncoder();
    }



    @Configuration
    @Order(1)
    public static class App1ConfigurationAdapter {
    	@Autowired
    	private AuthenticationSuccessHandler authenticationSuccessHandler;
    	
	    @Bean
	    public SecurityFilterChain filterChainApp1(HttpSecurity http) throws Exception {
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
	            .loginPage("/user/login")
	            .usernameParameter("id")
	            .passwordParameter("pw")
	            .loginProcessingUrl("/login")
	            .successHandler(authenticationSuccessHandler)

	            .permitAll();
        
	            http
	            .sessionManagement()
	            .sessionFixation().changeSessionId()
	            .maximumSessions(1)
	            .expiredUrl("/user/login")
	            .maxSessionsPreventsLogin(true);
	            
	            
	            http
	            .logout()
	            .logoutSuccessUrl("/user/login")
	            .invalidateHttpSession(true)
	            .clearAuthentication(true)
	            .permitAll();
				return http.build();
	            
	    }
    }
    
    @Configuration
    @Order(2)
    public static class App2ConfigurationAdapter {
    	
	    @Bean
	    public SecurityFilterChain filterChainApp2(HttpSecurity http) throws Exception {
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
	            .loginPage("/admin/login")
	            .usernameParameter("id")
	            .passwordParameter("pw")
	            .loginProcessingUrl("/adminlogin")
	            .defaultSuccessUrl("/admin")
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
				return http.build();
	            
	    }
    }
    
    

}
