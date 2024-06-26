package com.qms.util;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.StringReader;
import java.nio.charset.StandardCharsets;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.tool.xml.XMLWorker;
import com.itextpdf.tool.xml.XMLWorkerFontProvider;
import com.itextpdf.tool.xml.XMLWorkerHelper;
import com.itextpdf.tool.xml.css.CssFile;
import com.itextpdf.tool.xml.css.StyleAttrCSSResolver;
import com.itextpdf.tool.xml.html.CssAppliers;
import com.itextpdf.tool.xml.html.CssAppliersImpl;
import com.itextpdf.tool.xml.html.Tags;
import com.itextpdf.tool.xml.parser.XMLParser;
import com.itextpdf.tool.xml.pipeline.css.CSSResolver;
import com.itextpdf.tool.xml.pipeline.css.CssResolverPipeline;
import com.itextpdf.tool.xml.pipeline.end.PdfWriterPipeline;
import com.itextpdf.tool.xml.pipeline.html.HtmlPipeline;
import com.itextpdf.tool.xml.pipeline.html.HtmlPipelineContext;
import com.qms.pdf.service.ItextPdfService;
import com.qms.pdf.vo.ItextPdfVO;

@Component // Spring에서 이 클래스를 빈으로 등록
public class ItextPdfUtil {
    @Autowired
    ItextPdfService service; // ItextPdfService를 주입받음

    // PDF를 생성하고 ByteArrayOutputStream으로 반환하는 메서드
    public ByteArrayOutputStream createPDF(ItextPdfVO vo) {
        Document document = new Document(PageSize.A4, 30, 30, 30, 30); // PDF 문서 객체 생성 (A4 사이즈, 여백 설정)
        ByteArrayOutputStream baos = new ByteArrayOutputStream(); // PDF 데이터를 저장할 ByteArrayOutputStream 객체 생성

        try {
            PdfWriter pdfWriter = PdfWriter.getInstance(document, baos); // PdfWriter 객체 생성 (PDF 작성기)
            pdfWriter.setInitialLeading(12.5f); // PDF의 기본 줄 간격 설정
            document.open(); // PDF 문서를 열기

            CSSResolver cssResolver = new StyleAttrCSSResolver(); // CSS 스타일을 적용할 수 있도록 CSSResolver 객체 생성
            CssFile cssFile = null; // CSS 파일을 저장할 변수 선언

            try {
                // CSS 파일을 읽어와서 CssFile 객체로 변환
            	File file = new File("src/main/webapp/assets/css/style.css");      
            	String pdffilepath = file.getCanonicalPath();
            	InputStream cssStream = new FileInputStream(pdffilepath);
                cssFile = XMLWorkerHelper.getCSS(cssStream);
            } catch (Exception e) {
                throw new IllegalArgumentException("PDF CSS 파일을 찾을 수 없습니다."); // 예외 발생 시 메시지 출력
            }

            if (cssFile == null) {
                throw new IllegalArgumentException("PDF CSS 파일을 찾을 수 없습니다."); // CSS 파일이 null인 경우 예외 발생
            }

            cssResolver.addCss(cssFile); // CSSResolver에 CSS 파일 추가

            // 폰트 설정 및 등록 부분
            XMLWorkerFontProvider fontProvider = new XMLWorkerFontProvider(XMLWorkerFontProvider.DONTLOOKFORFONTS);
            try {
                // 시스템 폰트 경로를 지정 (예: Windows의 Malgun Gothic)
                fontProvider.register("C:/Windows/Fonts/malgun.ttf", "MalgunGothic");
            } catch (Exception e) {
                throw new IllegalArgumentException("PDF 폰트 파일을 찾을 수 없습니다."); // 폰트 파일을 찾을 수 없는 경우 예외 발생
            }

            if (fontProvider.getRegisteredFonts() == null) {
                throw new IllegalArgumentException("PDF 폰트 파일을 찾을 수 없습니다."); // 등록된 폰트가 없는 경우 예외 발생
            }

            // CssAppliers를 사용하여 폰트 적용
            CssAppliers cssAppliers = new CssAppliersImpl(fontProvider);
            HtmlPipelineContext htmlPipelineContext = new HtmlPipelineContext(cssAppliers); // HTML 파이프라인 컨텍스트 생성
            htmlPipelineContext.setTagFactory(Tags.getHtmlTagProcessorFactory()); // 태그 처리기 팩토리 설정

            PdfWriterPipeline pdfWriterPipeline = new PdfWriterPipeline(document, pdfWriter); // PDF 작성 파이프라인 생성
            HtmlPipeline htmlPipeline = new HtmlPipeline(htmlPipelineContext, pdfWriterPipeline); // HTML 파이프라인 생성
            CssResolverPipeline cssResolverPipeline = new CssResolverPipeline(cssResolver, htmlPipeline); // CSS 파이프라인 생성

            XMLWorker xmlWorker = new XMLWorker(cssResolverPipeline, true); // XMLWorker 생성
            XMLParser xmlParser = new XMLParser(true, xmlWorker, StandardCharsets.UTF_8); // XMLParser 생성

            String htmlStr = getHtml(vo.getPdfFileName(), vo); // HTML 문자열 생성

            StringReader stringReader = new StringReader(htmlStr); // HTML 문자열을 StringReader로 변환
            xmlParser.parse(stringReader); // HTML을 파싱하여 PDF에 작성

            document.close(); // PDF 문서 닫기
            pdfWriter.close(); // PDF 작성기 닫기

        } catch (DocumentException e1) {
            throw new IllegalArgumentException("PDF 라이브러리 설정 에러"); // PDF 라이브러리 설정 에러 발생 시 예외 처리
        } catch (IOException e2) {
            e2.printStackTrace();
            throw new IllegalArgumentException("PDF 파일 생성중 에러"); // 파일 생성 중 IO 에러 발생 시 예외 처리
        } catch (Exception e3) {
            e3.printStackTrace();
            throw new IllegalArgumentException("PDF 파일 생성중 에러"); // 기타 에러 발생 시 예외 처리
        } finally {
            try {
                document.close(); // PDF 문서 닫기
            } catch (Exception e) {
                System.out.println("PDF 파일 닫기 에러");
                e.printStackTrace();
            }
        }

        return baos; // 생성된 PDF 데이터를 ByteArrayOutputStream으로 반환
    }

    public String getHtml(String code, @ModelAttribute("ItextPdfVO") ItextPdfVO vo) throws Exception {

        String return_html = "";

        switch (code) {       
            case "invoice":
            	vo = service.selectInvoiceData(vo);
            	return_html =
                "<html>" +
                "<head>" +
                "<style>" +
                "    body { font-family: 'MalgunGothic'; }" +
                "</style>" +
                "</head>" +
                "<body>" +
                "    <div class=\"invoice-container\">" + // 컨테이너 div 추가
                "        <table class=\"invoice-table\">" +
                "            <tr class=\"invoice-header\">" +
                "                <th>Invoice Number</th>" +
                "                <td>" + vo.getInvoiceNo() + "</td>" +
                "            </tr>" +
                "            <tr>" +
                "                <th>Shipper</th>" +
                "                <td>" + vo.getShipper() + "</td>" +
                "            </tr>" +
                "            <tr>" +
                "                <th>Consignee</th>" +
                "                <td>" + vo.getConsignee() + "</td>" +
                "            </tr>" +
                "            <tr>" +
                "                <th>Notification Party</th>" +
                "                <td>" + vo.getNotiParty() + "</td>" +
                "            </tr>" +
                "            <tr>" +
                "                <th>Port of Loading</th>" +
                "                <td>" + vo.getPortLoad() + "</td>" +
                "            </tr>" +
                "            <tr>" +
                "                <th>Final Destination</th>" +
                "                <td>" + vo.getFinalDest() + "</td>" +
                "            </tr>" +
                "            <tr>" +
                "                <th>Remarks</th>" +
                "                <td>" + vo.getRemark() + "</td>" +
                "            </tr>" +
                "        </table>" +
                "    </div>" + // 컨테이너 div 닫기
                "</body>" +
                "</html>";
                break;
            default:
                return_html = "";
                break;
        }
        return return_html;
    }
}
