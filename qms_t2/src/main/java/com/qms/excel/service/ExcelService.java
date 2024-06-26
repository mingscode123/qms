package com.qms.excel.service;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.qms.excel.dao.ExcelDao;
import com.qms.plan.vo.planVO;

@Service
public class ExcelService {

	@Autowired
	ExcelDao dao;
	
	public List<Map<String, Object>> selectItemListTOexcel(Map<String, Object> parameters) throws Exception {
        return dao.selectItemListTOexcel(parameters);
    } //재고
	
	public List<Map<String, Object>> selectPartnerListTOexcel(Map<String, Object> parameters) throws Exception {
        return dao.selectPartnerListTOexcel(parameters);
    } //거래처
	
	public List<Map<String, Object>> selectUserListTOexcel(Map<String, Object> parameters) throws Exception {
        return dao.selectUserListTOexcel(parameters);
    } //유저
	
	public List<Map<String, Object>> selectReceiveListTOexcel(Map<String, Object> parameters) throws Exception {
        return dao.selectReceiveListTOexcel(parameters);
    }
	
	public List<Map<String, Object>> selectInvListTOexcel(Map<String, Object> parameters) throws Exception {
        return dao.selectInvListTOexcel(parameters);
    }
	
	public List<Map<String, Object>> selectPlanSearchListTOexcel(planVO vo) throws Exception {
        return dao.selectPlanSearchListTOexcel(vo);
    }
	
	public List<Map<String, Object>> selectDailyOrderListTOexcel(Map<String, Object> parameters) throws Exception {
        return dao.selectDailyOrderListTOexcel(parameters);
    }
	
	public List<Map<String, Object>> selectQtyToExcel(planVO vo) throws Exception {
        return dao.selectQtyToExcel(vo);
    }
	
	public List<Map<String, Object>> selectMonthProListTOexcel(Map<String, Object> parameters) throws Exception {
        return dao.selectMonthProListTOexcel(parameters);
    }
	
	public List<Map<String, Object>> selectDeptListTOexcel(Map<String, Object> parameters) throws Exception {
        return dao.selectDeptListTOexcel(parameters);
    }
	
	public ResponseEntity<byte[]> createExcelFile(List<Map<String, Object>> dataList, String[] columns, String[] headers, String fileName, String sheetName) {
	    try {
	        Workbook workbook = new XSSFWorkbook();
	        Sheet sheet = workbook.createSheet(sheetName); // 시트 이름 설정

	        // Header
	        Font headerFont = workbook.createFont();
	        headerFont.setBold(true);
	        CellStyle headerCellStyle = workbook.createCellStyle();
	        headerCellStyle.setFont(headerFont);
	        headerCellStyle.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
            headerCellStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
            headerCellStyle.setBorderTop(BorderStyle.THIN);
            headerCellStyle.setBorderBottom(BorderStyle.THIN);
            headerCellStyle.setBorderLeft(BorderStyle.THIN);
            headerCellStyle.setBorderRight(BorderStyle.THIN);
            
	        Row headerRow = sheet.createRow(0);
	        for (int i = 0; i < headers.length; i++) {
	            Cell cell = headerRow.createCell(i);
	            cell.setCellValue(headers[i]);
	            cell.setCellStyle(headerCellStyle);
	        }

	        // Data
	        int rowNum = 1;
	        for (Map<String, Object> data : dataList) {
	            Row row = sheet.createRow(rowNum++);
	            int cellNum = 0;
	            for (String column : columns) {
	                Object value = data.get(column);
	                row.createCell(cellNum++).setCellValue(value != null ? value.toString() : "");
	            }
	        }

	        ByteArrayOutputStream out = new ByteArrayOutputStream();
	        workbook.write(out);
	        workbook.close();

	        byte[] excelBytes = out.toByteArray();

	        HttpHeaders responseHeaders = new HttpHeaders();
	        responseHeaders.setContentType(MediaType.APPLICATION_OCTET_STREAM);
	        responseHeaders.setContentDispositionFormData("attachment", fileName);
	        responseHeaders.setContentLength(excelBytes.length);

	        return ResponseEntity.ok()
	                .headers(responseHeaders)
	                .body(excelBytes);
	      } 
     catch (IOException e) {
	        e.printStackTrace();
	        return null; // Error handling
	      }
	    
	}
	


	
	
}	

	