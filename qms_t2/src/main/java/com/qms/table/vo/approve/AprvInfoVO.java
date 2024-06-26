package com.qms.table.vo.approve;

import com.qms.table.vo.common.BaseVO;

import lombok.Data;

@Data
public class AprvInfoVO extends BaseVO {

	private String docNo;		 //문서번호
	private String userId;		 //사용자ID
	private String docType;		 //문서유형 ( 공통코드 : AP01 )
	private String preserveYear; //보존년한 ( 공통코드 : AP02 )
	private String docClass;	 //문서종류 ( 공통코드 : AP03 )
	private String docStatus;	 //문서상태 ( 공통코드 : AP04 )
	private String title;		 //제목
	private String content;		 //내용
	private String deptName;
	private String userName;
	private String regDt;
	/*private int total; //조회된 데이터 총갯수
	private int countPerPage=10; //페이지당 조회수 ( Default : 10개)
	private int currentPage; //현재페이지
	private int startPage; //시작페이지
	private int endPage; //종료페이지
	
	BaseVO에 있어요
	*/

}
