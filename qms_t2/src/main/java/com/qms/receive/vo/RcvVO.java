package com.qms.receive.vo;

import java.util.List;

import com.qms.table.vo.receive.RcvInfoVO;

import lombok.Data;

@Data
public class RcvVO extends RcvInfoVO{

	private List<RcvVO> rcvlist; 
	
	
	private String userId;
	private String rcvNo;			//입고번호
	private String itemCd;			//자재번호
	private String inQty;			//입고수량*
	private String inPrice;			//입고단가*
	private String location;		//재고위치
	
	private String compName;//거래처명
	
	/*private String regDt;//등록일
	private String regUserId;//등록유저
	private String uptDt;//업데이트일
	private String uptUserId;//업데이트유저
	baseVO에서 상속*/
	
	private String totalPrice;//총금액
	private String itemCnt;//품목수
	
	private String inDtFrom;//입고날짜From
	private String inDtTo;//입고날짜To
	
	private String itemName;
	private String boxType;
	private String boxQty;
	
	private List<RcvVO> headlist;

	

	
	
	
}
