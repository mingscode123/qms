package com.qms.table.vo.common;

import lombok.Data;

@Data
public class MessageVO {
	private boolean result;
	private String msg;
	
	public boolean isResult() {
		return result;
	}
	public void setResult(boolean result) {
		this.result = result;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	
	
	
	
	
}
