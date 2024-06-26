package com.qms.code.dao;

import java.util.List;

import org.mybatis.spring.annotation.MapperScan;

import com.qms.table.vo.common.ComCodeVO;


@MapperScan(basePackages="com.qms.code.dao")
public interface CodeDao {
	public List<ComCodeVO> selectGetdata(ComCodeVO vo) throws Exception;
}
