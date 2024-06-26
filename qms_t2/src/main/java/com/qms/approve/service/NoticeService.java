package com.qms.approve.service;

import java.util.Calendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.qms.approve.dao.NoticeDao;
import com.qms.approve.vo.NoticeVO;
import com.qms.common.service.FileService;
import com.qms.table.vo.approve.AprvFileVO;
import com.qms.table.vo.approve.NoticeInfoVO;
import com.qms.table.vo.common.FileVO;

@Service
public class NoticeService {
	@Autowired
	NoticeDao dao;
	
	
	public int selectTotalNoticeCount(NoticeVO vo) throws Exception{
		return dao.selectTotalNoticeCount(vo);
	}
	
	public List<NoticeInfoVO> selectNoticeList(NoticeInfoVO vo) throws Exception{
		return dao.selectNoticeList(vo);
	}
	
	public List<NoticeVO> selectNoticeSetting(NoticeVO vo) throws Exception{
		return dao.selectNoticeSetting(vo);
	}
	
	public int insertNoticeData(NoticeVO vo) throws Exception{
		return dao.insertNoticeData(vo);
	}
	public NoticeVO selectNoticeDetail(NoticeVO vo) throws Exception{
		return dao.selectNoticeDetail(vo);
	}
	
	
}
