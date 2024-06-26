package com.qms.language;

import java.util.Locale;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class LanguageController {

    @RequestMapping("/changeLanguage")
    public String changeLanguage(HttpServletRequest request) {
        String referer = request.getHeader("Referer"); // 사용자가 언어 변경을 요청하기 전에 있었던 페이지의 URL을 가져옵니다.
       
            return "redirect:" + referer; // referer 헤더에 저장된 URL로 리다이렉트합니다.
    }
}