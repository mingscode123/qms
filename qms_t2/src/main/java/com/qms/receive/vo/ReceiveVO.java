package com.qms.receive.vo;

import java.util.List;

import com.qms.table.vo.receive.RcvItemVO;

import lombok.Data;

@Data
public class ReceiveVO extends RcvItemVO {
	
	private String itemName;
	private String invoiceNo;
	private String inDt;
	private String inStatus;
	private String compCd;
	
	private String comName;
	private String comCd;
	private String comGrpCd;
	
	private String regDtFrom;
	private String regDtTo;
	private List<RcvItemVO> receivelist;
	
}
