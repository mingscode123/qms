package com.qms.filter;
import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


public class QMSFilter implements Filter {

	/*@Override
	public void init(FilterConfig filterConfig) throws ServletException {
	    // 필터 초기화 코드
	}*/


	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
	    HttpServletRequest httpRequest = (HttpServletRequest) request;
	    HttpServletResponse httpResponse = (HttpServletResponse) response;

	    // 필터 예외 조건 ( 로그인 화면 , 로그인 프로세서 , css  , 비밀번호 재설정)
	    if (httpRequest.getRequestURI().equals("/login")
	        || httpRequest.getRequestURI().equals("/loginProcess")
	        || httpRequest.getRequestURI().startsWith("/assets/")
	    	|| httpRequest.getRequestURI().equals("/login/findPwd") ) {
	        chain.doFilter(request, response);
	        return;
	    }

	    // 로그인 여부 확인 로직
	    boolean isLoggedIn = checkLoginStatus(httpRequest);

	    // 로그인이 필요한 URL에 접근한 경우
	    if (isLoggedIn) {
	        chain.doFilter(request, response); // 다음 필터 또는 서블릿 호출
	    } else {
	        // 로그인이 필요한 경우, alert 창을 띄우고 로그인 페이지로 리디렉션
	        httpResponse.setContentType("text/html; charset=UTF-8");
	        httpResponse.setCharacterEncoding("UTF-8");
	        
	        String redirectUrl = httpRequest.getContextPath() + "/login";
	        String alertScript = "<script>alert('로그인이 필요한 서비스입니다.'); location.href='" + redirectUrl 
	        					 + "'</script>";
	        httpResponse.getWriter().println(alertScript);
	    }
	}



    /*@Override
    public void destroy() {
        // 필터 정리 함수 (필요한 경우)
    }*/

    private boolean checkLoginStatus(HttpServletRequest request) {
        HttpSession session = request.getSession();
        Object loggedInManager = session.getAttribute("QMSUser");

        // 로그인 여부를 확인
        if (loggedInManager != null) {
            // 로그인되어 있는 경우
            return true;
        } else {
            // 로그인되어 있지 않은 경우
            return false;
        }
    }

}

