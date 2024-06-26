package com.qms.inventory.dao;

import java.util.List;

import org.mybatis.spring.annotation.MapperScan;

import com.qms.inventory.vo.InventoryVO;

@MapperScan(basePackages="com.qms.inventory.dao")
public interface InventoryDao {
	
	public int selectTotalInvCount(InventoryVO vo) throws Exception;
	
	public List<InventoryVO> selectInvList(InventoryVO vo) throws Exception;
	
	

}
