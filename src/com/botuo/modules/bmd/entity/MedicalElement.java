/**
 * 
 */
package com.botuo.modules.bmd.entity;

import org.hibernate.validator.constraints.Length;

import com.botuo.common.persistence.DataEntity;

/**
 * 医学元素表Entity
 * @author xiaohu
 * @version 2018-01-15
 */
public class MedicalElement extends DataEntity<MedicalElement> {
	
	private static final long serialVersionUID = 1L;
	private MedicalType medicalType;		// 医学类型
	private String name;		// 名称
	private String ename;		// 英文名
	private String sort;		// 排序
	private String referenceAdult;		// 参考值（成人）
	private String referenceChildren;		// 参考值（儿童）
	private String standardAdult;		// 标准值（成人）
	private String standardChildren;		// 标准值（儿童）

	private Double bzzCr;		// 标准值（成人）
	private Double ckzCrs;		// 参考值（成人小）
	private Double ckzCrb;		// 参考值（成人大）
	private Double bzzEt;		// 标准值（儿童）
	private Double ckzEts;		// 参考值（儿童小）
	private Double ckzEtb;		// 参考值（儿童大）
	private Double bzzNcr;		// 标准值（女成人）
	private Double ckzNcrs;		// 参考值（女成人小）
	private Double ckzNcrb;		// 参考值（女成人大）
	private Double bzzNet;		// 标准值（女儿童）
	private Double ckzNets;		// 参考值（女儿童小）
	private Double ckzNetb;		// 参考值（女儿童大）
	private Double value;
	
	public MedicalElement() {
		super();
	}

	public MedicalElement(String id){
		super(id);
	}

	public MedicalType getMedicalType() {
		return medicalType;
	}

	public void setMedicalType(MedicalType medicalType) {
		this.medicalType = medicalType;
	}

	@Length(min=0, max=200, message="名称长度必须介于 0 和 200 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=0, max=200, message="英文名长度必须介于 0 和 200 之间")
	public String getEname() {
		return ename;
	}

	public void setEname(String ename) {
		this.ename = ename;
	}
	
	@Length(min=0, max=11, message="排序长度必须介于 0 和 11 之间")
	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}
	
	@Length(min=0, max=50, message="参考值（成人）长度必须介于 0 和 50 之间")
	public String getReferenceAdult() {
		return referenceAdult;
	}

	public void setReferenceAdult(String referenceAdult) {
		this.referenceAdult = referenceAdult;
	}
	
	@Length(min=0, max=50, message="参考值（儿童）长度必须介于 0 和 50 之间")
	public String getReferenceChildren() {
		return referenceChildren;
	}

	public void setReferenceChildren(String referenceChildren) {
		this.referenceChildren = referenceChildren;
	}
	
	@Length(min=0, max=50, message="标准值（成人）长度必须介于 0 和 50 之间")
	public String getStandardAdult() {
		return standardAdult;
	}

	public void setStandardAdult(String standardAdult) {
		this.standardAdult = standardAdult;
	}
	
	@Length(min=0, max=50, message="标准值（儿童）长度必须介于 0 和 50 之间")
	public String getStandardChildren() {
		return standardChildren;
	}

	public void setStandardChildren(String standardChildren) {
		this.standardChildren = standardChildren;
	}

	public Double getValue() {
		return value;
	}

	public void setValue(Double value) {
		this.value = value;
	}
	
	public Double getBzzCr() {
		return bzzCr;
	}

	public void setBzzCr(Double bzzCr) {
		this.bzzCr = bzzCr;
	}
	
	public Double getCkzCrs() {
		return ckzCrs;
	}

	public void setCkzCrs(Double ckzCrs) {
		this.ckzCrs = ckzCrs;
	}
	
	public Double getCkzCrb() {
		return ckzCrb;
	}

	public void setCkzCrb(Double ckzCrb) {
		this.ckzCrb = ckzCrb;
	}
	
	public Double getBzzEt() {
		return bzzEt;
	}

	public void setBzzEt(Double bzzEt) {
		this.bzzEt = bzzEt;
	}
	
	public Double getCkzEts() {
		return ckzEts;
	}

	public void setCkzEts(Double ckzEts) {
		this.ckzEts = ckzEts;
	}
	
	public Double getCkzEtb() {
		return ckzEtb;
	}

	public void setCkzEtb(Double ckzEtb) {
		this.ckzEtb = ckzEtb;
	}
	
	public Double getBzzNcr() {
		return bzzNcr;
	}

	public void setBzzNcr(Double bzzNcr) {
		this.bzzNcr = bzzNcr;
	}
	
	public Double getCkzNcrs() {
		return ckzNcrs;
	}

	public void setCkzNcrs(Double ckzNcrs) {
		this.ckzNcrs = ckzNcrs;
	}
	
	public Double getCkzNcrb() {
		return ckzNcrb;
	}

	public void setCkzNcrb(Double ckzNcrb) {
		this.ckzNcrb = ckzNcrb;
	}
	
	public Double getBzzNet() {
		return bzzNet;
	}

	public void setBzzNet(Double bzzNet) {
		this.bzzNet = bzzNet;
	}
	
	public Double getCkzNets() {
		return ckzNets;
	}

	public void setCkzNets(Double ckzNets) {
		this.ckzNets = ckzNets;
	}
	
	public Double getCkzNetb() {
		return ckzNetb;
	}

	public void setCkzNetb(Double ckzNetb) {
		this.ckzNetb = ckzNetb;
	}
	
}