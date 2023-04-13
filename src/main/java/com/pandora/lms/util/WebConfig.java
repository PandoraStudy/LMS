package com.pandora.lms.util;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(authoLoginInterceptor())
		.order(1)
		.addPathPatterns("/**")
		.excludePathPatterns("/css/**","/*.ico","/error","/login","/slogin","/tlogin");
		
	}

	
	@Bean
	public AuthoLoginInterceptor authoLoginInterceptor() {
		return new AuthoLoginInterceptor();
	}
	
}
