package com.qms.item.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

//import com.itextpdf.text.pdf.hyphenation.TernaryTree.Iterator;
import com.qms.item.dao.ItemDao;
import com.qms.item.vo.ItemVO;
import com.qms.item.vo.ProductVO;

@Service
public class ItemService {

	@Autowired
	ItemDao dao;
	
	public int selectTotalItemCount(ItemVO vo) throws Exception{
		return dao.selectTotalItemCount(vo);
	}
	
	public List<ItemVO> selectItemList(ItemVO vo) throws Exception{
		return dao.selectItemList(vo);
	}
	
	//이 밑은 모달관련 함수
	public int selectDuplicateItemCdCheck(ItemVO vo) throws Exception{
		return dao.selectDuplicateItemCdCheck(vo);
	}
	
	public int insertNewItem(ItemVO vo) throws Exception{
		return dao.insertNewItem(vo);
	}
	
	public int updateItemData(ItemVO vo) throws Exception{
		return dao.updateItemData(vo);
	}
	
	public ItemVO selectItemDtlData(ItemVO vo) throws Exception{
		return dao.selectItemDtlData(vo);
	}
	public List<ProductVO> parseExcelFile(MultipartFile file) {
        List<ProductVO> productVOList = new ArrayList<>();
        try (Workbook workbook = new XSSFWorkbook(file.getInputStream())) {
            Sheet sheet = workbook.getSheetAt(0);
            Iterator<Row> rows = sheet.iterator();
            rows.next(); // Skip header row
            while (rows.hasNext()) {
                Row currentRow = rows.next();
                ProductVO productVO = new ProductVO();
                productVO.setNo(currentRow.getCell(0).getNumericCellValue());
                productVO.setItemCd(currentRow.getCell(1).getStringCellValue());
                productVO.setItemName(currentRow.getCell(2).getStringCellValue());
                productVO.setItemType(currentRow.getCell(3).getStringCellValue());
                productVO.setUnitType(currentRow.getCell(4).getStringCellValue());
                productVO.setHscode(currentRow.getCell(5).getNumericCellValue());
                productVO.setBoxType(currentRow.getCell(6).getStringCellValue());
                productVO.setBoxQty(currentRow.getCell(7).getNumericCellValue());
                productVO.setWeight(currentRow.getCell(8).getNumericCellValue());
                productVO.setPlantLine(currentRow.getCell(9).getStringCellValue());
                productVO.setUnitPrice(currentRow.getCell(10).getNumericCellValue());
                productVO.setLocation(currentRow.getCell(11).getStringCellValue());
                productVO.setSubconYn(currentRow.getCell(12).getStringCellValue());
                productVOList.add(productVO);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return productVOList;
    }
	public int deleteitemCd(ItemVO vo)throws Exception{
		return dao.deleteitemCd(vo);
	}
	
	public int insertExcelFile(List<ProductVO> list) throws Exception{
		return dao.insertExcelFile(list);
	}
	
	
}	

	