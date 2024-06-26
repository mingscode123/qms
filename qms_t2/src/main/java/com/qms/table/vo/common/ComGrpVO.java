package com.qms.table.vo.common;

import lombok.Data;

@Data
public class ComGrpVO extends BaseVO{

	private String comGrpCd;		//그룹코드
	private String comGrpName;		//그룹명
	private String delYn;			//삭제여부
}
