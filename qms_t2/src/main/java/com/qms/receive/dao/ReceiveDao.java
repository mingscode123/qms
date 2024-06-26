package com.qms.receive.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.qms.receive.vo.RcvVO;
import com.qms.receive.vo.ReceiveVO;
import com.qms.table.vo.receive.RcvItemVO;

@Repository
public interface ReceiveDao {

	
	public int selectTotalReceiveCount(ReceiveVO vo) throws Exception;
	
	public List<RcvItemVO> selectReceiveList(RcvItemVO vo) throws Exception;
	
	public int selectTotalRcvCount(RcvVO vo) throws Exception;
	
	public List<RcvVO> selectRcvList(RcvVO vo) throws Exception;
	
	public List<RcvVO> selectRcvClickList(RcvVO vo) throws Exception; //xml
	
	public int delitercv(RcvVO vo) throws Exception ;
	public int RCVNewInsertAdd(RcvVO vo) throws Exception ;

}
