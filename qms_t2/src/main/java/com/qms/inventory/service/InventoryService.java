package com.qms.inventory.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qms.inventory.dao.InventoryDao;
import com.qms.inventory.vo.InventoryVO;

@Service
public class InventoryService {

	@Autowired
	InventoryDao dao;
	
	public int selectTotalInvCount(InventoryVO vo) throws Exception{
		return dao.selectTotalInvCount(vo);
	}
	
	public List<InventoryVO> selectInvList(InventoryVO vo) throws Exception{
		return dao.selectInvList(vo);
	}
	
	
	
}	

	