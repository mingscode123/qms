package com.qms.table.vo.common;

import lombok.Data;

@Data
public class ComCodeVO extends BaseVO{

	private String comGrpCd;		//그룹코드
	private String comCd;			//공통코드
	private String comName;			//코드명
	private String memo;			//메모
	private String delYn;			//삭제여부
}
