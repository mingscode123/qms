package com.qms.table.vo.system;

import com.qms.table.vo.common.BaseVO;

import lombok.Data;

//거래처정보
@Data
public class PartnerInfoVO extends BaseVO {
	private String compCd;		//거래처코드
	private String compName;	//거래처명
	private String compType; 	// 거래처유형 C:CUSTOMER, S:SUPPLIER 
	private String bizNo;		//사업자등록번호
	private String tradeYn;		//거래여부
	private String compCeo;		//대표명
	private String phone;		//연락처
	private String email;		//이메일
	private String addr;		//주소
	private String mgrName;		//담당자
	private String mgrPosition;	//담당자 직급/직위
	private String mgrPhone;	// 담당자연락처	
	private String delYn;		// 삭제여부
}
