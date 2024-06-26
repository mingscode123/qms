package com.qms.product.dao;

import java.util.List;

import org.mybatis.spring.annotation.MapperScan;

import com.qms.product.vo.ProductVO;
import com.qms.product.vo.proVO;
import com.qms.table.vo.product.ProductInfoVO;

@MapperScan(basePackages="com.qms.product.dao")
public interface ProductDao {
	
	public List<proVO> selectProductInfo(proVO vo) throws Exception;
	public List<proVO> selectPartnerInfo( proVO vo)throws Exception;
	public List<proVO> selectModalInfo(proVO vo)throws Exception;
	public List<proVO> selectAllUser(proVO vo)throws Exception;
	public int deleteItem(proVO vo)throws Exception;
	public int insertItem(proVO vo)throws Exception;
	public List<proVO> selectUseBomInfo(proVO vo)throws Exception;
	public List<ProductInfoVO> selectMonthlyProductList(ProductVO vo) throws Exception;
	public int selectTotalMthProCount(ProductVO vo) throws Exception;
	public List<proVO> selectMonthProList(proVO vo) throws Exception;
	//public int selectTotalMonthProCount(proVO vo) throws Exception;
	
	
}
