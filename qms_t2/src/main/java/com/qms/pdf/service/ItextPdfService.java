package com.qms.pdf.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qms.pdf.dao.ItextPdfDao;
import com.qms.pdf.vo.ItextPdfVO;


@Service
public class ItextPdfService {

	@Autowired
	ItextPdfDao dao;
	
	public ItextPdfVO selectInvoiceData(ItextPdfVO vo) throws Exception{
		return dao.selectInvoiceData(vo);
	}
	
	
		
}
