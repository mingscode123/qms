package com.qms.approve.dao;

import java.util.List;

import org.mybatis.spring.annotation.MapperScan;

import com.qms.approve.vo.Aprv01VO;
import com.qms.approve.vo.Aprv02VO;
import com.qms.table.vo.approve.AprvFileVO;
import com.qms.table.vo.approve.AprvInfoVO;
import com.qms.table.vo.approve.AprvLineVO;


@MapperScan(basePackages="com.qms.approve.dao")
public interface ApproveDao {
	public List<Aprv01VO> getDocStatus(AprvInfoVO vo) throws Exception;
	public Aprv01VO selectDocDetail(Aprv01VO vo) throws Exception;
	
	public List<Aprv02VO> selectAprvLineList(Aprv01VO vo) throws Exception;
	
	public List<AprvFileVO> selectAprvFileList(Aprv01VO vo) throws Exception;
	
	public String selectMaxDocNo(Aprv01VO vo) throws Exception;
	
	public int insertDocInfoData(Aprv01VO vo) throws Exception;
	public int insertLineInfoData(AprvLineVO vo) throws Exception;
	public int insertFileInfoData(AprvFileVO vo) throws Exception;
	
	public List<Aprv01VO> selectAprvIng(Aprv01VO vo) throws Exception;
	public List<Aprv01VO> selectAprvDone(Aprv01VO vo) throws Exception;
	public int UpdateAgreeStatus(Aprv01VO vo) throws Exception;
	public int UpdatePassStatus(Aprv01VO vo) throws Exception;
	public int UpdatePassDoc(Aprv01VO vo) throws Exception;
	public int UpdateAgreeDoc(Aprv01VO vo) throws Exception;
	public int UpdateNextAprv(Aprv01VO vo) throws Exception;
	public int selectTotalAprvingCount(Aprv01VO vo)throws Exception;
	public int selectTotalAprvedCount(Aprv01VO vo)throws Exception;
	public int selectTotalMyAprvCount(Aprv01VO vo)throws Exception;
}

	