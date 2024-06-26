package com.qms.partner.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qms.item.vo.ItemVO;
import com.qms.partner.dao.PartnerDao;
import com.qms.partner.vo.PartnerVO;

@Service
public class PartnerService {

	@Autowired
	PartnerDao dao;
	
	public int selectTotalPartnerCount(PartnerVO vo) throws Exception{
		return dao.selectTotalPartnerCount(vo);
	}
	
	public List<PartnerVO> selectPartnerList(PartnerVO vo) throws Exception{
		return dao.selectPartnerList(vo);
	}
	
	//모달
	
	public PartnerVO selectPartnerDtldata(PartnerVO vo) throws Exception{
		return dao.selectPartnerDtldata(vo);
	}
	
	public List<ItemVO> selectPartnerItemList(PartnerVO vo) throws Exception {
		return dao.selectPartnerItemList(vo);
	} 
	
	public int deletePartnerItem(PartnerVO vo) throws Exception{
		return dao.deletePartnerItem(vo);
	}

	public int insertPartnerItem(PartnerVO vo) throws Exception{
		return dao.insertPartnerItem(vo);
	}
	
	public int InsertOrSelectPartnerdata(PartnerVO vo) throws Exception{
		return dao.InsertOrSelectPartnerdata(vo);
	}
	
}
