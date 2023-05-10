package com.pandora.lms.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.web.servlet.ServletListenerRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.security.core.session.SessionRegistryImpl;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.session.HttpSessionEventPublisher;

import com.pandora.lms.service.LoginService;

@Configuration
@Order(1)
public class SecurityConfig {
	
	@Autowired
	private AuthenticationSuccessHandler authenticationSuccessHandler;

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
	  
    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
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
            .successHandler(authenticationSuccessHandler)
            .permitAll();
            
        http
        .sessionManagement()
        .maximumSessions(1)
        .maxSessionsPreventsLogin(true)
        .sessionRegistry(adminsessionRegistry());
            
        http
            .logout()
            .logoutUrl("/admin/logout")
            .invalidateHttpSession(true)
            .clearAuthentication(true)
            .logoutSuccessUrl("/admin/login")
            .permitAll();
			return http.build();
            
    }
    

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
	public SessionRegistry adminsessionRegistry() {
		return new SessionRegistryImpl();
	}
	
	@Bean
	public static ServletListenerRegistrationBean httpSessionEventPulisher() {
		return new ServletListenerRegistrationBean(new HttpSessionEventPublisher());
	}
	


}
