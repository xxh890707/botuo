/**
 * 
 */
package com.botuo.modules.sys.dao;

import java.util.List;

import com.botuo.common.persistence.CrudDao;
import com.botuo.common.persistence.annotation.MyBatisDao;
import com.botuo.entity.Dict;

/**
 * 字典DAO接口
 * 
 * 05-16
 */
@MyBatisDao
public interface DictDao extends CrudDao<Dict> {

	public List<String> findTypeList(Dict dict);
	
}
