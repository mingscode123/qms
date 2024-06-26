package com.qms.approve.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qms.approve.service.ApproveService;
import com.qms.approve.vo.Aprv01VO;
import com.qms.approve.vo.AprvPageVO;
import com.qms.code.service.CodeService;
import com.qms.common.service.FileService;
import com.qms.table.vo.approve.AprvInfoVO;
import com.qms.table.vo.common.ComCodeVO;
import com.qms.table.vo.user.UserInfoVO;
import com.qms.user.vo.UserVO;
import com.qms.util.Constant;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;


@Controller
public class ApproveController {

	@Autowired
	ApproveService service;
	@Autowired
	CodeService codeService;
	@Autowired
	FileService fileService;

	
	
	@RequestMapping("/approve/write")
	public String approveWrite() throws Exception{
		return "approve/ap01";
	}
	
	@RequestMapping("/approve/approveline")
	public String approveLine() throws Exception{
		return "approve/ap01pop1";
	}
	
	@RequestMapping("/approve/getSelectData")
    @ResponseBody
    public Aprv01VO getSelectData(HttpServletRequest request) throws Exception {
        HttpSession session  = request.getSession();
        UserVO uservo = (UserVO) session.getAttribute("QMSUser");
        
        ComCodeVO vo = new ComCodeVO();
        
        vo.setComGrpCd(Constant.DOC_TYPE);
        List<ComCodeVO> doclist = codeService.selectGetdata(vo);
        
        vo.setComGrpCd(Constant.PRESERVE_YEAR);
        List<ComCodeVO> yearlist = codeService.selectGetdata(vo);
        
        vo.setComGrpCd(Constant.DOC_CLASS);
        List<ComCodeVO> classlist = codeService.selectGetdata(vo);
        
        vo.setComGrpCd(Constant.DOC_STATUS);
        List<ComCodeVO> statuslist = codeService.selectGetdata(vo);
        
        Aprv01VO avo = new Aprv01VO();
        avo.setDoclist(doclist);
        avo.setYearlist(yearlist);
        avo.setClasslist(classlist);
        avo.setStatuslist(statuslist);
        avo.setUserName(uservo.getUserName());
        avo.setDeptName(uservo.getDeptName());
        
        return avo;
    }
	@RequestMapping("/approve/insertDocDate")
	@ResponseBody
	public int insertSave(@ModelAttribute("Aprv01VO")  Aprv01VO vo, HttpServletRequest request) throws Exception {
		
		
		HttpSession session  = request.getSession();
        UserVO uservo = (UserVO) session.getAttribute("QMSUser");
		vo.setUserId(uservo.getUserId());

		int result = service.insertDocData(vo);
		
		return result;
	}//등록
	
	
	@RequestMapping("/approve/list")
	public String approveSearch(HttpServletRequest request, Model model) throws Exception{
		HttpSession session  = request.getSession();
		UserInfoVO uservo = (UserInfoVO) session.getAttribute("QMSUser");
		model.addAttribute("vo", uservo);
		
		return "approve/ap02";
	}
	@RequestMapping("/approve/ap02pop")
	public String approvepop(@ModelAttribute AprvInfoVO vo, Model model) throws Exception{
		model.addAttribute("vo", vo);
		return "approve/ap02pop";
	}
	@RequestMapping("/getDocStatus")
	@ResponseBody
	public Aprv01VO getDocStatus(@ModelAttribute("Aprv01VO") Aprv01VO vo, HttpServletRequest request) throws Exception{
		HttpSession session  = request.getSession();
		UserInfoVO uservo = (UserInfoVO) session.getAttribute("QMSUser");
		
		int totalPage = 0;
		Aprv01VO aprvpagevo = new Aprv01VO();

		vo.setUserId(uservo.getUserId());
		if(vo.getSearchType().equals("0")) {	//진행중
			List<Aprv01VO> list = service.selectAprvIng(vo);
			totalPage = service.selectTotalAprvingCount(vo);
            aprvpagevo.setAprvList(list);
		}else if(vo.getSearchType().equals("1")) {  //완료
			List<Aprv01VO> list = service.selectAprvDone(vo);
			totalPage = service.selectTotalAprvedCount(vo);
            aprvpagevo.setAprvList(list);
		}else {
			List<Aprv01VO> list = service.getDocStatus(vo);
			totalPage = service.selectTotalMyAprvCount(vo);
            aprvpagevo.setAprvList(list);
		}
		aprvpagevo.setTotal(totalPage); // 총 데이터 수
        aprvpagevo.setStartPage(vo.getStartPage());
        aprvpagevo.setCurrentPage(vo.getCurrentPage()); // 현재 페이지
        return aprvpagevo;
	}
	
	@RequestMapping("/getDocDetail")
	@ResponseBody
	public Aprv01VO getDocDetail(@ModelAttribute("Aprv01VO") Aprv01VO vo,HttpServletRequest request) throws Exception{
		HttpSession session  = request.getSession();
		UserInfoVO uservo = (UserInfoVO) session.getAttribute("QMSUser");
		vo = service.selectDocDetail(vo);				//결재정보
		vo.setLinelist(service.selectAprvLineList(vo));	//결재라인
		vo.setAprvUserId(uservo.getUserId());
		
		for(int i=0;i<vo.getLinelist().size();i++) {
			if(vo.getLinelist().get(i).getUserId().equals(uservo.getUserId()) && vo.getLinelist().get(i).getAprvStatus().equals("02")) {
				vo.setAprv(true);
			}
		}
		vo.setFilelist(service.selectAprvFileList(vo));	//첨부파일
		return vo;
	}
	@RequestMapping("/UpdateStatus")
	@ResponseBody
	public int UpdateStatus(@ModelAttribute("Aprv01VO") Aprv01VO vo,HttpServletRequest request) throws Exception{
		HttpSession session  = request.getSession();
		UserInfoVO uservo = (UserInfoVO) session.getAttribute("QMSUser");
		vo.setAprvUserId(uservo.getUserId());
		if(vo.getIutype().equals("a") ){
			 service.UpdateAgreeStatus(vo); // APRV_STATUS 결재처리
			 
			 service.UpdateNextAprv(vo); // 다음 seq 결재중 처리
			 
			 service.UpdateAgreeDoc(vo); // DOC_STATUS 결재처리
			 
			 
		}else{
			 
			service.UpdatePassStatus(vo); //APRV_STATUS 반려처리
			
			service.UpdatePassDoc(vo); //DOC_STATUS 반려처리
			
			
		}
		return 1;
	}
	

	

	
	
	
}
