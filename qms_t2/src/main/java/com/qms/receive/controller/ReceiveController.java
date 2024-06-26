package com.qms.receive.controller;

import java.util.Arrays;
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

import com.qms.excel.service.ExcelService;
import com.qms.receive.service.ReceiveService;
import com.qms.receive.vo.RcvVO;
import com.qms.receive.vo.ReceiveVO;
import com.qms.table.vo.receive.RcvItemVO;
import com.qms.table.vo.user.UserInfoVO;
import com.qms.util.Constant;
import com.qms.util.ExcelConstant;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class ReceiveController {
	@Autowired
	ReceiveService service;
	
	@RequestMapping("/receive/list")
	public String productlist() throws Exception{
		return "receive/rcv01";
	}
	
	@RequestMapping("/receive/rcv01pop1")
	public String inbo01pop1() throws Exception{
		return "/receive/rcv01pop1"; //팝업 연결 전 jsp 확인용
	}
	@RequestMapping("/receive/stuff")
	public String stuff() throws Exception{
		return "receive/rcvStf01";
	}
	@RequestMapping("/recieve/searchList")
	@ResponseBody
	public ReceiveVO searchList(@ModelAttribute ("ReceiveVO") ReceiveVO vo ) throws Exception{
		int totalPage = service.selectTotalReceiveCount(vo);
		
		vo.setComGrpCd("IT05");
		List<RcvItemVO> list = service.selectReceiveList(vo);
		
		
		
		vo.setReceivelist(list);
		vo.setTotal(totalPage); //총 데이터수.
		vo.setStartPage(vo.getStartPage()); 
		vo.setCurrentPage(vo.getCurrentPage());//현재페이지
		
		return vo;
		
	}
	
	@RequestMapping("/receive/selectRcvList")
	@ResponseBody
	public  RcvVO selectItemList(@ModelAttribute("RcvVO") RcvVO vo) throws Exception {

	    int totalPage = service.selectTotalRcvCount(vo); 
	    List<RcvVO> list = service.selectRcvList(vo);

	    vo.setRcvlist(list);
	    vo.setTotal(totalPage);  // 총 데이터 수
	    vo.setStartPage(vo.getStartPage()); 
	    vo.setCurrentPage(vo.getCurrentPage());  // 현재 페이지

	    return vo;
	}
	@RequestMapping("/selectRcvClickList")
	@ResponseBody
	public List<RcvVO> selectRcvClickList(@ModelAttribute("RcvVO") RcvVO vo) throws Exception {
		List<RcvVO> list = service.selectRcvClickList(vo);
		return list;
	}
	
	@PostMapping("/RCVNewInsertAdd")
	@ResponseBody
	public int RCVNewInsertAdd(@ModelAttribute  RcvVO vo,HttpServletRequest request) throws Exception {
		HttpSession session  = request.getSession();
		UserInfoVO uservo = (UserInfoVO) session.getAttribute("QMSUser");
		vo.setUserId(uservo.getUserId());
		int cnt = 0;
		int d = service.delitercv(vo);
		cnt = service.RCVNewInsertAdd(vo);
		return cnt;
	}
	@Autowired
	private ExcelService excelService;
	
	@PostMapping("/receive/excelDownload")
	public ResponseEntity<byte[]> downloadExcel() throws Exception {
	    Map<String, Object> parameters = new HashMap<>();
	    
	    List<String> comGrpCdList = Arrays.asList(Constant.LOCATION);
	    parameters.put("comGrpCdList", comGrpCdList);
	    

	    List<Map<String, Object>> dataList = excelService.selectReceiveListTOexcel(parameters);

	    String[] headers = ExcelConstant.RECEIVE_HEADER;
	    String[] columns = ExcelConstant.RECEIVE_COLUMN;
	    String sheetName = "입고 품목 조회";
	    String filenName = "receiveStuff.xlsx";

	    return excelService.createExcelFile(dataList, columns, headers, filenName , sheetName);
	}

	
}