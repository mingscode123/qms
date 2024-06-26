package com.qms.item.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.qms.table.vo.common.ComCodeVO;
import com.qms.table.vo.item.ItemInfoVO;

import lombok.Data;

@Data
public class ItemVO extends ItemInfoVO{

	private List<ItemVO> itemlist; //아이템리스트
	
	private List<ComCodeVO> itemtypelist; //아이템리스트
	private List<ComCodeVO> unitlist; //제품타입리스트
	private List<ComCodeVO> boxlist; //박스호수리스트
	private List<ComCodeVO> plantlist; //생산라인리스트
	private List<ComCodeVO> locationlist; //장소리스트
	
	private String comName; 	 
	private String delYn; 
	
	private List<String> comGrpCdList;
	
	@JsonIgnore
	private MultipartFile excelInput;
	
	
	
	
}
