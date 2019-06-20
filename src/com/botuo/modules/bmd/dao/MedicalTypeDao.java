/**
 * 
 */
package com.botuo.modules.bmd.dao;

import java.util.List;

import com.botuo.common.persistence.CrudDao;
import com.botuo.common.persistence.annotation.MyBatisDao;
import com.botuo.modules.bmd.entity.MedicalType;

/**
 * 医学类型DAO接口
 * @author xiaohu
 * @version 2018-01-11
 */
@MyBatisDao
public interface MedicalTypeDao extends CrudDao<MedicalType> {
	
	public List<MedicalType> findAllList();
	
}