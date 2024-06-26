package com.qms.table.vo.product;

import com.qms.table.vo.common.BaseVO;

import lombok.Data;

@Data
public class ProductInfoVO extends BaseVO{
		private String compCd;
		private String productQty;
		private String planDt;
		private String itemCd;
		private String userId;
		private String regDt;
		private String regUserId;
		private String updDt;
		private String updUserId;
		
}
