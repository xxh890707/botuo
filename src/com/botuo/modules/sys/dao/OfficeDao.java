/**
 * 
 */
package com.botuo.modules.sys.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.botuo.common.persistence.TreeDao;
import com.botuo.common.persistence.annotation.MyBatisDao;
import com.botuo.entity.Office;

/**
 * 机构DAO接口
 * 
 * 05-16
 */
@MyBatisDao
public interface OfficeDao extends TreeDao<Office> {

	Office getOfficeByCode(@Param(value="code")String code);
	
	/**
	 * 查询公司及子公司
	 * @return
	 * @since 2017年11月17日 下午2:28:42
	 * @author xiaohu
	 * @version v1.0
	 */
	List<Office> findListByCompany();
}
