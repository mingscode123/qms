package com.qms.item.dao;

import java.util.List;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.web.multipart.MultipartFile;

import com.qms.item.vo.ItemVO;
import com.qms.item.vo.ProductVO;

@MapperScan(basePackages="com.qms.item.dao")
public interface ItemDao {
	
	public int selectTotalItemCount(ItemVO vo) throws Exception;
	
	public List<ItemVO> selectItemList(ItemVO vo) throws Exception;
	
	
	//이 밑은 모달관련 함수
	public int selectDuplicateItemCdCheck(ItemVO vo) throws Exception;
	public int insertNewItem(ItemVO vo) throws Exception;
	public int updateItemData(ItemVO vo) throws Exception;
	public ItemVO selectItemDtlData(ItemVO vo) throws Exception;
	public List<String> parseExcelFile(MultipartFile file);
	public int deleteitemCd(ItemVO vo)throws Exception;
	public int insertExcelFile(List<ProductVO> list) throws Exception;
}
