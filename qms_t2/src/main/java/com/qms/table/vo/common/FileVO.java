package com.qms.table.vo.common;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Data;

@Data
public class FileVO  {

	private String fileCd;		//파일코드 ( 랜덤 20자리 )
	private String middlePath;	//중간경로.
	private String filePath;	//디비저장시
	private String fileNm;		//파일명
	private String orgFileNm;//원본 파일명
	private double fileSize;//파일크기
	
	@JsonIgnore
	private MultipartFile file;	//업로드 파일
	
	@JsonIgnore
	private List<MultipartFile> filelist;	//업로드 파일

	
}
