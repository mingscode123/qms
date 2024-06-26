package com.qms.plan.controller;

import java.util.Arrays;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qms.excel.service.ExcelService;
import com.qms.plan.service.PlanService;
import com.qms.plan.vo.planVO;
import com.qms.table.vo.plan.PlanInfoVO;
import com.qms.table.vo.user.UserInfoVO;
import com.qms.util.Constant;
import com.qms.util.ExcelConstant;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class PlanController {
	@Autowired
	PlanService service;
	
	//추가 부분 시작 (시작이랑 끝부분 복붙해주세여)
		@RequestMapping("/plan/materialReq")
		public String plan() throws Exception{
			return "plan/materialReq";
		}
		//추가 부분 끝
		@RequestMapping("/plan/getPlanItemList")
		@ResponseBody
		public planVO searchlist(@ModelAttribute("planVO") planVO vo) throws Exception {
			int totalPage = service.selectTotalPlanItemCount(vo); 
			List<planVO> list = service.selectPlanItemList(vo);
			
			planVO plvo = new planVO();
			plvo.setPlanlist(list);
			plvo.setTotal(totalPage); //총 데이터수.
			plvo.setStartPage(vo.getStartPage()); 
			plvo.setCurrentPage(vo.getCurrentPage());//현재페이지
			return plvo;
		}
		@RequestMapping("/plan/list")
		public String plan(Model model) throws Exception{
			model.addAttribute("baseYear", Constant.BASE_YEAR);
			return "plan/list";
		}
	
	
	@RequestMapping("/insertPlan")
	@ResponseBody
	public int insertPlan(@ModelAttribute("planVO")planVO vo,HttpServletRequest request)throws Exception{
		HttpSession session  = request.getSession();
		UserInfoVO uservo = (UserInfoVO) session.getAttribute("QMSUser");
		vo.setUserId(uservo.getUserId());
		int d = service.deletePlan(vo);
		int cnt = service.insertPlan(vo);
		return cnt;
	}
	
	@RequestMapping("/plan/mkPlan")
	public String mkPlan(Model model) throws Exception{
		model.addAttribute("baseYear", Constant.BASE_YEAR);
		return "/plan/planSearch";
	}
	
	@RequestMapping("/plan/searchMkList")
	@ResponseBody
	public planVO searchList(@ModelAttribute ("planVO") planVO vo ) throws Exception{
		int totalPage = service.selectTotalMkPlanCount(vo);
		
		List<PlanInfoVO> list = service.selectMkPlanList(vo);
		
		vo.setMkList(list);
		vo.setTotal(totalPage); //총 데이터수.
		vo.setStartPage(vo.getStartPage()); 
		vo.setCurrentPage(vo.getCurrentPage());//현재페이지
		
		return vo;
	}
	@Autowired
	private ExcelService excelService;
	
	@PostMapping("/plan/excelDownload")
	public ResponseEntity<byte[]> downloadExcel(@ModelAttribute("planVO")planVO vo) throws Exception {
	    Map<String, Object> parameters = new HashMap<>();
	    
	    
	    Calendar cal = Calendar.getInstance();

	    cal.set(Integer.parseInt(vo.getPlanYear()),Integer.parseInt(vo.getPlanMonth())-1,1);

	    System.out.println(cal.getActualMaximum(Calendar.DAY_OF_MONTH));
	    
	    
	    String[] headers = ExcelConstant.PLAN_HEADER;
	    String[] dateHeaders = new String[cal.getActualMaximum(Calendar.DAY_OF_MONTH)];
	    String[] dateCol = new String[cal.getActualMaximum(Calendar.DAY_OF_MONTH)];
	    
	    vo.setPlanDt(vo.getPlanYear() + vo.getPlanMonth()); 
	    List<Map<String, Object>> dataList = excelService.selectQtyToExcel(vo);
	    for(int i = 1; i <=cal.getActualMaximum(Calendar.DAY_OF_MONTH); i++) {
	    	dateHeaders[i-1] = i+"일";
	    	dateCol[i-1] = "d"+i;
	    }
	    
	    String[] arr3 = new String[headers.length + dateHeaders.length];
	    System.arraycopy(headers, 0, arr3, 0, headers.length);
	    System.arraycopy(dateHeaders, 0, arr3, headers.length, dateHeaders.length);
	    
	     
	    
	    //String[] columns = ExcelConstant.PLAN_COLUMN;
	    String[] columns = ExcelConstant.PLAN_COLUMN;
	    
	    String[] arrCol = new String[columns.length + dateCol.length];
	    System.arraycopy(columns, 0, arrCol, 0, columns.length);
	    System.arraycopy(dateCol, 0, arrCol, columns.length, dateCol.length);
	    
	    
	    String sheetName = "생산계획관리";
	    String filenName = "PlanOrderQty.xlsx";
	    return excelService.createExcelFile(dataList, arrCol, arr3, filenName , sheetName);
	}
	// 파트너 조회
    @RequestMapping("/selectPartnerInfo")
    @ResponseBody
    public List<planVO> selectPartnerInfo(@ModelAttribute planVO vo)throws Exception{

        List<planVO> list = service.selectPartnerInfo(vo);

        return list;
    }

    // 계획리스트 조회
    @RequestMapping("/selectPlanList")
    public List<planVO> selectPlanList(@ModelAttribute planVO vo)throws Exception{
    	String str = (vo.getPlanYear()).substring(2);
    	vo.setPlanDt(str+"/"+vo.getPlanMonth());
        List<planVO> list = service.selectPlanList(vo);

        return list;
    }
    
        

	@PostMapping("/planSearch/excelDownload")
	public ResponseEntity<byte[]> downloadPlanExcel(@ModelAttribute("planVO")planVO vo) throws Exception {
		Map<String, Object> parameters = new HashMap<>();
	    
	    
	    Calendar cal = Calendar.getInstance();
	    //자바 캘린더에서 인스턴스 가져온다.

	    cal.set(Integer.parseInt(vo.getMkPlanYear()),Integer.parseInt(vo.getMkPlanMonth())-1,1);
	    //화면에서 선택한 년도와 달을 가져와서 세팅한다.
	    System.out.println(cal.getActualMaximum(Calendar.DAY_OF_MONTH));
	    //선택한 달의 마지막 날짜.
	    
	    String[] headers = ExcelConstant.PLANSEARCH_HEADER;
	    String[] dateHeaders = new String[cal.getActualMaximum(Calendar.DAY_OF_MONTH)];
	    String[] dateCol = new String[cal.getActualMaximum(Calendar.DAY_OF_MONTH)];
	    
	    vo.setPlanDt(vo.getMkPlanYear() + vo.getMkPlanMonth()); 
	    //planDt를 (화면에서 선택한 년도 + 화면에서 선택한 월)로 세팅한다.
	    List<Map<String, Object>> dataList = excelService.selectPlanSearchListTOexcel(vo);
	    for(int i = 1; i <=cal.getActualMaximum(Calendar.DAY_OF_MONTH); i++) {
	    	dateHeaders[i-1] = i+"일";
	    	dateCol[i-1] = "d"+i;
	    }
	    
	    String[] arr3 = new String[headers.length + dateHeaders.length];
	    System.arraycopy(headers, 0, arr3, 0, headers.length);
	    System.arraycopy(dateHeaders, 0, arr3, headers.length, dateHeaders.length);
	    
	     
	    
	    //String[] columns = ExcelConstant.PLAN_COLUMN;
	    String[] columns = ExcelConstant.PLANSEARCH_COLUMN;
	    
	    String[] arrCol = new String[columns.length + dateCol.length];
	    System.arraycopy(columns, 0, arrCol, 0, columns.length);
	    System.arraycopy(dateCol, 0, arrCol, columns.length, dateCol.length);
	    
	    String sheetName = "생산 계획 보기";
	    String filenName = "planSearch.xlsx";

	    return excelService.createExcelFile(dataList, arrCol	, arr3, filenName , sheetName);
	}
	

}

