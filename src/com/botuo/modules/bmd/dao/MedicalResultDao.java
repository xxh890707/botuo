/**
 * 
 */
package com.botuo.modules.bmd.dao;

import com.botuo.common.persistence.CrudDao;
import com.botuo.common.persistence.annotation.MyBatisDao;
import com.botuo.modules.bmd.entity.MedicalResult;

/**
 * 报告结果DAO接口
 * @author xiaohu
 * @version 2018-01-15
 */
@MyBatisDao
public interface MedicalResultDao extends CrudDao<MedicalResult> {
	
}