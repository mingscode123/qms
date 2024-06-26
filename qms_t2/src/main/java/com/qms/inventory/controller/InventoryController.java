package com.qms.inventory.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.qms.code.service.CodeService;
import com.qms.excel.service.ExcelService;
import com.qms.inventory.service.InventoryService;
import com.qms.inventory.vo.InventoryVO;
import com.qms.table.vo.common.ComCodeVO;
import com.qms.util.Constant;
import com.qms.util.ExcelConstant;

@Controller
public class InventoryController {

    @Autowired
    InventoryService service;

    @Autowired
    CodeService codeService;

    @Autowired
    private ExcelService excelService;

    @RequestMapping("/inventory/list")
    public String inventorylist(Model model) throws Exception {
        model.addAttribute("baseYear", Constant.BASE_YEAR);
        return "inventory/inv01";
    }

    @RequestMapping("/inventory/searchlist")
    @ResponseBody
    public InventoryVO searchlist(@ModelAttribute("InventoryVO") InventoryVO vo) throws Exception {
        vo.setComGrpCd(Constant.UNIT_TYPE);
        vo.setInDt(vo.getInDtYear() + vo.getInDtMonth());

        int totalPage = service.selectTotalInvCount(vo);
        List<InventoryVO> list = service.selectInvList(vo);

        vo.setInvlist(list);
        vo.setTotal(totalPage);  // 총 데이터 수
        vo.setStartPage(vo.getStartPage());
        vo.setCurrentPage(vo.getCurrentPage());  // 현재 페이지

        return vo;
    }

    @RequestMapping("/inventory/getLocation")
    @ResponseBody
    public InventoryVO getLocation() throws Exception {
        ComCodeVO vo = new ComCodeVO();
        vo.setComGrpCd(Constant.LOCATION);
        List<ComCodeVO> locationlist = codeService.selectGetdata(vo);

        InventoryVO invvo = new InventoryVO();
        invvo.setLocationlist(locationlist);

        return invvo;
    }

    @PostMapping("/inventory/excelDownload")
    public ResponseEntity<byte[]> downloadExcel(@ModelAttribute("InventoryVO") InventoryVO vo) throws Exception {
        ComCodeVO cvo = new ComCodeVO();
        cvo.setComGrpCd(Constant.LOCATION);
        List<ComCodeVO> locationlist = codeService.selectGetdata(cvo);
        vo.setLocationlist(locationlist);

        vo.setInDt(vo.getInDtYear() + vo.getInDtMonth());

        Map<String, Object> parameters = new HashMap<>();
        parameters.put("comGrpCd", Constant.UNIT_TYPE);
        parameters.put("itemCd", vo.getItemCd());
        parameters.put("inDt", vo.getInDt());

        List<Map<String, Object>> dataList = excelService.selectInvListTOexcel(parameters);
      
        for(int i=0;i<dataList.size();i++) {
        	dataList.get(i).put("inQty_"+dataList.get(i).get("location"), dataList.get(i).get("inQty"));
        	for(int j=i+1;j<dataList.size();j++) {
        		if(dataList.get(i).get("itemCd").equals(dataList.get(j).get("itemCd"))) {
        			dataList.get(i).put("inQty_"+dataList.get(j).get("location"), dataList.get(j).get("inQty"));
        		}
        	}
        }
        
        //중복 자료 제거
        for(int i=dataList.size()-1;i>=0;i--) {
        	for(int j=0;j>i;i++) {
        		if(dataList.get(i).get("itemCd").equals(dataList.get(j).get("itemCd"))) {
        			dataList.remove(i);
        		}
        	}
        }
       
        String[] headersLocation = new String[vo.getLocationlist().size()];
        String[] headersLocationCd = new String[vo.getLocationlist().size()];
        for (int i = 0; i < vo.getLocationlist().size(); i++) {
            headersLocation[i] = vo.getLocationlist().get(i).getComName();
            headersLocationCd[i] = "inQty_" + vo.getLocationlist().get(i).getComCd();
        }

        String[] headersDefault = ExcelConstant.INVENTORY_HEADER;
        String[] headers = mergeArrays(headersDefault, headersLocation);
        String[] columnsDefault = ExcelConstant.INVENTORY_COLUMN;
        String[] columns = mergeArrays(columnsDefault, headersLocationCd);
        String sheetName = "재고 조회";
        String fileName = "inventory_data.xlsx";

        
        return excelService.createExcelFile(dataList, columns, headers, fileName, sheetName);
    }

    private String[] mergeArrays(String[] array1, String[] array2) {
        String[] mergedArray = new String[array1.length + array2.length];
        System.arraycopy(array1, 0, mergedArray, 0, array1.length);
        System.arraycopy(array2, 0, mergedArray, array1.length, array2.length);
        return mergedArray;
    }

}
