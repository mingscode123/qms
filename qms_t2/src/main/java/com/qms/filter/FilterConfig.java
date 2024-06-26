package com.qms.filter;

import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class FilterConfig {

    @Bean
    public FilterRegistrationBean<QMSFilter> loggingFilter() {
        FilterRegistrationBean<QMSFilter> registrationBean = new FilterRegistrationBean<>();

        registrationBean.setFilter(new QMSFilter());
        registrationBean.addUrlPatterns("/*"); // 필터를 적용할 URL 패턴
        registrationBean.setOrder(1); // 필터 순서 설정

        return registrationBean;
    }
}



