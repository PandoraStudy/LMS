package com.pandora.lms.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.web.servlet.ServletListenerRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.security.core.session.SessionRegistryImpl;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.session.HttpSessionEventPublisher;

@Configuration
@EnableWebSecurity
@Order(2)
public class SecurityConfig2 {

	@Autowired
	private AuthenticationSuccessHandler authenticationSuccessHandler;

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

	@Bean
    public SecurityFilterChain mainfilterChain(HttpSecurity http) throws Exception {
    	
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
            .failureUrl("/loginfail")
            .successHandler(authenticationSuccessHandler)
            .permitAll();

        
            http
            .sessionManagement()
            .maximumSessions(1)
            .maxSessionsPreventsLogin(true)
            .sessionRegistry(sessionRegistry());
            
            
            http
            .logout()
            .logoutSuccessUrl("/login")
            .invalidateHttpSession(true)
            .clearAuthentication(true)
            .permitAll();
            
			return http.build();
            
    }
	
	@Bean
	public SessionRegistry sessionRegistry() {
		return new SessionRegistryImpl();
	}
	
	
}
