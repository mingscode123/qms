package com.qms.product.vo;

import java.util.List;

import com.qms.table.vo.product.ProductInfoVO;

import lombok.Data;

@Data
public class ProductVO extends ProductInfoVO{
	public String itemName;
	public String sitemCd;
	public String sitemName;
	public String insQty;
	public String demandQty;
	public String mthProYear;
	public String mthProMonth;
	
	public List<ProductInfoVO> mthProList;
	
	
	
}
