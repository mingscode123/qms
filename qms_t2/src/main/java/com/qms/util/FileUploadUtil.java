package com.qms.util;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.qms.table.vo.common.FileVO;

public class FileUploadUtil {
	
	/** logger **/
	private static Logger logger = LoggerFactory.getLogger(FileUploadUtil.class);

	public static void uploadFormFile(FileVO vo) {
		//MultipartFile formFile, String realPath, String resizePath, String filename, int width, int height
		File dirFile = new File(Constant.UPLOAD_PATH +"/"+vo.getMiddlePath());
		//Constant.UPLOAD_PATH = c:/workspace/uploadfile
		//vo.getMiddlePath() = /notice/4자리 년도와 2자리 월
		if (!dirFile.exists()) {
			dirFile.mkdirs();
		}
		//exists()함수는 존재여부확인 함수
		File file = new File(Constant.UPLOAD_PATH+"/"+vo.getMiddlePath(), vo.getFileNm());
		
		
		//vo.setFileNm(fileNm);
		//file = createUniqueFile(file);
		
		try {
			
			// 파일 용량 구하기(byte)
	        long fileSize = vo.getFile().getSize();
			/** [정수] byte, short, int, long    [실수] double, float **/
			double bytes = fileSize; //file.length();
			double kilobytes = (bytes / 1024);
			double megabytes = (kilobytes / 1024);
			double gigabytes = (megabytes / 1024);
			double terabytes = (gigabytes / 1024);
			double petabytes = (terabytes / 1024);
			double exabytes = (petabytes / 1024);
			double zettabytes = (exabytes / 1024);
			@SuppressWarnings("unused")
			double yottabytes = (zettabytes / 1024);
			
			//if ( bytes > 1 ) { // for test
			if ( megabytes > Constant.UPLOAD_FILE_MAX_SIZE ) {
				throw new IOException(Constant.UPLOAD_FILE_MAX_OVER );
				//return Constant.UPLOAD_FILE_MAX_OVER ;
			}
			 
			vo.getFile().transferTo(file);
			
			
			
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		if ( logger.isDebugEnabled() ) {
			logger.debug("#### file.getName (" + file.getName() + ") ...");
		}
		
    } 
	
	private static File createUniqueFile(File f) {
		if ( logger.isDebugEnabled() ) {
			logger.debug("#### FileUploadUtil.createUniqueFile ...");
			logger.debug("#### f.exists (" + f.exists() + ") ...");
		}
		
		if (!f.exists()) {
			return f;
		}
		String filename = f.getName();
		int dot = filename.lastIndexOf('.');
		
		System.out.println("FILE PATH : "+f.getParent());
		
		if (dot == -1) { //확장자가 없으면
			filename = appendNumber(filename);
			return createUniqueFile(new File(f.getParent(), filename));
		} else {
			String name = filename.substring(0, dot);
			String ext = filename.substring(dot);
			name = appendNumber(name);
			return createUniqueFile(new File(f.getParent(), name + ext));
		}
	}
	
	/**
	 * 이름 뒤에 숫자를 붙인다. 숫자가 존재하는 경우 1증가 시킨다.
	 * 예) temp => temp1
	 * temp1 => temp2  
	 * 
	 * @param name 이름
	 * @return
	 */
	private static String appendNumber(String name) {
		int i;
		for (i = name.length()-1; i >= 0; i--) {
			char c = name.charAt(i);
			if (c < '0' || c > '9') {
				break;
			}
		}
		i += 1;
		if (i == name.length()) { //뒤에 숫자가 없으면
			name = name + 1;
		} else {
			String txtPart = name.substring(0,i);
			String numPart = name.substring(i);
			try {
				name = txtPart + (Integer.parseInt(numPart) + 1);
			} catch (NumberFormatException nfe) {
				name = txtPart + numPart + "_1";
			}
		}
		return name;
	}
	
	/**
	 * 파일 이름에 부모 디렉토리 경로가 포함되었는지 검사.
	 * 파일이름이 '/'로 시작하거나, '../' 나 '..\'이 포함되어 있는지 검사한다.
	 * 
	 * @param filename
	 * @return 부모디렉토리 경로가 포함되어 있으면 true, 경로가 포함 안 되어 있으면 false.
	 */
	public static boolean isIncludeParentDirectory(String filename) {
		if (filename == null) {
			return false;
		}
		if (filename.startsWith("/") ||
			filename.indexOf("../") != -1 ||
			filename.indexOf("..\\") != -1) {
			return true;
		} else {
			return false;
		}	
	}
	
	/**
     *  UNIQ 갑 
     * */
    public static String getUuid() {
    	return UUID.randomUUID().toString().replaceAll("-", "");
    }
	
}
