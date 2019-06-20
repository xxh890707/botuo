/**
 * 
 */
package com.botuo.common.persistence;

import org.apache.ibatis.annotations.Param;

import com.botuo.common.persistence.annotation.MyBatisDao;

/**
 * DAO支持类实现
 * 
 * 05-16
 */
@MyBatisDao("baseDao")
public interface BaseDao {
	int getCurrval(@Param(value="seq")String seq);

	int getNextval(@Param(value="seq")String seq);
	
	void updateSeq(@Param(value="seq")String seq,@Param(value="increment")int increment);
}