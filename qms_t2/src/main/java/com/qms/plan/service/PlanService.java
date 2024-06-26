package com.qms.plan.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.qms.plan.dao.PlanDao;
import com.qms.plan.vo.planVO;
import com.qms.table.vo.plan.PlanInfoVO;

@Service
public class PlanService {

	@Autowired
	PlanDao dao;
	public List<planVO> selectPlanList(planVO vo) throws Exception {
		return dao.selectPlanList(vo);
	}
	public int insertPlan(planVO vo)throws Exception{
		return dao.insertPlan(vo);
	}
	public int deletePlan(planVO vo)throws Exception{
		return dao.deletePlan(vo);
	}
	
	
	//추가 부분 시작 (시작이랑 끝부분 복붙해주세여)
	public List<planVO> selectPlanItemList(planVO vo) throws Exception {
		return dao.selectPlanItemList(vo);
	}
	public int selectTotalPlanItemCount(planVO vo) throws Exception{
		return dao.selectTotalPlanItemCount(vo);
	}
	//추가 부분 끝
	public List<planVO> selectPartnerInfo(planVO vo) throws Exception {
		return dao.selectPartnerInfo(vo);
	}
	public List<planVO> selectMaterialReqList(planVO vo) throws Exception{
		return dao.selectMaterialReqList(vo);
	}
	public int selectTotalMaterialReqCount(planVO vo) throws Exception{
		return dao.selectTotalMaterialReqCount(vo);
	}
	public int selectTotalMkPlanCount(planVO vo) throws Exception{
		return dao.selectTotalMkPlanCount(vo);
	}
	
	public List<PlanInfoVO> selectMkPlanList(PlanInfoVO vo) throws Exception{
		return dao.selectMkPlanList(vo);
	}
	
}	

	