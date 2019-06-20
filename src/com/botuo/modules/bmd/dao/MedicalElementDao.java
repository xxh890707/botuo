/**
 * 
 */
package com.botuo.modules.bmd.dao;

import java.util.List;

import org.springframework.web.bind.annotation.RequestParam;

import com.botuo.common.persistence.CrudDao;
import com.botuo.common.persistence.annotation.MyBatisDao;
import com.botuo.modules.bmd.entity.MedicalElement;

/**
 * 医学元素表DAO接口
 * @author xiaohu
 * @version 2018-01-15
 */
@MyBatisDao
public interface MedicalElementDao extends CrudDao<MedicalElement> {
	
	public List<MedicalElement> findByReport(@RequestParam String reportId);
	
	public List<MedicalElement> findByType(@RequestParam String typeId);
}