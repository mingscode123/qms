package com.qms.dept.vo;

import java.util.List;

import com.qms.table.vo.common.ComCodeVO;
import com.qms.table.vo.user.DeptInfoVO;

import lombok.Data;

@Data
public class DeptVO extends DeptInfoVO{

	private List<DeptVO> deptlist; //부서리스트
	
	private String comGrpCd; 	
	
	private String userCount; 	
	
	private String upDeptName; 	 


	//private List<String> comGrpCdList;
	
	private List<ComCodeVO> positionlist; //직위리스트
	

	
	
	
}
