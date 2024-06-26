package com.qms.approve.vo;

import java.util.List;

import lombok.Data;

@Data
public class AprvPageVO {
	private int total;
	private int countPerPage=10;
	private int currentPage =1;
	private int startPage;
	private int endPage;
	private List<Aprv01VO> AprvList;
}
