package com.qms.inventory.vo;

import java.util.List;

import com.qms.table.vo.common.ComCodeVO;
import com.qms.table.vo.item.ItemInfoVO;

import lombok.Data;

@Data
public class InventoryVO extends ItemInfoVO{

	private List<InventoryVO> invlist; //아이템리스트
	
	private String inQty; 	 
	
	private String inDt;
	
	private String inDtYear;
	
	private String inDtMonth;
	
	private String comGrpCd; 	 

	//private List<String> comGrpCdList;
	
	private List<ComCodeVO> locationlist; //장소리스트
	

	
	
	
}
