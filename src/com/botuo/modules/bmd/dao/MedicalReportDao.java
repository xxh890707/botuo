/**
 * 
 */
package com.botuo.modules.bmd.dao;

import java.util.List;

import com.botuo.common.persistence.CrudDao;
import com.botuo.common.persistence.annotation.MyBatisDao;
import com.botuo.modules.bmd.entity.MedicalReport;

/**
 * 检查报告表DAO接口
 * @author xiaohu
 * @version 2018-01-18
 */
@MyBatisDao
public interface MedicalReportDao extends CrudDao<MedicalReport> {
	
	public List<MedicalReport> findReportPage(MedicalReport medicalReport);
	
	public void updateBatch(List<MedicalReport> list);
	
}