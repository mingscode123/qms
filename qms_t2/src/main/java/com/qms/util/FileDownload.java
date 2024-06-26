package com.qms.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/download")
public class FileDownload extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}
	
	private void doHandle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		String file_repo="C:/workspace/uploadfile";
		String filePath = (String)request.getParameter("filePath"); // 매개변수로 전송된 파일 이름을 읽어옴
		filePath = filePath.replaceAll("/files", "");
		String fileName = (String)request.getParameter("fileName"); // 매개변수로 전송된 파일 이름을 읽어옴
		System.out.println("fileName="+fileName);
		OutputStream out = response.getOutputStream(); // response에서 OutputStream 객체를 가져옴
		String downFile = file_repo+filePath;
		File f=new File(downFile);
		// 파일을 다운로드할 수 있게 설정
		String downloadName = null;
		if(request.getHeader("user-agent").indexOf("MSIE")==-1) {
			downloadName = new String(fileName.getBytes("UTF-8"), "8859_1");
		}else {
			downloadName = new String(fileName.getBytes("EUC-KR"),"8859_1");
		}
		
		response.setContentType("application/octet-stream");
        response.setHeader("Cache-Control", "no-cache");
        response.addHeader("Content-disposition", "attachment; filename=\"" + downloadName + "\"");
		FileInputStream in=new FileInputStream(f);
		// 버퍼 기능을 이용해 파일에서 버퍼로 데이터를 읽어와 한꺼번에 출력함
		byte[] buffer = new byte[1024 * 8];  // 8KB 버퍼 생성
		while (true) {
		    int count = in.read(buffer);  // 버퍼 크기만큼 파일에서 데이터를 읽음
		    if (count == -1)  // 더 이상 읽을 데이터가 없으면 루프 종료
		        break;
		    out.write(buffer, 0, count);  // 버퍼에서 데이터를 출력 스트림에 씀
		}
		in.close();
		out.close();
	}

}
