/**
 * 
 */
package com.botuo.modules.bmd.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.botuo.common.persistence.Page;
import com.botuo.common.service.CrudService;
import com.botuo.modules.bmd.entity.MedicalType;
import com.botuo.modules.bmd.dao.MedicalTypeDao;

/**
 * 医学类型Service
 * @author xiaohu
 * @version 2018-01-11
 */
@Service
@Transactional(readOnly = true)
public class MedicalTypeService extends CrudService<MedicalTypeDao, MedicalType> {
	
	@Autowired
	private MedicalTypeDao medicalTypeDao;

	public MedicalType get(String id) {
		return super.get(id);
	}
	
	public List<MedicalType> findList(MedicalType medicalType) {
		return super.findList(medicalType);
	}
	
	public Page<MedicalType> findPage(Page<MedicalType> page, MedicalType medicalType) {
		return super.findPage(page, medicalType);
	}
	
	@Transactional(readOnly = false)
	public void save(MedicalType medicalType) {
		super.save(medicalType);
	}
	
	@Transactional(readOnly = false)
	public void delete(MedicalType medicalType) {
		super.delete(medicalType);
	}
	
	

	@Transactional(readOnly = false)
	public List<MedicalType> findAllList(){
		return medicalTypeDao.findAllList();
	}
	
}