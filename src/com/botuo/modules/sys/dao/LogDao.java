/**
 * 
 */
package com.botuo.modules.sys.dao;

import com.botuo.common.persistence.CrudDao;
import com.botuo.common.persistence.annotation.MyBatisDao;
import com.botuo.entity.Log;

/**
 * 日志DAO接口
 * 
 * 05-16
 */
@MyBatisDao
public interface LogDao extends CrudDao<Log> {

}
