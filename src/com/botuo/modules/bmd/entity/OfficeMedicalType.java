/**
 * 
 */
package com.botuo.modules.bmd.entity;

import org.hibernate.validator.constraints.Length;

import com.botuo.common.persistence.DataEntity;
import com.botuo.entity.Office;

/**
 * 公司报告类型表Entity
 * @author xiaohu
 * @version 2018-01-11
 */
public class OfficeMedicalType extends DataEntity<OfficeMedicalType> {
	
	private static final long serialVersionUID = 1L;
	private Office office;		// 公司编号
	private MedicalType medicalType;		// 医学类型编号
	private String template;		// 模板路径
	private String showTip;			//是否显示提示
	
	public OfficeMedicalType() {
		super();
	}

	public OfficeMedicalType(String id){
		super(id);
	}

	public Office getOffice() {
		return office;
	}

	public void setOffice(Office office) {
		this.office = office;
	}

	public MedicalType getMedicalType() {
		return medicalType;
	}

	public void setMedicalType(MedicalType medicalType) {
		this.medicalType = medicalType;
	}

	@Length(min=0, max=500, message="模板路径长度必须介于 0 和 500 之间")
	public String getTemplate() {
		return template;
	}

	public void setTemplate(String template) {
		this.template = template;
	}

	public String getShowTip() {
		return showTip;
	}

	public void setShowTip(String showTip) {
		this.showTip = showTip;
	}
	
	
	
}