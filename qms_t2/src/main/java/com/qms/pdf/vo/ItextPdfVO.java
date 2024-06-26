package com.qms.pdf.vo;
import lombok.Data;

@Data
public class ItextPdfVO {
	//PDF공통적으로 필요한 인자
    private String pdfFileName; // pdf 파일명
    
	//인보이스에 들어가는 데이터
	private String rcvNo;			//입고번호*
	private String invoiceNo;		//인보이스번호
	private String shipper;			//송하인
	private String consignee;		//수하인
	private String notiParty;		//착하통지처
	private String portLoad;		// 선적항
	private String finalDest;		//도착지
	private String carrier;			//배이름
	private String remark;			//비고
	
	//그 외 필요한 서식 추가

}