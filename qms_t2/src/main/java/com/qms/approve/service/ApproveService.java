package com.qms.approve.service;

import java.util.Calendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.qms.approve.dao.ApproveDao;
import com.qms.approve.vo.Aprv01VO;
import com.qms.approve.vo.Aprv02VO;
import com.qms.common.service.FileService;
import com.qms.table.vo.approve.AprvFileVO;
import com.qms.table.vo.approve.AprvInfoVO;
import com.qms.table.vo.approve.AprvLineVO;
import com.qms.table.vo.common.FileVO;

@Service
public class ApproveService {

	@Autowired
	ApproveDao dao;
	@Autowired
	FileService fileService;
	
	public List<Aprv01VO> getDocStatus(AprvInfoVO vo) throws Exception{
		return dao.getDocStatus(vo);
	}
	public Aprv01VO selectDocDetail(Aprv01VO vo) throws Exception{
		return dao.selectDocDetail(vo);
	}
	
	public List<Aprv02VO> selectAprvLineList(Aprv01VO vo) throws Exception{
		return dao.selectAprvLineList(vo);
	}
	
	public List<AprvFileVO> selectAprvFileList(Aprv01VO vo) throws Exception{
		return dao.selectAprvFileList(vo);
	}
	
	public int insertDocInfoData(Aprv01VO vo) throws Exception{
		return dao.insertDocInfoData(vo);
	}
	
	//기안서등록.
	@Transactional
	public int insertDocData(Aprv01VO vo) throws Exception{
		String docNoVo = dao.selectMaxDocNo(vo);	// 주문번호 생성
		vo.setDocNo(docNoVo);
		int cnt1 = dao.insertDocInfoData(vo);	//인포등록
		
		//현재년월
		
		
		AprvLineVO linevo = new AprvLineVO();
		linevo.setDocNo(docNoVo);
		linevo.setRegUserId(vo.getUserId());
		for (int i = 0; i < vo.getLinelist().size(); i++) {
			if(vo.getLinelist().get(i).getUserId()!=null) {	
				linevo.setAprvSeq(""+(i+1));
				linevo.setUserId(vo.getLinelist().get(i).getUserId());
				int cnt2 = dao.insertLineInfoData(linevo);//결재라인등록
			} 
		}
		
		 List<MultipartFile> fileList = vo.getUpfilelist(); // 파일 목록 가져오기
		    if (fileList != null) {
		        for (int i = 0; i < fileList.size(); i++) {
		            AprvFileVO apfilevo = new AprvFileVO();
		            apfilevo.setDocNo(docNoVo);
		            FileVO filevo = new FileVO();
		            
		            Calendar calendar = Calendar.getInstance();//객체를 불러옴
		            int year = calendar.get(Calendar.YEAR); // 현재 연도
		            int month = calendar.get(Calendar.MONTH) + 1; // 현재 월 (+1을 하는 이유는 월은 0부터 시작하기 때문)
		            String datePath = String.format("%04d%02d", year, month); // yyyymm 형식의 폴더 경로 생성

		            filevo.setMiddlePath("approve/" + datePath); // 미들 파일 경로 설정
		            filevo.setFile(fileList.get(i));
		            filevo = fileService.createFile(filevo); // 파일 서비스를 사용하여 파일 생성
		            apfilevo.setFileSeq(""+(i+1));
		            apfilevo.setFileName(filevo.getOrgFileNm());
		            apfilevo.setFilePath(filevo.getFilePath());
		            apfilevo.setFileSize(""+(filevo.getFile().getSize()));
		            apfilevo.setRegUserId(vo.getUserId());
		            int cnt3 = dao.insertFileInfoData(apfilevo);    // 파일 정보 등록
		        }
		    }
		return 1;
	}

		
		public List<Aprv01VO> selectAprvIng(Aprv01VO vo) throws Exception{
			return dao.selectAprvIng(vo);
		}
		public List<Aprv01VO> selectAprvDone(Aprv01VO vo) throws Exception{
			return dao.selectAprvDone(vo);
		}
		public int UpdateAgreeStatus(Aprv01VO vo) throws Exception{
			return dao.UpdateAgreeStatus(vo);
		}
		public int UpdatePassStatus(Aprv01VO vo) throws Exception{
			return dao.UpdatePassStatus(vo);
		}
		public int UpdatePassDoc(Aprv01VO vo) throws Exception{
			return dao.UpdatePassDoc(vo);
		}
		public int UpdateAgreeDoc(Aprv01VO vo) throws Exception{
			return dao.UpdateAgreeDoc(vo);
		}
		public int UpdateNextAprv(Aprv01VO vo) throws Exception{
			return dao.UpdateNextAprv(vo);
		}
		public int selectTotalAprvingCount(Aprv01VO vo)throws Exception{
			return dao.selectTotalAprvingCount(vo);
		}
		public int selectTotalAprvedCount(Aprv01VO vo)throws Exception{
			return dao.selectTotalAprvedCount(vo);
		}
		public int selectTotalMyAprvCount(Aprv01VO vo)throws Exception{
			return dao.selectTotalMyAprvCount(vo);
		}
		
		

		
}
