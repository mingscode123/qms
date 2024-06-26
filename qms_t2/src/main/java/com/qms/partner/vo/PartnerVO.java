package com.qms.partner.vo;

import java.util.List;

import com.qms.item.vo.ItemVO;
import com.qms.table.vo.system.PartnerInfoVO;

import lombok.Data;

@Data
public class PartnerVO extends PartnerInfoVO{

	private List<PartnerVO> partnerlist; //파트너리스트
	private List<ItemVO> itemlist; //아이템리스트
	
	private String regDtFrom;	//등록일From
	private String regDtTo;	//등록일To

	private String userId;
	
	private List<String> comGrpCdList;
	
	private String itemCd;
	private String itemName;
	private String unitType;
	private String boxType;
	private String boxQty;
	private String weight;
	private String unitPrice;
	private String location;

	

}
