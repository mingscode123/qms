package com.qms.item.vo;

import java.util.List;

import lombok.Data;

@Data
public class ProductVO {
	
	private  List<ProductVO> productVOList;
	private double no;
	private String itemCd;
	private String itemName;
	private String itemType;
	private String unitType;
	private double hscode;
	private String boxType;
	private double boxQty;
	private double weight;
	private String plantLine; 
	private double unitPrice;
	private String location;
	private String subconYn;
	private String RegUserId;

}
