package com.qms.table.vo.approve;

import com.qms.table.vo.common.BaseVO;

import lombok.Data;

@Data
public class NoticeInfoVO extends BaseVO{
	private String noticeSeq;		//게시글순번
	private String userId;			//사용자id
	private String noticeType;		//문서종류 ( NT01 )
	private String title;			//제목
	private String content;			//내용
	private String filePath;		//첨부파일경로
	private String fileName;		//파일명
	private String delYn;			//삭제여부
	
}
