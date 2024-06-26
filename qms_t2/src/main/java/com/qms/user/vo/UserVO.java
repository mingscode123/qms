package com.qms.user.vo;

import java.util.List;

import com.qms.dept.vo.DeptVO;
import com.qms.table.vo.common.ComCodeVO;
import com.qms.table.vo.user.UserInfoVO;

import lombok.Data;
@Data
public class UserVO  extends UserInfoVO{
	
	private List<UserInfoVO> userlist; //유저리스트
	private List<DeptVO> deptlist; 
	private List<ComCodeVO> positionlist; 
	
	private String deptName;	 //부서이름
	private String deptCd;	 
	
	private String comName; 	 
	
	private String comGrpCd; 	 
	
	private String positionCd; 	 
	
	private String regDtFrom; 	 
	private String regDtTo; 	 
	
	private String updUserId; 	 
	
	
	

}
