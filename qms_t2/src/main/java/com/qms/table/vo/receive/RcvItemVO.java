package com.qms.table.vo.receive;

import com.qms.table.vo.common.BaseVO;

import lombok.Data;

@Data
public class RcvItemVO extends BaseVO {
	private String rcvNo;			//입고번호
	private String itemCd;			//자재번호
	private String inQty;			//입고수량*
	private String inPrice;			//입고단가*
	private String location;		//재고위치
}
