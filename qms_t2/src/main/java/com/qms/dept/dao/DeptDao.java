package com.qms.dept.dao;

import java.util.List;

import org.mybatis.spring.annotation.MapperScan;

import com.qms.dept.vo.DeptVO;

@MapperScan(basePackages="com.qms.dept.dao")
public interface DeptDao {
	
	public int selectTotalDeptCount(DeptVO vo) throws Exception;
	
	public List<DeptVO> selectDeptList(DeptVO vo) throws Exception;
	
	//모달
	public DeptVO selectDeptDtlData(DeptVO vo) throws Exception;
	
	public List<DeptVO> selectUpDept(DeptVO vo) throws Exception;
	
	public int InsertOrSelectDeptdata(DeptVO vo) throws Exception;
}
