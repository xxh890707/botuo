/**
 * 
 */
package com.botuo.modules.bmd.entity;

import org.hibernate.validator.constraints.Length;

import com.botuo.common.persistence.DataEntity;

/**
 * 报告结果Entity
 * @author xiaohu
 * @version 2018-01-15
 */
public class MedicalResult extends DataEntity<MedicalResult> {
	
	private static final long serialVersionUID = 1L;
	private String medicalReportId;		// 检测报告编号
	private String elementId;		// 元素编号
	private String ename;
	private String value;		// 检测值
	
	public MedicalResult() {
		super();
	}

	public MedicalResult(String id){
		super(id);
	}

	@Length(min=0, max=32, message="检测报告编号长度必须介于 0 和 32 之间")
	public String getMedicalReportId() {
		return medicalReportId;
	}

	public void setMedicalReportId(String medicalReportId) {
		this.medicalReportId = medicalReportId;
	}
	
	@Length(min=0, max=32, message="元素编号长度必须介于 0 和 32 之间")
	public String getElementId() {
		return elementId;
	}

	public void setElementId(String elementId) {
		this.elementId = elementId;
	}
	
	@Length(min=0, max=50, message="检测值长度必须介于 0 和 50 之间")
	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public String getEname() {
		return ename;
	}

	public void setEname(String ename) {
		this.ename = ename;
	}
	
}