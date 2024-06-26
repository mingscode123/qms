package com.qms.util;

public class ExcelConstant {
	
	//엑셀 다운로드할 데이터의 헤더와 컬럼을 상수로 지정
	
	public static final String[] ITEM_HEADER= {"품번","품목명","제품유형","제품단위",
											   "생산라인","BOX 규격","재고위치","등록일"};
	
	//해당 테이블의 모든 컬럼을 넣은 것이 아님 ( 필요에 따라 수정)
	
	public static final String[] ITEM_COLUMN = {"itemCd","itemName","itemType","unitType",
												"plantLine","boxType","location","regDt"};
	
	public static final String[] PARTNER_HEADER= {"거래처코드","거래처명","거래처유형","대표자명",
											      "연락처","이메일","담당자명","담당자연락처","등록일"};
	
	public static final String[] PARTNER_COLUMN = {"compCd","compName","compType","compCeo",
												   "phone","email","mgrName","mgrPhone","regDt"};
	
	public static final String[] USER_HEADER= {"성명","부서","직위","퇴사여부"};
	  

	public static final String[] USER_COLUMN = {"userName","deptName","comName","leaveYn"};
	
	public static final String[] RECEIVE_HEADER= {"품번","품목명","INVOICE_NO","입고수량",
			   "입고단가","재고위치","입고일","입고상태","등록일"};
	
	public static final String[] RECEIVE_COLUMN = {"itemCd","itemName","invoiceNo","inQty",
			"inPrice","comName","inDt","inStatus","regDt"};
	
	public static final String[] DEPT_HEADER= {"부서ID","부서명","상위부서명","할당사용자수",
			   "삭제여부","등록일"};
	
	public static final String[] DEPT_COLUMN = {"deptCd","deptName","upDeptName","userCount",
			"delYn","regDt"};
	
	public static final String[] INVENTORY_HEADER= {"품번","품명","단위","총재고수량"	};

	public static final String[] INVENTORY_COLUMN = {"itemCd","itemName","unitType","inQty"	};
	
	public static final String[] PLAN_HEADER = {"품번","품명"};
	
	public static final String[] PLAN_COLUMN = {"itemCd","itemName"};
	
	public static final String[] PLANSEARCH_HEADER= {"거래처명","품번","품명","SUM"};
	
	public static final String[] PLANSEARCH_COLUMN = {"compName","itemCd","itemName","SUM"};
	
public static final String[] DAILY_ORDER_HEADER = {"거래처명","품번","품명","SUM"};
	
	public static final String[] DAILY_ORDER_COLUMN = {"compName","itemCd","itemName"};
	
	public static final String[] MONTH_PRODUCT_HEADER = {"거래처명","품번","품명","주문수량","계획수량","생산수량"};
	
	public static final String[] MONTH_PRODUCT_COLUMN = {"compName","itemCd","itemName","orderQty","planQty","productQty"};
	
	public static final String[] MTHPRO_HEADER= {"품번","품명","자재품번","자재품명","생산수랑","투입수량","소요수량"};
	
	public static final String[] MTHPRO_COLUMN = {"itemCd","itemName","sitemCd","sitemName","productQty","insQty","demandQty"};
	
	public static final String[] MTHUSE_HEADER= {"품번","품명","자재품번","자재품명","생산수랑","투입수량","소요수량"};
	
	public static final String[] MTHUSE_COLUMN = {"itemCd","itemName","sitemCd","sitemName","productQty","insQty","totalQty"};
	
	
}
