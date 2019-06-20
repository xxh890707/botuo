/**
 * 
 */
package com.botuo.modules.bmd.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.botuo.common.persistence.Page;
import com.botuo.common.service.CrudService;
import com.botuo.modules.bmd.dao.MedicalResultDao;
import com.botuo.modules.bmd.entity.MedicalResult;

/**
 * 报告结果Service
 * @author xiaohu
 * @version 2018-01-15
 */
@Service
@Transactional(readOnly = true)
public class MedicalResultService extends CrudService<MedicalResultDao, MedicalResult> {

	public MedicalResult get(String id) {
		return super.get(id);
	}
	
	public List<MedicalResult> findList(MedicalResult bmdMedicalResult) {
		return super.findList(bmdMedicalResult);
	}
	
	public Page<MedicalResult> findPage(Page<MedicalResult> page, MedicalResult bmdMedicalResult) {
		return super.findPage(page, bmdMedicalResult);
	}
	
	@Transactional(readOnly = false)
	public void save(MedicalResult bmdMedicalResult) {
		super.save(bmdMedicalResult);
	}
	
	@Transactional(readOnly = false)
	public void delete(MedicalResult bmdMedicalResult) {
		super.delete(bmdMedicalResult);
	}
	
}