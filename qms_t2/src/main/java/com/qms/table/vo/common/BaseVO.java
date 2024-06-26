package com.qms.table.vo.common;

import lombok.Data;

@Data
public class BaseVO {
	private String regDt;			//등록일
	private String regUserId;		//등록자
	private String updDt;			//수정일
	private String updUserId;		//수정자
	
	// < ----- paging 시작 ------->
	private int total; 				//조회된 데이터 총갯수
	private int countPerPage=10; 	//페이지당 조회수 ( Default : 10개)
	private int currentPage=1; 		//현재페이지
	private int startPage; 			//시작페이지
	private int endPage; 			//종료페이지
	
	public int getStartPage() {
		return currentPage/countPerPage+1;  //페이지의 시작페이지계산
	   }
	
	   public int getEndPage() {
		return total/countPerPage+1;		//페이징의 종료페이지계산
	   }
	// < ----- paging 끝 ------->
}
