package com.qms.dept.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qms.dept.dao.DeptDao;
import com.qms.dept.vo.DeptVO;

@Service
public class DeptService {

	@Autowired
	DeptDao dao;
	
	public int selectTotalDeptCount(DeptVO vo) throws Exception{
		return dao.selectTotalDeptCount(vo);
	}
	
	public List<DeptVO> selectDeptList(DeptVO vo) throws Exception{
		return dao.selectDeptList(vo);
	}
	
	public DeptVO selectDeptDtlData(DeptVO vo) throws Exception{
		return dao.selectDeptDtlData(vo);
	}
	
	public List<DeptVO> selectUpDept(DeptVO vo) throws Exception{
		return dao.selectUpDept(vo);
	}
	
	public int InsertOrSelectDeptdata(DeptVO vo) throws Exception{
		return dao.InsertOrSelectDeptdata(vo);
	}
	
	
}	

	