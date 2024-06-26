package com.qms.partner.controller;

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
import com.qms.item.vo.ItemVO;
import com.qms.partner.service.PartnerService;
import com.qms.partner.vo.PartnerVO;
import com.qms.table.vo.common.MessageVO;
import com.qms.user.vo.UserVO;
import com.qms.util.Constant;
import com.qms.util.ExcelConstant;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;


@Controller
public class PartnerController {

	@Autowired
	PartnerService service;
	
	@Autowired
    private ExcelService excelService;
	

	@RequestMapping("/partner/list")
	public String partnerlist() throws Exception{
		return "partner/pt01";
	}
	
	@RequestMapping("/partner/searchlist")
	@ResponseBody
	public PartnerVO searchlist(@ModelAttribute("PartnerVO") PartnerVO vo) throws Exception {
		/*List<String> comGrpCdList = Arrays.asList(Constant.ITEM_TYPE,Constant.UNIT_TYPE, Constant.PLANT_LINE, Constant.BOX_TYPE, Constant.LOCATION);
 		 vo.setComGrpCdList(comGrpCdList); 공통코드 */
		 
	    int totalPage = service.selectTotalPartnerCount(vo); 
	    List<PartnerVO> list = service.selectPartnerList(vo);

	    vo.setPartnerlist(list);
	    vo.setTotal(totalPage);  // 총 데이터 수
	    vo.setStartPage(vo.getStartPage()); 
	    vo.setCurrentPage(vo.getCurrentPage());  // 현재 페이지

	    return vo;
	}
	
	@RequestMapping("/partner/getPartnerDtldata")
    @ResponseBody
    public PartnerVO getPartnerDtldata(@ModelAttribute("PartnerVO") PartnerVO vo) throws Exception {
		vo = service.selectPartnerDtldata(vo);
		List<String> comGrpCdList = Arrays.asList(Constant.BOX_TYPE, Constant.LOCATION);
		 vo.setComGrpCdList(comGrpCdList); 
		
		List<ItemVO> list = service.selectPartnerItemList(vo);
		
		vo.setItemlist(list);
		
		return vo;
	}
	
	@RequestMapping("/partner/saveOrUpdatePartner")
	@ResponseBody
	public MessageVO saveOrUpdatePartner(@ModelAttribute("PartnerVO") PartnerVO vo, HttpServletRequest request) throws Exception {
	    HttpSession session = request.getSession();
	    UserVO uservo = (UserVO) session.getAttribute("QMSUser");
	    MessageVO msgvo = new MessageVO();
	    
	    vo.setRegUserId(uservo.getUserId()); 

	    int cnt = service.InsertOrSelectPartnerdata(vo);
	    if (cnt > 0) {
	        msgvo.setMsg("거래처 정보 저장 성공");
	        //delete 후 insert
	        service.deletePartnerItem(vo);
	        
	        if(vo.getItemlist()!=null && vo.getItemlist().size()>0) {
	        	for(int i=vo.getItemlist().size()-1;i>=0;i--) {
	        		if(vo.getItemlist().get(i).getItemCd()==null || vo.getItemlist().get(i).getItemCd().equals("")){
	        			vo.getItemlist().remove(i);
	        		} 
	        	}
	        	cnt = service.insertPartnerItem(vo);
	        }
	        if (cnt > 0) {
	            msgvo.setMsg("제품 정보 저장 성공");
	        } else {
	            msgvo.setMsg("제품 정보 저장 실패");
	        }
	    } else {
	        msgvo.setMsg("거래처 정보 저장 실패");
	    }

	    return msgvo;
	}

	@PostMapping("/partner/excelDownload")
	public ResponseEntity<byte[]> downloadExcel(@ModelAttribute("PartnerVO") PartnerVO vo) throws Exception {
	    Map<String, Object> parameters = new HashMap<>();
	    
	    parameters.put("regDtFrom", vo.getRegDtFrom());
	    parameters.put("regDtTo", vo.getRegDtTo());
	    parameters.put("compName", vo.getCompName());
	    parameters.put("compType", vo.getCompType());
	    
	    List<Map<String, Object>> dataList = excelService.selectPartnerListTOexcel(parameters);

	    String[] headers = ExcelConstant.PARTNER_HEADER;
	    String[] columns = ExcelConstant.PARTNER_COLUMN;
	    String sheetName = "거래처 조회";
	    String filenName = "partner_data.xlsx";

	    return excelService.createExcelFile(dataList, columns, headers, filenName , sheetName);
	}
	

	
	
}
