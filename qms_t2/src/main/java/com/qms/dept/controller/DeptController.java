package com.qms.dept.controller;

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

import com.qms.code.service.CodeService;
import com.qms.dept.service.DeptService;
import com.qms.dept.vo.DeptVO;
import com.qms.excel.service.ExcelService;
import com.qms.item.vo.ItemVO;
import com.qms.table.vo.common.ComCodeVO;
import com.qms.table.vo.common.MessageVO;
import com.qms.user.vo.UserVO;
import com.qms.util.Constant;
import com.qms.util.ExcelConstant;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class DeptController {

    @Autowired
    DeptService service;

    @Autowired
    CodeService codeService;

    @Autowired
    ExcelService excelService;
    
    @RequestMapping("/dept/list")
	public String deptlist() throws Exception{
		return "dept/dept01";
	}
    
    @RequestMapping("/dept/searchlist")
	@ResponseBody
	public DeptVO searchlist(@ModelAttribute("DeptVO") DeptVO vo) throws Exception {
    	ComCodeVO cvo = new ComCodeVO();
    	cvo.setComGrpCd(Constant.POSITION_CD);
    	 List<ComCodeVO> positionlist = codeService.selectGetdata(cvo);

    	 //DeptVO dvo = new DeptVO();
    	 vo.setPositionlist(positionlist);

	    int totalPage = service.selectTotalDeptCount(vo); 
	    List<DeptVO> list = service.selectDeptList(vo);

	    vo.setDeptlist(list);
	    vo.setTotal(totalPage);  // 총 데이터 수
	    vo.setStartPage(vo.getStartPage()); 
	    vo.setCurrentPage(vo.getCurrentPage());  // 현재 페이지

	    return vo;
	}
    
    @RequestMapping("/dept/getDeptDtlData")
    @ResponseBody
    public DeptVO getDeptDtlData(@ModelAttribute("DeptVO") DeptVO vo) throws Exception {
		vo = service.selectDeptDtlData(vo);
		
		return vo;
	}
    
    @RequestMapping("/dept/upDeptName")
    @ResponseBody
    public List<DeptVO> upDeptName(@ModelAttribute DeptVO vo) throws Exception {
        
        List<DeptVO> list = service.selectUpDept(vo);
        
        return list;
    }

    
	@RequestMapping("/dept/saveOrUpdateDept")
	@ResponseBody
	public MessageVO saveOrUpdateDept(@ModelAttribute("DeptVO") DeptVO vo, HttpServletRequest request) throws Exception {
	    HttpSession session = request.getSession();
	    UserVO uservo = (UserVO) session.getAttribute("QMSUser");
	    MessageVO msgvo = new MessageVO();
	    
	    vo.setRegUserId(uservo.getUserId()); 
	    vo.setUpdUserId(uservo.getUserId()); 

	    int cnt = service.InsertOrSelectDeptdata(vo);
	    if (cnt > 0) {
	        msgvo.setMsg("부서 정보 저장 성공");
	    } else {
	        msgvo.setMsg("부서 정보 저장 실패");
	    }

	    return msgvo;
	}
	
	@PostMapping("/dept/excelDownload")
	public ResponseEntity<byte[]> downloadExcel(@ModelAttribute("DeptVO") DeptVO vo) throws Exception {
	    Map<String, Object> parameters = new HashMap<>();
	    parameters.put("deptName", vo.getDeptName());
	    parameters.put("delYn", vo.getDelYn());

	    List<Map<String, Object>> dataList = excelService.selectDeptListTOexcel(parameters);

	    String[] headers = ExcelConstant.DEPT_HEADER;
	    String[] columns = ExcelConstant.DEPT_COLUMN;
	    String sheetName = "부서 조회";
	    String fileName = "dept_data.xlsx";

	    return excelService.createExcelFile(dataList, columns, headers, fileName , sheetName);
	}
	

   

}
