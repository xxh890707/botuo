/**
 * 
 */
package com.botuo.modules.bmd.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import org.hibernate.validator.constraints.Length;

import com.botuo.common.persistence.DataEntity;

/**
 * 医学类型Entity
 * @author xiaohu
 * @version 2018-01-11
 */
public class MedicalType extends DataEntity<MedicalType> {
	
	private static final long serialVersionUID = 1L;
	private MedicalType parent;		// 父级编号
	private String name;		// 名称
	private String ename;		// 英文名
	private String sort;		// 排序
	
	public MedicalType() {
		super();
	}

	public MedicalType(String id){
		super(id);
	}

	@JsonBackReference
	public MedicalType getParent() {
		return parent;
	}

	public void setParent(MedicalType parent) {
		this.parent = parent;
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
	
}