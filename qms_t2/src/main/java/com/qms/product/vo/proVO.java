package com.qms.product.vo;

import java.util.List;

import com.qms.table.vo.plan.PlanInfoVO;

import lombok.Data;

@Data
public class proVO extends PlanInfoVO{
	private String compCd;
	private String planDt;
	private String itemCd;
	private String userId;
	private String productQty;
	private String regDt;
	private String regUserId;
	private String updDt;
	private String updUserId;
	private String planDtYY;
	private String planDtMM;
	private String itemName;
	private String compName;
    private String planQty;
    private String orderQty;
    private String insQty;
    private String sitemCd;
    private String sitemName;
    private String productYear;
	private String productMonth;

    // 조건추가
    private List<PlanInfoVO> qtyList;
    
    private List<proVO>itemlist;
    
    private List<proVO> modallist;
	private List<proVO> userlist;
	private String productDt;
	private List<proVO> proList;

    private String planYear;
    private String planMonth;
    
    private String userName;
    private String boxType;
    private String boxQty;
    private String weight;
    
    private String totalQty;

	
}
