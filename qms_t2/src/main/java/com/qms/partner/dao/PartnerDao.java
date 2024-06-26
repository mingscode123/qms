package com.qms.partner.dao;

import java.util.List;

import org.mybatis.spring.annotation.MapperScan;

import com.qms.item.vo.ItemVO;
import com.qms.partner.vo.PartnerVO;


@MapperScan(basePackages="com.qms.partner.dao")
public interface PartnerDao {
	
	public int selectTotalPartnerCount(PartnerVO vo) throws Exception;
	
	public List<PartnerVO> selectPartnerList(PartnerVO vo) throws Exception;
	
	
	//모달
	
	public PartnerVO selectPartnerDtldata(PartnerVO vo) throws Exception;
	
	public List<ItemVO> selectPartnerItemList(PartnerVO vo) throws Exception; 
	
	public int deletePartnerItem(PartnerVO vo) throws Exception;
	
	public int insertPartnerItem(PartnerVO vo) throws Exception;
	
	public int InsertOrSelectPartnerdata(PartnerVO vo) throws Exception;
}
	