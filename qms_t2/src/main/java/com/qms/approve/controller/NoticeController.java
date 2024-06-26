package com.qms.approve.controller;

import java.util.Calendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonCreator.Mode;
import com.qms.approve.service.NoticeService;
import com.qms.approve.vo.NoticeVO;
import com.qms.code.service.CodeService;
import com.qms.common.service.FileService;
import com.qms.table.vo.approve.NoticeInfoVO;
import com.qms.table.vo.common.ComCodeVO;
import com.qms.table.vo.common.FileVO;
import com.qms.user.vo.UserVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class NoticeController {
	@Autowired
	NoticeService service;
	
	@Autowired
	CodeService codeservice;
	@Autowired
	FileService fileService;
	
	@RequestMapping("/board/list")
	public String boards() throws Exception{
		return "approve/bo01";
	} //공지 page
	
	@RequestMapping("/board/createContent")
	public String createContent(@ModelAttribute("NoticeVO") NoticeVO vo , Model model) throws Exception{
		model.addAttribute("vo", vo);
		return "approve/bo01pop1";
	}//게시글 작성 팝업
	
	@RequestMapping("/board/searchlist")
	@ResponseBody
	public NoticeVO searchlist(@ModelAttribute("NoticeVO") NoticeVO vo ) throws Exception {
		
		int totalPage = service.selectTotalNoticeCount(vo); 
		
		List<NoticeInfoVO> list = service.selectNoticeList(vo);
		
		vo.setNoticelist(list);
		vo.setTotal(totalPage); //총 데이터수.
		vo.setStartPage(vo.getStartPage()); 
		vo.setCurrentPage(vo.getCurrentPage());//현재페이지
		
		return vo;
	} //공지 조회
	@RequestMapping("/board/noticeDetail")
	@ResponseBody
	public NoticeVO noticeDetail(@ModelAttribute("NoticeVO") NoticeVO vo )throws Exception {
		vo =service.selectNoticeDetail(vo);
		return vo;
		
	}
	// 공지사항 생성 만들어야됨

	@RequestMapping("/board/settingNotice")
	@ResponseBody
	public NoticeVO noticeSetting(@ModelAttribute("NoticeVO") NoticeVO ntvo ) throws Exception {
		
		if(ntvo.getNoticeSeq()!=null && !ntvo.getNoticeSeq().equals("")) {
			ntvo = service.selectNoticeDetail(ntvo);
		}else {
			ntvo = new NoticeVO();
		}
		ComCodeVO vo = new ComCodeVO();
		vo.setComGrpCd("NT01");
		List<ComCodeVO> list = codeservice.selectGetdata(vo);
		
		ntvo.setTypelist(list);
		
		return  ntvo;
		
	}
	
	@RequestMapping("/board/saveNotice")
	@ResponseBody
	public int saveNotice(@ModelAttribute("NoticeVO") NoticeVO vo, HttpServletRequest request) throws Exception {
		HttpSession session  = request.getSession();
        UserVO uservo = (UserVO) session.getAttribute("QMSUser");
		vo.setUserId(uservo.getUserId());
		

		MultipartFile atcFile = vo.getAtcfile(); 
	    if (atcFile != null) {
	            FileVO filevo = new FileVO();
	            Calendar calendar = Calendar.getInstance();//객체를 불러옴
	            
	            int year = calendar.get(Calendar.YEAR); // 현재 연도
	            int month = calendar.get(Calendar.MONTH) + 1; // 현재 월 (+1을 하는 이유는 월은 0부터 시작하기 때문)
	            String datePath = String.format("%04d%02d", year, month); // yyyymm 형식의 폴더 경로 생성

	            filevo.setMiddlePath("notice/" + datePath); // 미들 파일 경로 설정
	            filevo.setFile(vo.getAtcfile());
	            filevo = fileService.createFile(filevo); // 파일 서비스를 사용하여 파일 생성
	            vo.setFileName(filevo.getOrgFileNm());
	            vo.setFilePath(filevo.getFilePath());
	   }
		
		int cnt = service.insertNoticeData(vo);
		
		return  cnt;
	}
	
	
	
	
	
	
}
