package com.qms.login.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qms.login.service.LoginService;
import com.qms.table.vo.common.MessageVO;
import com.qms.user.vo.UserVO;
import com.qms.util.AesUtil;
import com.qms.util.Constant;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class LoginController {

	@Autowired
	LoginService service;
	
	@RequestMapping("/login")
	public String login() throws Exception {
		return "login"; 
		
	} //로그인메인화면
	
	@RequestMapping("/logout")
	@ResponseBody
	public int logout(HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		session.setAttribute("QMSUser", null);
		return 1;
	} 
	
	@RequestMapping("/loginProcess")
	@ResponseBody
	public MessageVO loginProcess(@ModelAttribute UserVO vo, HttpServletRequest request) throws Exception{
		
		MessageVO msgvo = new MessageVO();
		vo.setComGrpCd(Constant.POSITION_CD);
		String pwd = AesUtil.aesEncode(vo.getUserPwd());
		//System.out.println(pwd); //암호화비밀번호 확인용	
		
		vo = service.selectUserInfo(vo);

	    if (vo == null) {  // 등록된 아이디가 아닐 경우
	        msgvo.setResult(false);
	        msgvo.setMsg("미등록 아이디 입니다.");
	    } else if ("Y".equals(vo.getLeaveYn())) {  // 퇴사자 여부 확인
	        msgvo.setResult(false);
	        msgvo.setMsg("퇴사자는 로그인할 수 없습니다.");
	    } else {  // 등록된 아이디일 경우
	        if (vo.getUserPwd().equals(pwd)) {  // 동일한 패스워드일 경우
	            // 세션 저장
	            HttpSession session = request.getSession();
	            session.setAttribute("QMSUser", vo);
	            msgvo.setResult(true);
	        } else {  // 패스워드가 동일하지 않을 경우
	            msgvo.setResult(false);
	            msgvo.setMsg("패스워드가 일치하지 않습니다.");
	        }
	    }
		return msgvo;
	} //비밀번호 암호화 & 세션 저장
	
	@RequestMapping("/login/findPwd")
	@ResponseBody
	public int findPwd(@ModelAttribute("UserVO") UserVO vo) throws Exception {
		String pwd = AesUtil.aesEncode(vo.getUserPwd());
		vo.setUserPwd(pwd);
		
		int cnt = service.updateUserPwd(vo);
		return cnt;
	} //비밀번호 재설정 
}

