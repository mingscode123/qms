package com.qms.approve.vo;

import com.qms.table.vo.approve.AprvLineVO;

import lombok.Data;

@Data
public class Aprv02VO extends AprvLineVO{
	private String userName;			//결재자ID
	private String aprvTypeName;		//결재유형(결재,참조)
	private String aprvStatusName;		//결재상태(결재대기, 결재완료, 반려)
	private String positionCd;
	private String positionCdName;
	private String deptName;
	
	 private String aprvSeq;
	 private String userId;
	
	
	
	

}
