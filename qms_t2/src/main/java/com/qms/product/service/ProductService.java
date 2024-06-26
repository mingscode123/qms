package com.qms.product.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qms.product.dao.ProductDao;
import com.qms.product.vo.ProductVO;
import com.qms.product.vo.proVO;
import com.qms.table.vo.product.ProductInfoVO;

@Service
public class ProductService {

	@Autowired
	ProductDao dao;
	public List<proVO> selectPartnerInfo(proVO vo)throws Exception{
		return dao.selectPartnerInfo(vo);
	}
	public List<proVO> selectProductInfo(proVO vo)throws Exception{
		return dao.selectProductInfo(vo);
	}
	public List<proVO> selectModalInfo(proVO vo)throws Exception{
		return dao.selectModalInfo(vo);
	}
	public List<proVO> selectAllUser(proVO vo)throws Exception{
		return dao.selectAllUser(vo);
	}
	public int deleteItem(proVO vo)throws Exception{
		return dao.deleteItem(vo);
	}
	public int insertItem(proVO vo)throws Exception{
		return dao.insertItem(vo);
	}
	public List<proVO> selectUseBomInfo(proVO vo)throws Exception{
		return dao.selectUseBomInfo(vo);
	}
	
	public List<ProductInfoVO> selectMonthlyProductList(ProductVO vo) throws Exception{
		return dao.selectMonthlyProductList(vo);
	}
	public int selectTotalMthProCount(ProductVO vo) throws Exception{
		return dao.selectTotalMthProCount(vo);
	}
	public List<proVO> selectMonthProList(proVO vo) throws Exception{
		return dao.selectMonthProList(vo);
	}
	/*public int selectTotalMonthProCount(proVO vo) throws Exception{
		return dao.selectTotalMonthProCount(vo);
	}*/
}	

	