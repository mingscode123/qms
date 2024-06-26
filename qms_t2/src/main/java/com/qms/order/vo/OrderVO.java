package com.qms.order.vo;

import java.util.List;

import com.qms.table.vo.common.BaseVO;

import lombok.Data;

@Data
public class OrderVO extends BaseVO{
	//임시 인포테이블
	private String orderNo; 	 
	private String compCd; 	 
	private String orderStatus; 	 
	private String regDt; 	 
	private String regUserId; 	 
	private String updDt; 	 
	private String updUserId; 	 
	private String deliveryDt;
	
	//임시 인포테이블
	private String itemCd; 	 
	private String orderQty; 	 
	private String orderPrice; 	 
	
	
	private String deliveryDtFrom;
	private String deliveryDtTo;
	private String compName; 	
	private String unitPrice; 	
	private String itemName; 	
	private String boxType; 	
	private String boxQty; 	
	private String userId; 	
	private List<OrderVO> orderlist;
	
	
	
}
