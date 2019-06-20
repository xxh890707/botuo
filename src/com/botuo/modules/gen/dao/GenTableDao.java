/**
 * 
 */
package com.botuo.modules.gen.dao;

import com.botuo.common.persistence.CrudDao;
import com.botuo.common.persistence.annotation.MyBatisDao;
import com.botuo.modules.gen.entity.GenTable;

/**
 * 业务表DAO接口
 * 
 * 10-15
 */
@MyBatisDao
public interface GenTableDao extends CrudDao<GenTable> {
	
}
