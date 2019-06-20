/**
 * 
 */
package com.botuo.modules.gen.dao;

import com.botuo.common.persistence.CrudDao;
import com.botuo.common.persistence.annotation.MyBatisDao;
import com.botuo.modules.gen.entity.GenScheme;

/**
 * 生成方案DAO接口
 * 
 * 10-15
 */
@MyBatisDao
public interface GenSchemeDao extends CrudDao<GenScheme> {
	
}
