package com.qms.approve.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.qms.table.vo.approve.NoticeInfoVO;
import com.qms.table.vo.common.ComCodeVO;

import lombok.Data;

@Data
public class NoticeVO extends NoticeInfoVO{
	
	
	private List<NoticeInfoVO> noticelist; //공지사항리스트
	
	private String deptName;        //부서이름
	
	private String userName;		//작성자
	
    private String comName;	
    private String comCd;
    private String comGrpCd;
	
    @JsonIgnore
	private MultipartFile atcfile;	//첨부파일
    
    private List<ComCodeVO> typelist;
}
