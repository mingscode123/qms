package com.qms.excel.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.annotation.MapperScan;

import com.qms.plan.vo.planVO;
import com.qms.product.vo.ProductVO;
import com.qms.product.vo.proVO;

@MapperScan(basePackages="com.qms.excel.dao")
public interface ExcelDao {
	
	public List<Map<String, Object>> selectItemListTOexcel(Map<String, Object> parameters) throws Exception;
	
	public List<Map<String, Object>> selectPartnerListTOexcel(Map<String, Object> parameters) throws Exception;
	
	public List<Map<String, Object>> selectReceiveListTOexcel(Map<String, Object> parameters) throws Exception;
	
	public List<Map<String, Object>> selectUserListTOexcel(Map<String, Object> parameters) throws Exception;
	
	public List<Map<String, Object>> selectInvListTOexcel(Map<String, Object> parameters) throws Exception;

	public List<Map<String, Object>> selectQtyToExcel(planVO vo) throws Exception ;
	
	public List<Map<String, Object>> selectPlanSearchListTOexcel(planVO vo) throws Exception;
	
	public List<Map<String, Object>> selectDailyOrderListTOexcel(Map<String, Object> parameters) throws Exception ;
	
	public List<Map<String, Object>> selectProductListTOexcel(proVO vo) throws Exception;
	
	public List<Map<String, Object>> selectMthProToExcel(ProductVO vo) throws Exception ;
	
	public List<Map<String, Object>> selectMonthProListTOexcel(Map<String, Object> parameters) throws Exception;
	
	public List<Map<String, Object>> selectMonthUseTOexcel(Map<String, Object> parameters) throws Exception;

	public List<Map<String, Object>> selectDeptListTOexcel(Map<String, Object> parameters) throws Exception;


}