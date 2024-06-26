package com.qms.approve.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.qms.table.vo.approve.AprvFileVO;
import com.qms.table.vo.approve.AprvInfoVO;
import com.qms.table.vo.common.ComCodeVO;

import lombok.Data;

@Data
public class Aprv01VO extends AprvInfoVO{

	private List<ComCodeVO> doclist;		//문서유형 리스트
	private List<ComCodeVO> yearlist;		//보존년한 리스트
	private List<ComCodeVO> classlist;	   //
	private List<ComCodeVO> statuslist;
	
	private String userName;
	private String deptName;
	private String aprvUserId;
	
	
	private boolean isAprv;	//현재 결재 진행중인가.
	
	//공통코드명
	private String docTypeName;
	private String preserveYearName;
	private String docClassName;
	private String docStatusName;
	
	private String searchType;		//검색유형 : 0>결재진행중, 1:결재완료, 2:나의기안서		
	
	//결재중
	private List<Aprv02VO> listing;
	//결재라인
	private List<Aprv02VO> linelist;
	//첨부파일
	@JsonIgnore
	private List<MultipartFile> upfilelist;
	private List<AprvFileVO> filelist;
	private List<Aprv01VO> AprvList; //페이징
	
	private String lineId; // 결재자 이름
	
	private String iutype; // 모달 form이름
	
	private String opinion; // 결재의견
	private String aprvSeq;
	private String comName;
	
}
