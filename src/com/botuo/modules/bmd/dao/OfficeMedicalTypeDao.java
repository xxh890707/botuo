/**
 * 
 */
package com.botuo.modules.bmd.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.botuo.common.persistence.CrudDao;
import com.botuo.common.persistence.annotation.MyBatisDao;
import com.botuo.modules.bmd.entity.OfficeMedicalType;

/**
 * 公司报告类型表DAO接口
 * 
 * @author xiaohu
 * @version 2018-01-11
 */
@MyBatisDao
public interface OfficeMedicalTypeDao extends CrudDao<OfficeMedicalType> {

	List<OfficeMedicalType> findByOfficeName(
			@Param(value = "type") String type,
			@Param(value = "deliverUnit") String deliverUnit);

}