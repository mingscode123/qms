package com.qms.user.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qms.dept.vo.DeptVO;
import com.qms.table.vo.user.UserInfoVO;
import com.qms.user.dao.UserDao;
import com.qms.user.vo.UserVO;

@Service
public class UserService {

	@Autowired
	UserDao dao;
	
	public int selectTotalUserCount(UserVO vo) throws Exception{
		return dao.selectTotalUserCount(vo);
	}
	
	public List<UserInfoVO> selectUserList(UserInfoVO vo) throws Exception{
		return dao.selectUserList(vo);
	}
	
	public UserVO selectGetUserDtlData(UserVO vo) throws Exception{
		return dao.selectGetUserDtlData(vo);
	}
	
	public int updateUserdata(UserVO vo) throws Exception{
		return dao.updateUserdata(vo);
	}
	
	public int insertNewUserdata(UserVO vo) throws Exception{
		return dao.insertNewUserdata(vo);
	}
	
	public String selectchkId(UserVO vo) throws Exception{
		return dao.selectchkId(vo);
	}
	
	public List<DeptVO> selectDeptList(DeptVO vo) throws Exception{
		return dao.selectDeptList(vo);
	}

}
