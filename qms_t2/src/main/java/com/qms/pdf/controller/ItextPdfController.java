package com.qms.pdf.controller;

import java.io.BufferedOutputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.qms.pdf.vo.ItextPdfVO;
import com.qms.util.ItextPdfUtil;

import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class ItextPdfController {
    // ItextPdfUtil 인스턴스를 자동으로 주입받음
    @Autowired
    private final ItextPdfUtil itextPdfUtil;

    // "/attachment/pdf" 경로로 들어오는 요청을 처리하는 메서드
    @RequestMapping("/attachment/pdf")
    public void pdfDownload(HttpServletResponse response, @ModelAttribute("ItextPdfVO") ItextPdfVO vo) {
        // PDF 파일명 설정
        String pdfFileName = vo.getPdfFileName() + ".pdf";

        // PDF 파일을 생성하여 ByteArrayOutputStream에 저장
        ByteArrayOutputStream baos = itextPdfUtil.createPDF(vo);

        // 파일 다운로드를 위한 header 설정
        response.setContentType("application/pdf"); // 콘텐츠 유형을 PDF로 설정
        response.setHeader("Content-Disposition", "attachment; filename=" + pdfFileName + ";"); // 다운로드 파일명 설정
        response.setContentLength(baos.size()); // 콘텐츠 길이를 설정
        response.setStatus(HttpServletResponse.SC_OK); // 응답 상태를 200(성공)으로 설정

        // 파일 다운로드
        try (BufferedOutputStream out = new BufferedOutputStream(response.getOutputStream())) {
            baos.writeTo(out); // ByteArrayOutputStream의 내용을 출력 스트림에 씀
            out.flush(); // 출력 스트림을 비움
        } catch (IOException e) {
            e.printStackTrace(); // IOException 발생 시 스택 트레이스를 출력
        }
    }
}
