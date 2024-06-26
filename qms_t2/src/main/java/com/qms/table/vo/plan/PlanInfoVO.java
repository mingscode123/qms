package com.qms.table.vo.plan;

import com.qms.table.vo.common.BaseVO;

import lombok.Data;

@Data
public class PlanInfoVO extends BaseVO{
	
	private String compCd;
	private String planDt;
	private String itemCd;
	private String planQty;
	private String orderQty;
	private String regDt;
	private String regUserId;
	private String updDt;
	private String updUserId;
}
