package com.qms.table.vo.receive;

import com.qms.table.vo.common.BaseVO;

import lombok.Data;

@Data
public class RcvInfoVO extends BaseVO {

	private String rcvNo;			//입고번호*
	private String invoiceNo;		//인보이스번호
	private String compCd;			//거래처코드*
	private String inDt;			//입고일*
	private String inStatus;		//입고상태(S:대기,P:입고중,E:입고완료)
	private String shipper;			//송하인
	private String consignee;		//수하인
	private String notiParty;		//착하통지처
	private String portLoad;		// 선적항
	private String finalDest;		//도착지
	private String carrier;			//배이름
	private String remark;			//비고
	
}
