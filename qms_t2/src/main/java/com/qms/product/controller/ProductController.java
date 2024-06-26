package com.qms.product.controller;

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
import com.qms.product.service.ProductService;
import com.qms.product.vo.ProductVO;
import com.qms.product.vo.proVO;
import com.qms.table.vo.product.ProductInfoVO;
import com.qms.table.vo.user.UserInfoVO;
import com.qms.util.Constant;
import com.qms.util.ExcelConstant;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class ProductController {
	
	@Autowired
	ProductService service;
	@Autowired
	ExcelService excelService;
	@RequestMapping("/product/list")
	public String product(Model model) throws Exception{
		model.addAttribute("baseYear", Constant.BASE_YEAR);
		return "product/list";
	}
	@RequestMapping("/plan/selectPartnerInfo")
	@ResponseBody
	public List<proVO> selectPartnerInfo(@ModelAttribute proVO vo)throws Exception{
		
		List<proVO> list = service.selectPartnerInfo(vo);
		
		return list;
	}
	
	// 계획리스트 조회
	@RequestMapping("/plan/selectProductInfo")
	@ResponseBody
	public List<proVO> selectProductInfo(@ModelAttribute proVO vo)throws Exception{
		
		List<proVO> list = service.selectProductInfo(vo);
		
		return list;
	}
	
	
	@RequestMapping("/selectModalInfo")
	@ResponseBody
	public proVO selectModalInfo(@ModelAttribute proVO vo)throws Exception{
		
		List<proVO> list = service.selectModalInfo(vo);
		List<proVO> user = service.selectAllUser(vo);
		
		vo.setModallist(list);
		vo.setUserlist(user);
		
		return vo;
	}
	@RequestMapping("/deleteInsertitem")
	@ResponseBody
	public int deleteInsertitem(@ModelAttribute("proVO")proVO vo,HttpServletRequest request)throws Exception{
		HttpSession session  = request.getSession();
		UserInfoVO uservo = (UserInfoVO) session.getAttribute("QMSUser");
		vo.setRegUserId(uservo.getUserId());
		int d = service.deleteItem(vo);
		int cnt = service.insertItem(vo);
		return cnt;
	}
	
	/*@PostMapping("/productExcelD")
	public ResponseEntity<byte[]> productExcelD(@ModelAttribute("proVO")proVO vo) throws Exception {
		Map<String, Object> parameters = new HashMap<>();
	    
	    
	    Calendar cal = Calendar.getInstance();
	    //자바 캘린더에서 인스턴스 가져온다.

	    cal.set(Integer.parseInt(vo.getPlanYear()),Integer.parseInt(vo.getPlanMonth())-1,1);
	    //화면에서 선택한 년도와 달을 가져와서 세팅한다.
	    System.out.println(cal.getActualMaximum(Calendar.DAY_OF_MONTH));
	    //선택한 달의 마지막 날짜.
	    
	    String[] headers = ExcelConstant.PLANSEARCH_HEADER;
	    String[] dateHeaders = new String[cal.getActualMaximum(Calendar.DAY_OF_MONTH)];
	    String[] dateCol = new String[cal.getActualMaximum(Calendar.DAY_OF_MONTH)];
	    if(Integer.parseInt(vo.getPlanMonth())<10) {
	    	vo.setPlanMonth("0"+vo.getPlanMonth());
	    }
	    vo.setPlanDt(vo.getPlanYear() + vo.getPlanMonth());
	    //planDt를 (화면에서 선택한 년도 + 화면에서 선택한 월)로 세팅한다.
	    List<Map<String, Object>> dataList = excelService.selectProductListTOexcel(vo);
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
	    
	    String sheetName = "생산 실적 조회";
	    String filenName = "productExcel.xlsx";

	    return excelService.createExcelFile(dataList, arrCol	, arr3, filenName , sheetName);
	} */
	
	@RequestMapping("/product/use")
	public String use(Model model) throws Exception{
		model.addAttribute("baseYear", Constant.BASE_YEAR);
		return "product/use";
	}
	
	@RequestMapping("/selectUseBomInfo")
	@ResponseBody
	public List<proVO> selectUseBomInfo(@ModelAttribute proVO vo)throws Exception{
		vo.setPlanDt(vo.getPlanYear() + vo.getPlanMonth());
		List<proVO> list = service.selectUseBomInfo(vo);
		
		return list;
	}
	
	@PostMapping("/useListExcel")
	public ResponseEntity<byte[]> useListExcel(@ModelAttribute("proVO")proVO vo) throws Exception {
		Map<String, Object> parameters = new HashMap<>();
		 parameters.put("planDt", vo.getPlanYear()+vo.getPlanMonth());
		 parameters.put("compCd", vo.getCompCd());
		 
		 
		    List<Map<String, Object>> dataList = excelService.selectMonthUseTOexcel(parameters);

		    String[] headers = ExcelConstant.MTHUSE_HEADER;
		    String[] columns = ExcelConstant.MTHUSE_COLUMN;
		    String sheetName = "월별 소요자재조회";
		    String filenName = "useListExcel.xlsx";

		    return excelService.createExcelFile(dataList, columns, headers, filenName , sheetName);
	}
	
	@RequestMapping("/product/monthProList")
	public String monthProductlist() throws Exception{
		return "product/monthProList";
	}
	
	/*@RequestMapping("/product/getMonthProSearch")
	@ResponseBody
	public proVO getMonthProSearch(@ModelAttribute ("proVO") proVO vo ) throws Exception{
		vo.setProductDt(vo.getProductYear()+vo.getProductMonth());
		
		int totalPage = service.selectTotalMonthProCount(vo);
		
		List<proVO> list = service.selectMonthProList(vo);
		
		vo.setProList(list);
		vo.setTotal(totalPage); //총 데이터수.
		vo.setStartPage(vo.getStartPage()); 
		vo.setCurrentPage(vo.getCurrentPage());//현재페이지
		
		return vo;
	}
	
	@PostMapping("/product/monthProexcelDownload")
	public ResponseEntity<byte[]> downloadExcel(@ModelAttribute("proVO") proVO vo) throws Exception {
		vo.setProductDt(vo.getProductYear()+vo.getProductMonth());
		
		Map<String, Object> parameters = new HashMap<>();
		parameters.put("compCd", vo.getCompCd());
		parameters.put("productDt", vo.getProductDt());
		
		
	    List<Map<String, Object>> dataList = excelService.selectMonthProListTOexcel(parameters);

	    String[] headers = ExcelConstant.MONTH_PRODUCT_HEADER;
	    String[] columns = ExcelConstant.MONTH_PRODUCT_COLUMN;
	    String sheetName = "월별 생산실적조회";
	    String filenName = "monthPro_data.xlsx";

	    return excelService.createExcelFile(dataList, columns, headers, filenName, sheetName);
	}
	
	@RequestMapping("/product/monthly")
	public String mkPlan(Model model) throws Exception{
		model.addAttribute("baseYear", Constant.BASE_YEAR);
		return "/product/monthlyProduct";
	}
	@RequestMapping("/product/mthProductList")
	@ResponseBody
	public ProductVO searchMthProList(@ModelAttribute ("ProductVO") ProductVO vo ) throws Exception{
		int totalPage = service.selectTotalMthProCount(vo);
		
		List<ProductInfoVO> list = service.selectMonthlyProductList(vo);
		
		vo.setMthProList(list);
		vo.setTotal(totalPage); //총 데이터수.
		vo.setStartPage(vo.getStartPage()); 
		vo.setCurrentPage(vo.getCurrentPage());//현재페이지
		
		return vo;
	}
	
	/*@PostMapping("/mthProExcel/excelDownload")
	public ResponseEntity<byte[]> downloadExcel(@ModelAttribute("ProductVO")ProductVO vo) throws Exception {
	    Map<String, Object> parameters = new HashMap<>();
	    
	    List<Map<String, Object>> dataList = excelService.selectMthProToExcel(vo);

	    String[] headers = ExcelConstant.MTHPRO_HEADER;
	    String[] columns = ExcelConstant.MTHPRO_COLUMN;
	    String sheetName = "월별 소요자재 조회";
	    String fileName = "monthlyProduct.xlsx";

	    return excelService.createExcelFile(dataList, columns, headers, fileName , sheetName);
	}*/
	


	
}