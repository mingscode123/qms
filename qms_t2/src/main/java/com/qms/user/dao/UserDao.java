package com.qms.user.dao;

import java.util.List;

import org.mybatis.spring.annotation.MapperScan;

import com.qms.dept.vo.DeptVO;
import com.qms.table.vo.user.UserInfoVO;
import com.qms.user.vo.UserVO;

@MapperScan(basePackages="com.qms.user.dao")
public interface UserDao {
	
	public int selectTotalUserCount(UserVO vo) throws Exception;
	
	public List<UserInfoVO> selectUserList(UserInfoVO vo) throws Exception;
	
	public List<DeptVO> selectDeptList(DeptVO vo) throws Exception;
	
	public UserVO selectGetUserDtlData(UserVO vo) throws Exception;
	
	public int updateUserdata(UserVO vo) throws Exception;
	
	public int insertNewUserdata(UserVO vo) throws Exception;
	
	public String selectchkId(UserVO vo) throws Exception;
}
