package com.qms.table.vo.user;

import com.qms.table.vo.common.BaseVO;

import lombok.Data;

@Data
public class DeptInfoVO extends BaseVO{
	private String deptCd;
	private String deptName;
	private String upDeptCd;
	private String delYn;
}
