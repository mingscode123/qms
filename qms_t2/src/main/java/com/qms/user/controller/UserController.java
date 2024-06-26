package com.qms.user.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qms.code.service.CodeService;
import com.qms.dept.vo.DeptVO;
import com.qms.excel.service.ExcelService;
import com.qms.table.vo.common.ComCodeVO;
import com.qms.table.vo.common.MessageVO;
import com.qms.table.vo.user.UserInfoVO;
import com.qms.user.service.UserService;
import com.qms.user.vo.UserVO;
import com.qms.util.AesUtil;
import com.qms.util.Constant;
import com.qms.util.ExcelConstant;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;


@Controller
public class UserController {

	@Autowired
	UserService service;
	
	@Autowired
	CodeService codeService;
	
	@Autowired
    ExcelService excelService;
	
	@RequestMapping("/user/list")
	public String plan() throws Exception{
		return "user/us01";
	}
	
	@RequestMapping("/user/getComboBox")
	@ResponseBody
	public UserVO getComboBox(@ModelAttribute("UserVO") UserVO vo,@ModelAttribute("DeptVO") DeptVO deptvo,@ModelAttribute("ComCodeVO") ComCodeVO comvo) throws Exception {
		comvo.setComGrpCd(Constant.POSITION_CD);
		List<ComCodeVO> list1 = codeService.selectGetdata(comvo); 

		List<DeptVO> list2 = service.selectDeptList(deptvo);
		
		vo.setPositionlist(list1);
		vo.setDeptlist(list2);
		
		return vo;
	}
	
	@RequestMapping("/user/searchlist")
	@ResponseBody
	public UserVO searchlist(@ModelAttribute("UserVO") UserVO vo) throws Exception {
		vo.setComGrpCd(Constant.POSITION_CD);
		int totalPage = service.selectTotalUserCount(vo); 

		List<UserInfoVO> list = service.selectUserList(vo);
		
		vo.setUserlist(list);
		vo.setTotal(totalPage); //총 데이터수.
		vo.setStartPage(vo.getStartPage()); 
		vo.setCurrentPage(vo.getCurrentPage());//현재페이지

		
		return vo;
	}
	
	@PostMapping("/user/excelDownload")
	public ResponseEntity<byte[]> downloadExcel(@ModelAttribute("UserVO") UserVO vo) throws Exception {
	    Map<String, Object> parameters = new HashMap<>();
	    
	    parameters.put("comGrpCd", Constant.POSITION_CD);
	    parameters.put("userName", vo.getUserName());
	   

	    List<Map<String, Object>> dataList = excelService.selectUserListTOexcel(parameters);

	    String[] headers = ExcelConstant.USER_HEADER;
	    String[] columns = ExcelConstant.USER_COLUMN;
	    String sheetName = "유저 조회";
	    String filenName = "user_data.xlsx";

	    return excelService.createExcelFile(dataList, columns, headers, filenName, sheetName);
	}//USER EXCEL 생성시 사용
	
	@RequestMapping("/user/userSearchlist")
	@ResponseBody
	public UserVO userSearchlist(@ModelAttribute("UserVO") UserVO vo) throws Exception {
		vo.setComGrpCd(Constant.POSITION_CD);
		int totalPage = service.selectTotalUserCount(vo); 

		List<UserInfoVO> list = service.selectUserList(vo);
		
		vo.setUserlist(list);
		vo.setTotal(totalPage); //총 데이터수.
		vo.setStartPage(vo.getStartPage()); 
		vo.setCurrentPage(vo.getCurrentPage());//현재페이지

		
		return vo;
	}
	
	@RequestMapping("/user/getUserDtlData")
	@ResponseBody
	public UserVO getUserDtlData(@ModelAttribute("UserVO") UserVO vo) throws Exception {

		vo = service.selectGetUserDtlData(vo);
		
		return vo;
	}
	
	@RequestMapping("/user/updateUserdata")
	@ResponseBody
	public MessageVO updateUserdata(@ModelAttribute("UserVO")  UserVO vo, HttpServletRequest request) throws Exception {
		HttpSession session  = request.getSession();
        UserVO uservo = (UserVO) session.getAttribute("QMSUser");
		vo.setUpdUserId(uservo.getUserId());
		if(vo.getUserPwd() != null && !vo.getUserPwd().isEmpty()) {
			String pwd = AesUtil.aesEncode(vo.getUserPwd());
			vo.setUserPwd(pwd);
		}
		

		int cnt = service.updateUserdata(vo);
		
		MessageVO msgvo = new MessageVO();
		if(cnt > 0) {
			msgvo.setMsg("데이터 저장 성공");
		}else {
			msgvo.setMsg("데이터 저장 실패");
		}
		
		return msgvo;
	}//수정

	@RequestMapping("/user/insertNewUserdata")
	@ResponseBody
	public MessageVO insertNewUserdata(@ModelAttribute("UserVO")  UserVO vo, HttpServletRequest request) throws Exception {
		HttpSession session  = request.getSession();
        UserVO uservo = (UserVO) session.getAttribute("QMSUser");
		vo.setRegUserId(uservo.getUserId());
		
		String pwd = AesUtil.aesEncode(vo.getUserPwd());
		vo.setUserPwd(pwd);

		int cnt = service.insertNewUserdata(vo);
		
		MessageVO msgvo = new MessageVO();
		if(cnt > 0) {
			msgvo.setMsg("데이터 저장 성공");
		}else {
			msgvo.setMsg("데이터 저장 실패");
		}
		
		return msgvo;
	}//등록
	
	@RequestMapping("/user/chkId")
	@ResponseBody
	public MessageVO chkId(@ModelAttribute("UserVO")  UserVO vo) throws Exception {

		String str = service.selectchkId(vo);
		MessageVO msgvo = new MessageVO();
		if(str == null) {
			msgvo.setResult(true);
		}else {
			msgvo.setResult(false);
		}
		
		return msgvo;
	}//등록
	
	
}
