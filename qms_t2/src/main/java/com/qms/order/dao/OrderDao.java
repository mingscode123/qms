package com.qms.order.dao;

import java.util.List;

import org.mybatis.spring.annotation.MapperScan;

import com.qms.order.vo.OrderVO;

@MapperScan(basePackages="com.qms.order.dao")
public interface OrderDao {
	//ord01
	public List<OrderVO> selectOrderList(OrderVO vo) throws Exception;
	public int selectTotalOrderCount(OrderVO vo) throws Exception;
	
	//ord01 이 밑으로 모달
	public List<OrderVO> selectModalDtlData(OrderVO vo) throws Exception;
	public int updateStatus(OrderVO vo) throws Exception;
	public int deleteOrderItemData(OrderVO vo) throws Exception;
	public int insertOrderItemData(OrderVO vo) throws Exception;
	
	public String selectMaxOrderNo(OrderVO vo) throws Exception;
	public int insertOrderItem(OrderVO vo) throws Exception;
	public int insertOrderInfo(OrderVO vo) throws Exception;
	
	
	//ord02
	public List<OrderVO> selectDailyOrderList(OrderVO vo) throws Exception;
	
	
	

}
	