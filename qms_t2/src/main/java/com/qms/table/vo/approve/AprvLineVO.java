package com.qms.table.vo.approve;

import com.qms.table.vo.common.BaseVO;

import lombok.Data;

@Data
public class AprvLineVO extends BaseVO{
	private String docNo;			//문서번호
	private String aprvSeq;			//결재순번
	private String userId;			//결재자ID
	private String aprvType;		//결재유형(결재,참조)
	private String aprvStatus;		//결재상태(결재대기, 결재완료, 반려)
	private String opinion;			//결재의견
}
