package com.qms.plan.vo;

import java.util.List;
import java.util.Map;

import com.qms.table.vo.plan.PlanInfoVO;

import lombok.Data;

@Data
public class planVO extends PlanInfoVO{
	
	private String itemName;
	private String planYear;
	private String planMonth;
	private String compName;
	

	private List<planVO> planlist;
	private String userId;
	
	//추가 부분 시작 (시작이랑 끝부분 복붙해주세여)
	private String palnDtFrom;
	private String palnDtTo;
	private String totalPlanQty;
	private String boxQty;
	private String sitemCd;
	//추가 부분 끝
	List<Map<String, Object>> dataList;
	private String mkPlanYear;
	private String mkPlanMonth;
	private List<PlanInfoVO> mkList;

	

	
}
