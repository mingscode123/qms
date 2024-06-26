package com.qms.common.service;

import org.springframework.stereotype.Service;

import com.qms.table.vo.common.FileVO;
import com.qms.util.Constant;
import com.qms.util.FileUploadUtil;

@Service
public class FileService {

	
	public FileVO createFile(FileVO vo) throws Exception {

		
		//Constant랑 FileUploadUtil은 static이라서 객체 생성없이 사용가능
		String fileCd="", fileExt="";
		
		if (!vo.getFile().getOriginalFilename().isEmpty()) {
			
			fileCd = FileUploadUtil.getUuid();
			fileExt = vo.getFile().getOriginalFilename().substring(vo.getFile().getOriginalFilename().lastIndexOf("."),vo.getFile().getOriginalFilename().length());
			
			vo.setFileCd(fileCd);
			vo.setFileNm(fileCd+fileExt);
			vo.setFilePath(Constant.FILE_PATH+"/"+vo.getMiddlePath()+"/"+vo.getFileNm());
			vo.setOrgFileNm(vo.getFile().getOriginalFilename());
			vo.getFile().getSize();
			
			//File upload
			FileUploadUtil.uploadFormFile(vo);
			
		}
		
		return vo;
	}
	
	
}
