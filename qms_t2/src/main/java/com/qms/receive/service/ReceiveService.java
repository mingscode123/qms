package com.qms.receive.service;

import java.util.List;

import org.apache.poi.sl.usermodel.Sheet;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itextpdf.text.Font;
import com.itextpdf.text.pdf.codec.Base64.OutputStream;
import com.qms.receive.dao.ReceiveDao;
import com.qms.receive.vo.RcvVO;
import com.qms.receive.vo.ReceiveVO;
import com.qms.table.vo.item.ItemInfoVO;
import com.qms.table.vo.receive.RcvItemVO;


@Service
public class ReceiveService {
	@Autowired
	ReceiveDao dao;
	
	public int selectTotalReceiveCount(ReceiveVO vo) throws Exception{
		return dao.selectTotalReceiveCount(vo);
	}
	
	public List<RcvItemVO> selectReceiveList(RcvItemVO vo) throws Exception{
		return dao.selectReceiveList(vo);
	}
	
	public int selectTotalRcvCount(RcvVO vo) throws Exception{
		return dao.selectTotalRcvCount(vo);
	}
	
	public List<RcvVO> selectRcvList(RcvVO vo) throws Exception{
		return dao.selectRcvList(vo);
	}
	public List<RcvVO> selectRcvClickList(RcvVO vo) throws Exception {
		return dao.selectRcvClickList(vo);
	}
	public int delitercv(RcvVO vo) throws Exception {
		return dao.delitercv(vo);
	}
	public int RCVNewInsertAdd(RcvVO vo) throws Exception {
		return dao.RCVNewInsertAdd(vo);
	}
	
}
