package com.qms.login.dao;

import org.mybatis.spring.annotation.MapperScan;

import com.qms.table.vo.user.UserInfoVO;
import com.qms.user.vo.UserVO;

@MapperScan(basePackages="com.qms.login.dao")
public interface LoginDao {
	
	public UserVO selectUserInfo(UserVO vo) throws Exception;
	
	public int updateUserPwd(UserInfoVO vo) throws Exception;
	
}
