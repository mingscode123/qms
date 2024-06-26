package com.qms.approve.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.qms.table.vo.approve.AprvInfoVO;
import com.qms.table.vo.common.ComCodeVO;

import lombok.Data;

@Data
public class AprvFiVO extends AprvInfoVO{
	private String docNo;
	private String fileSeq;
	private String filePath;
	private String fileName;
	private String fileSize;
	private String regUserId;
}
