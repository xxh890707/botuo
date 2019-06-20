/**
 * 
 */
package com.botuo.modules.gen.dao;

import com.botuo.common.persistence.CrudDao;
import com.botuo.common.persistence.annotation.MyBatisDao;
import com.botuo.modules.gen.entity.GenTableColumn;

/**
 * 业务表字段DAO接口
 * 
 * 10-15
 */
@MyBatisDao
public interface GenTableColumnDao extends CrudDao<GenTableColumn> {
	
	public void deleteByGenTableId(String genTableId);
}
