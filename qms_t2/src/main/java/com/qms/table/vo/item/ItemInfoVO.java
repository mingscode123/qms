package com.qms.table.vo.item;

import com.qms.table.vo.common.BaseVO;

import lombok.Data;

@Data
public class ItemInfoVO extends BaseVO {
	
	private String no;
	private String itemCd;
	private String itemName;
	private String itemType;
	private String unitType;
	private String hscode;
	private String boxType;
	private String boxQty;
	private String weight;
	private String plantLine; 
	private String unitPrice;
	private String location;
	private String subconYn;
}
