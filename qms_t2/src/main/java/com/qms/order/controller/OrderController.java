package com.qms.order.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
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
import com.qms.order.service.OrderService;
import com.qms.order.vo.OrderVO;
import com.qms.user.vo.UserVO;
import com.qms.util.ExcelConstant;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@Controller
public class OrderController {

	@Autowired
	OrderService service;
	@Autowired
	ExcelService excelService;
	//ord01
	@RequestMapping("/order/list")
	public String orderlist() throws Exception{
		return "order/ord01";
	}
	
	@RequestMapping("/order/dailyOrder")
	public String orderlist2() throws Exception{
		return "order/ord02";
	}
	
	@RequestMapping("/order/getOrderList")
	@ResponseBody
	public OrderVO getOrderList(@ModelAttribute("OrderVO") OrderVO vo) throws Exception {
		int totalPage = service.selectTotalOrderCount(vo); 
		List<OrderVO> list = service.selectOrderList(vo);
		
		OrderVO ordervo = new OrderVO();
		ordervo.setOrderlist(list);
		ordervo.setTotal(totalPage); //총 데이터수.
		ordervo.setStartPage(vo.getStartPage()); 
		ordervo.setCurrentPage(vo.getCurrentPage());//현재페이지
		return ordervo;
	}
	
	@RequestMapping("/order/setRowData")
	@ResponseBody
	public List<OrderVO> setRowData(@ModelAttribute("OrderVO") OrderVO vo) throws Exception {
		List<OrderVO> list = service.selectModalDtlData(vo);
		return list;
	}
	
	@RequestMapping("/order/updateStatus")
	@ResponseBody
	public int updateStatus(@ModelAttribute("OrderVO") OrderVO vo) throws Exception {
		int cnt = service.updateStatus(vo);
		return cnt;
	}
	
	@RequestMapping("/order/updateOrderDtl")
	@ResponseBody
	public int updateOrderDtl(@ModelAttribute("OrderVO")  OrderVO vo, HttpServletRequest request) throws Exception {
		HttpSession session  = request.getSession();
        UserVO uservo = (UserVO) session.getAttribute("QMSUser");
		vo.setUserId(uservo.getUserId());

		int result = service.updateOrderDtl(vo);
		
		return result;
	}//등록
	
	@RequestMapping("/order/insertNewOrderDate")
	@ResponseBody
	public int newOrderDate(@ModelAttribute("OrderVO")  OrderVO vo, HttpServletRequest request) throws Exception {
		HttpSession session  = request.getSession();
        UserVO uservo = (UserVO) session.getAttribute("QMSUser");
		vo.setUserId(uservo.getUserId());

		int result = service.insertNewOrderDate(vo);
		
		return result;
	}//등록
	
	
	//ord02
	@RequestMapping("/order/getDailyOrderList")
	@ResponseBody
	public List<OrderVO> getDailyOrderList(@ModelAttribute("OrderVO") OrderVO vo) throws Exception {
		List<OrderVO> list = service.selectDailyOrderList(vo);
		return list;
	}
	
	@PostMapping("/order/excelDownload")
	public ResponseEntity<byte[]> downloadExcel(@ModelAttribute("OrderVO") OrderVO vo) throws Exception {
	    Map<String, Object> parameters = new HashMap<>();
	    parameters.put("deliveryDtFrom", vo.getDeliveryDtFrom());
	    parameters.put("deliveryDtTo", vo.getDeliveryDtTo());

	    List<Map<String, Object>> dailyOrderList = excelService.selectDailyOrderListTOexcel(parameters);

	    // deliveryDtFrom과 deliveryDtTo를 사용하여 headersDate 배열을 생성합니다.
	    String[] headersDate = generateDateHeaders(vo.getDeliveryDtFrom(), vo.getDeliveryDtTo());

	    String[] headersDefault = ExcelConstant.DAILY_ORDER_HEADER;
	    String[] headers = mergeArrays(headersDefault, headersDate);

	    // columns 배열을 올바르게 설정합니다.
	    String[] columns = mergeArrays(new String[]{"거래처명", "품번", "품명", "SUM"}, headersDate);
	    String sheetName = "일간 주문 조회";
	    String fileName = "order_data.xlsx";

	    // 데이터를 날짜별로 매핑
	    List<Map<String, Object>> processedDataList = processDataList(dailyOrderList, headersDate);

	    // 합계 행을 추가한 데이터 리스트 생성
	    Map<String, Object> totalRow = createTotalRow(processedDataList, headersDate);
	    processedDataList.add(0, totalRow); // 합계 행을 첫 번째 행으로 추가

	    System.out.println("Processed Data List: " + processedDataList); // 디버깅 로그 추가

	    // 서비스의 createExcelFile 메소드를 호출합니다.
	    return excelService.createExcelFile(processedDataList, columns, headers, fileName, sheetName);
	}

	private String[] generateDateHeaders(String deliveryDtFrom, String deliveryDtTo) {
	    DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
	    DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern("MM-dd");

	    LocalDate startDate = LocalDate.parse(deliveryDtFrom, inputFormatter);
	    LocalDate endDate = LocalDate.parse(deliveryDtTo, inputFormatter);

	    List<String> headersDateList = new ArrayList<>();

	    while (!startDate.isAfter(endDate)) {
	        headersDateList.add(startDate.format(outputFormatter));
	        startDate = startDate.plusDays(1);
	    }

	    return headersDateList.toArray(new String[0]);
	}

	private String[] mergeArrays(String[] array1, String[] array2) {
	    String[] mergedArray = new String[array1.length + array2.length];
	    System.arraycopy(array1, 0, mergedArray, 0, array1.length);
	    System.arraycopy(array2, 0, mergedArray, array1.length, array2.length);
	    return mergedArray;
	}

	private List<Map<String, Object>> processDataList(List<Map<String, Object>> dataList, String[] headersDate) {
	    Map<String, Map<String, Object>> dataMap = new HashMap<>(); // 회사와 품번별로 데이터를 저장할 맵

	    for (int i = 0; i < dataList.size(); i++) { // 데이터 리스트를 순회
	        Map<String, Object> data = dataList.get(i); // 현재 데이터 행
	        String compName = (String) data.get("compName"); // 거래처명
	        String itemCd = (String) data.get("itemCd"); // 품번
	        String itemName = (String) data.get("itemName"); // 품명
	        String deliveryDt = (String) data.get("deliveryDt"); // 배송 날짜
	        int orderQty = data.get("orderQty") != null ? ((Number) data.get("orderQty")).intValue() : 0; // 주문 수량

	        String key = compName + "_" + itemCd; // 회사와 품번을 조합하여 키 생성

	        dataMap.putIfAbsent(key, new HashMap<>()); // 키가 없으면 새로운 맵 추가
	        Map<String, Object> rowData = dataMap.get(key); // 키에 해당하는 데이터 행

	        rowData.put("거래처명", compName); // 거래처명 설정
	        rowData.put("품번", itemCd); // 품번 설정
	        rowData.put("품명", itemName); // 품명 설정

	        Integer currentSum = (Integer) rowData.get("SUM"); // 현재 합계 가져오기
	        if (currentSum == null) {
	            currentSum = 0; // 합계가 없으면 0으로 초기화
	        }
	        rowData.put("SUM", currentSum + orderQty); // 합계에 현재 주문 수량 추가

	        Integer currentQty = (Integer) rowData.get(deliveryDt); // 현재 날짜의 주문 수량 가져오기
	        if (currentQty == null) {
	            currentQty = 0; // 주문 수량이 없으면 0으로 초기화
	        }
	        rowData.put(deliveryDt, currentQty + orderQty); // 현재 날짜의 주문 수량 추가
	    }

	    List<Map<String, Object>> result = new ArrayList<>(dataMap.values()); // 결과 리스트 생성
	    System.out.println("Processed data list: " + result); // 디버깅을 위한 로그 출력
	    return result; // 결과 반환
	}

	private Map<String, Object> createTotalRow(List<Map<String, Object>> dataList, String[] headersDate) {
	    Map<String, Object> totalRow = new HashMap<>(); // 합계 행을 저장할 맵
	    totalRow.put("거래처명", "Total"); // 거래처명은 "Total"로 설정
	    totalRow.put("품번", ""); // 품번은 빈 문자열로 설정
	    totalRow.put("품명", ""); // 품명은 빈 문자열로 설정
	    totalRow.put("SUM", dataList.stream().mapToInt(data -> (Integer) data.getOrDefault("SUM", 0)).sum()); // 전체 합계 계산

	    for (String dateHeader : headersDate) { // 각 날짜별로 합계 계산
	        totalRow.put(dateHeader, dataList.stream()
	            .mapToInt(data -> (Integer) data.getOrDefault(dateHeader, 0))
	            .sum());
	    }

	    return totalRow; // 합계 행 반환
	}
	}