package com.qms.code.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qms.code.dao.CodeDao;
import com.qms.table.vo.common.ComCodeVO;

@Service
public class CodeService {

	@Autowired
	CodeDao dao;
	
	public List<ComCodeVO> selectGetdata(ComCodeVO vo) throws Exception{
		return dao.selectGetdata(vo);
	}
	
	
	
}
