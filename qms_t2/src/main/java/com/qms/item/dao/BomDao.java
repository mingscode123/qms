package com.qms.item.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.qms.item.vo.BomVO;
import com.qms.item.vo.ItemVO;

@MapperScan(basePackages="com.qms.product.dao")
public interface BomDao {
	
	public List<BomVO>selectBomList(ItemVO vo) throws Exception;
	public int selectTotalBomCount(ItemVO vo) throws Exception;
	public ArrayList<BomVO> selectBomDtlList(BomVO vo) throws Exception;
	public int deliteItem(BomVO vo) throws Exception ;
	public int itemNewInsertAdd(BomVO vo) throws Exception ;
	public BomVO selectBomDtl(BomVO vo)throws Exception;
	public int insertNewBom(BomVO vo) throws Exception ;
	
}
