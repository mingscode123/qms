package com.qms.item.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qms.code.service.CodeService;
import com.qms.item.service.BomService;
import com.qms.item.vo.BomVO;
import com.qms.item.vo.ItemVO;
import com.qms.table.vo.common.ComCodeVO;
import com.qms.table.vo.user.UserInfoVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class BomController {
	@Autowired
	BomService service;
	
	@Autowired
	CodeService cdservice;
	
	
	@RequestMapping("/item/bomlist")
	public String bomlist() throws Exception{
		return "/item/bom01";
		//return "/item/bom01";
	}
	
	@RequestMapping("/item/bom01pop1")
	public String bom01pop01() throws Exception{
		return "/item/bom01pop1";
	} 
	
	@RequestMapping("/selectBomList")
	@ResponseBody
	public BomVO searchlist(@ModelAttribute("ItemVO") ItemVO vo) throws Exception {
		//vo.setComGrpCd(Constant.POSITION_CD);
		int totalPage = service.selectTotalBomCount(vo); 
		List<BomVO> list = service.selectBomList(vo);
		
		BomVO bvo = new BomVO();
		bvo.setBomlist(list);
		bvo.setTotal(totalPage); //총 데이터수.
		bvo.setStartPage(vo.getStartPage()); 
		bvo.setCurrentPage(vo.getCurrentPage());//현재페이지
		return bvo;
	}
	
	@RequestMapping("/selectItemCode")
	@ResponseBody
	public List<ComCodeVO> ItemCode() throws Exception {
		ComCodeVO vo = new ComCodeVO();
		vo.setComGrpCd("IT01");
		List<ComCodeVO> list = cdservice.selectGetdata(vo);
		return list;
	}
	
	    @RequestMapping("/selectBomDtlList")
	    @ResponseBody
	    public BomVO selectBomDtl(@ModelAttribute("BomVO")BomVO vo)throws Exception{

	        vo = service.selectBomDtl(vo); // 모달 헤더 품명

	        vo.setBomDtlList(service.selectBomDtlList(vo)); // 모달 바디 DTL 리스트
	        return vo;
	    }
	    
	@PostMapping("/itemDelInsertAdd")
	@ResponseBody
	public int itemDelInsertAdd(@ModelAttribute  BomVO vo,HttpServletRequest request) throws Exception {
		HttpSession session  = request.getSession();
		UserInfoVO uservo = (UserInfoVO) session.getAttribute("QMSUser");
		vo.setUserId(uservo.getUserId());
		int cnt = 0;
		
		int d = service.deliteItem(vo);
		
		//vo 에 itemlist에 sitemCd ==null 인것을 제거.
		for(int i=vo.getItemlist().size()-1;i>=0;i--) {
			if(vo.getItemlist().get(i).getSitemCd()==null || vo.getItemlist().get(i).getSitemCd().equals("")) {
				vo.getItemlist().remove(i);
			} 
		}
		int i = service.insertNewBom(vo);
		cnt = service.itemNewInsertAdd(vo);
		return cnt;
	}
	


	







}

