/**
 * 
 */
package com.botuo.modules.bmd.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.botuo.common.persistence.Page;
import com.botuo.common.service.CrudService;
import com.botuo.modules.bmd.entity.MedicalElement;
import com.botuo.modules.bmd.dao.MedicalElementDao;

/**
 * 医学元素表Service
 * @author xiaohu
 * @version 2018-01-15
 */
@Service
@Transactional(readOnly = true)
public class MedicalElementService extends CrudService<MedicalElementDao, MedicalElement> {

	public MedicalElement get(String id) {
		return super.get(id);
	}
	
	public List<MedicalElement> findList(MedicalElement medicalElement) {
		return super.findList(medicalElement);
	}
	
	public Page<MedicalElement> findPage(Page<MedicalElement> page, MedicalElement medicalElement) {
		return super.findPage(page, medicalElement);
	}
	
	@Transactional(readOnly = false)
	public void save(MedicalElement medicalElement) {
		super.save(medicalElement);
	}
	
	@Transactional(readOnly = false)
	public void delete(MedicalElement medicalElement) {
		super.delete(medicalElement);
	}
	
}