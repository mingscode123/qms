package com.qms.item.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.qms.item.dao.BomDao;
import com.qms.item.vo.BomVO;
import com.qms.item.vo.ItemVO;

@Service
public class BomService {

	@Autowired
	BomDao dao;
	public List<BomVO>selectBomList(ItemVO vo) throws Exception{
		return dao.selectBomList(vo);
	}
	public int selectTotalBomCount(ItemVO vo) throws Exception{
		return dao.selectTotalBomCount(vo);
	}
	public ArrayList<BomVO> selectBomDtlList(BomVO vo) throws Exception{
		return dao.selectBomDtlList(vo);
	}
	public int deliteItem(BomVO vo) throws Exception {
		return dao.deliteItem(vo);
	}
	public int itemNewInsertAdd(BomVO vo) throws Exception {
		return dao.itemNewInsertAdd(vo);
	}
	public BomVO selectBomDtl(BomVO vo)throws Exception{
		return dao.selectBomDtl(vo);
	}
	public int insertNewBom(BomVO vo) throws Exception {
		return dao.insertNewBom(vo);
	}
	
}	

	