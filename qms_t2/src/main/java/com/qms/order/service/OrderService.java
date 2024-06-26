package com.qms.order.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.itextpdf.text.pdf.PdfStructTreeController.returnType;
import com.qms.approve.vo.Aprv01VO;
import com.qms.order.dao.OrderDao;
import com.qms.order.vo.OrderVO;

@Service
public class OrderService {
	@Autowired
	OrderDao dao;
	//ord01
	public List<OrderVO> selectOrderList(OrderVO vo) throws Exception{
		return dao.selectOrderList(vo);
	}
	
	public int selectTotalOrderCount(OrderVO vo) throws Exception{
		return dao.selectTotalOrderCount(vo);
	}	
	
	//ord01 이 밑으로 모달
	public List<OrderVO> selectModalDtlData(OrderVO vo) throws Exception{
		return dao.selectModalDtlData(vo);
	}
	public int updateStatus(OrderVO vo) throws Exception{
		return dao.updateStatus(vo);
	}
	
	@Transactional
	public int updateOrderDtl(OrderVO vo) throws Exception{
		int cnt1 = dao.deleteOrderItemData(vo);
		
		for (int i = 0; i < vo.getOrderlist().size(); i++) {
			if(vo.getOrderlist().get(i).getItemCd()!=null) {	
				vo.setItemCd(vo.getOrderlist().get(i).getItemCd());
				vo.setOrderQty(vo.getOrderlist().get(i).getOrderQty());
				vo.setOrderPrice(vo.getOrderlist().get(i).getOrderPrice());
				int cnt2 = dao.insertOrderItemData(vo);//결재라인등록
			} 
		}
		return 1;
	}
	
	@Transactional
	public int insertNewOrderDate(OrderVO vo) throws Exception{
		String maxOrderNo = dao.selectMaxOrderNo(vo);
		vo.setOrderNo(maxOrderNo);
		int cnt = dao.insertOrderInfo(vo);
		
		for (int i = 0; i < vo.getOrderlist().size(); i++) {
			if(vo.getOrderlist().get(i).getItemCd()!=null) {	
				vo.setItemCd(vo.getOrderlist().get(i).getItemCd());
				vo.setOrderQty(vo.getOrderlist().get(i).getOrderQty());
				vo.setOrderPrice(vo.getOrderlist().get(i).getOrderPrice());
				int cnt2 = dao.insertOrderItem(vo);
			} 
		}
		return 1;
	}
	
	//ord02
	public List<OrderVO> selectDailyOrderList(OrderVO vo) throws Exception{
		return dao.selectDailyOrderList(vo);
	}
	
}
