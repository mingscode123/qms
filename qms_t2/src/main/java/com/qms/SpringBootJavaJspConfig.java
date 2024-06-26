package com.qms;

import java.util.Locale;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ViewResolverRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.i18n.LocaleChangeInterceptor;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

@Configuration // 이 클래스가 스프링의 설정 클래스임을 나타냅니다.
public class SpringBootJavaJspConfig implements WebMvcConfigurer { // WebMvcConfigurer 인터페이스를 구현하여 웹 MVC 설정을 사용자 정의합니다.
    

    @Bean // 메세지 프로퍼티를 관리
    public ReloadableResourceBundleMessageSource messageSource() { // 메시지 소스를 생성하는 메서드입니다.
        ReloadableResourceBundleMessageSource source = new ReloadableResourceBundleMessageSource(); // ReloadableResourceBundleMessageSource 객체를 생성합니다.
        source.setBasename("classpath:/messages/message"); // 메시지 파일의 기본 위치와 이름을 설정합니다.
        source.setDefaultEncoding("UTF-8"); // 기본 인코딩을 UTF-8로 설정합니다.
        return source; // 메시지 소스 빈을 반환합니다.
    }

   
    @Bean // 변경된 로케일을 저장 (기본값은 한국어)
    public SessionLocaleResolver localeResolver() { // 세션에 로케일 정보를 저장하는 리졸버를 생성하는 메서드입니다.
        SessionLocaleResolver localeResolver = new SessionLocaleResolver(); // SessionLocaleResolver 객체를 생성합니다.
        localeResolver.setDefaultLocale(Locale.KOREAN); // 기본 로케일을 한국어로 설정합니다.
        return localeResolver; // 로케일 리졸버 빈을 반환합니다.
    }

    
    @Bean // 처음에 파라미터 lang값을 확인하고 지역을 로케일을 변경
    public LocaleChangeInterceptor localeChangeInterceptor() { // 로케일 변경을 처리하는 인터셉터를 생성하는 메서드입니다.
        LocaleChangeInterceptor interceptor = new LocaleChangeInterceptor(); // LocaleChangeInterceptor 객체를 생성합니다.
        interceptor.setParamName("lang"); // 요청 파라미터 이름을 "lang"으로 설정합니다.
        return interceptor; // 로케일 변경 인터셉터 빈을 반환합니다.
    }

  
    @Override // WebMvcConfigurer 인터페이스의 메서드를 오버라이드합니다.
    public void addInterceptors(InterceptorRegistry registry) { // 인터셉터를 등록하는 메서드입니다.
        registry.addInterceptor(localeChangeInterceptor()); // 로케일 변경 인터셉터를 등록합니다.
    }

 
}
