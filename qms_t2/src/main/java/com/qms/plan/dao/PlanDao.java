package com.qms.plan.dao;

import java.util.List;

import org.mybatis.spring.annotation.MapperScan;

import com.qms.plan.vo.planVO;
import com.qms.table.vo.plan.PlanInfoVO;

@MapperScan(basePackages="com.qms.plan.dao")
public interface PlanDao {
	
	public int insertPlan(planVO vo)throws Exception;
	public int deletePlan(planVO vo)throws Exception;
	
	public int selectTotalMkPlanCount(planVO vo) throws Exception;
	
	
	public List<PlanInfoVO> selectMkPlanList(PlanInfoVO vo) throws Exception;
	
	//추가 부분 시작 (시작이랑 끝부분 복붙해주세여)
	public List<planVO> selectPlanItemList(planVO vo) throws Exception;
	public int selectTotalPlanItemCount(planVO vo) throws Exception;
	public List<planVO> selectMaterialReqList(planVO vo) throws Exception;
	public int selectTotalMaterialReqCount(planVO vo) throws Exception;
	//추가 부분 끝 
	public List<planVO> selectPartnerInfo(planVO vo) throws Exception ;
	public List<planVO> selectPlanList(planVO vo) throws Exception;
}
