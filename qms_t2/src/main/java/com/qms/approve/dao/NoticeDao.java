package com.qms.approve.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.qms.approve.vo.NoticeVO;
import com.qms.table.vo.approve.NoticeInfoVO;

@Repository
public interface NoticeDao {
	
	public int selectTotalNoticeCount(NoticeVO vo) throws Exception;
	
	public List<NoticeInfoVO> selectNoticeList(NoticeInfoVO vo) throws Exception;
	
	public List<NoticeVO> selectNoticeSetting(NoticeVO vo) throws Exception;
	
	public int insertNoticeData(NoticeVO vo) throws Exception;
	
	public NoticeVO selectNoticeDetail(NoticeVO vo) throws Exception;

	
}
