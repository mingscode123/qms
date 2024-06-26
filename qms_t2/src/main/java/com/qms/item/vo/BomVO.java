package com.qms.item.vo;

import java.util.List;

import com.qms.table.vo.item.BomInfoVO;

import lombok.Data;
@Data
public class BomVO extends BomInfoVO{
	
	
	private List<BomVO> bomlist;
	private String itemName;
	private String regDt;
	private String regUserId;
	private String updDt;
	private String updUserId;
	private String unitType;
	private String plantLine;
	private String boxType;
	private String bomCnt;
	private String boxQty;
	private String itemType;
	private String bomLevel;
	private String sitemCd;
	private String insQty;
	private String sitemName;
	private String iuType;
	
	private List<BomVO> bomDtlList;
	
	private List<BomVO> itemlist;
	private String userId;
}
