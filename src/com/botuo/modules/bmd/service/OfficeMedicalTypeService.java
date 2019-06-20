/**
 * 
 */
package com.botuo.modules.bmd.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.botuo.common.persistence.Page;
import com.botuo.common.service.CrudService;
import com.botuo.modules.bmd.dao.OfficeMedicalTypeDao;
import com.botuo.modules.bmd.entity.OfficeMedicalType;

/**
 * 公司报告类型表Service
 * @author xiaohu
 * @version 2018-01-11
 */
@Service
@Transactional(readOnly = true)
public class OfficeMedicalTypeService extends CrudService<OfficeMedicalTypeDao, OfficeMedicalType> {

	public OfficeMedicalType get(String id) {
		return super.get(id);
	}
	
	public List<OfficeMedicalType> findList(OfficeMedicalType officeMedicalType) {
		return super.findList(officeMedicalType);
	}
	
	public Page<OfficeMedicalType> findPage(Page<OfficeMedicalType> page, OfficeMedicalType officeMedicalType) {
		return super.findPage(page, officeMedicalType);
	}
	
	@Transactional(readOnly = false)
	public void save(OfficeMedicalType officeMedicalType) {
		super.save(officeMedicalType);
	}
	
	@Transactional(readOnly = false)
	public void delete(OfficeMedicalType officeMedicalType) {
		super.delete(officeMedicalType);
	}
	
	
	public List<OfficeMedicalType> findByOfficeName(String type, String deliverUnit){
		return dao.findByOfficeName(type, deliverUnit);
	}
	
}