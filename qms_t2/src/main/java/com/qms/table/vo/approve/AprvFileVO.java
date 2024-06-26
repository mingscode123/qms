package com.qms.table.vo.approve;

import com.qms.table.vo.common.BaseVO;

import lombok.Data;

@Data
public class AprvFileVO extends BaseVO {
	private String docNo;
	private String fileSeq;
	private String filePath;
	private String fileName;
	private String fileSize;
}
