package com.qms.pdf.dao;

import org.mybatis.spring.annotation.MapperScan;

import com.qms.pdf.vo.ItextPdfVO;


@MapperScan(basePackages="com.qms.pdf.dao")
public interface ItextPdfDao {	
	public ItextPdfVO selectInvoiceData(ItextPdfVO vo) throws Exception;

}

	