package com.qms.table.vo.user;

import com.qms.table.vo.common.BaseVO;

import lombok.Data;

@Data
public class UserInfoVO extends BaseVO{
	private String userId;		//사용자ID
	private String userName;	//사용자명
	private String deptCd;		//부서코드
	private String positionCd;	//직위코드 ( 공통코드 : US01 )
	private String userPwd;		//패스워드
	private String phone;		//전화번호
	private String email;		//이메일
	private String leaveDt;		//퇴사일
	private String leaveYn;		//퇴사여부
	
	
	
}
