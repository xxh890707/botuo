/**
 * 
 */
package com.botuo.modules.bmd.dto;

import java.io.Serializable;
import java.util.Date;

import com.botuo.common.utils.excel.annotation.ExcelField;

/**
 * @since 2018年3月6日 下午2:38:51
 * @author xiaohu
 * @version v1.0
 */
public class ReportDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * 批次
	 */
	@ExcelField(title="批次", align=2, sort=20)
	private String batch;
	/**
	 * 检测号
	 */
	@ExcelField(title="编号", align=2, sort=20)
	private Integer reportNum;
	/**
	 * 姓名
	 */
	@ExcelField(title="姓名", align=2, sort=20)
	private String person;
	/**
	 * 性别
	 */
	@ExcelField(title="性别", align=2, sort=20)
	private String sex;
	/**
	 * 年龄
	 */
	@ExcelField(title="年龄", align=2, sort=20)
	private String age;
	/**
	 * 电话
	 */
	@ExcelField(title="电话", align=2, sort=20)
	private String phone;
	/**
	 * 送样单位
	 */
	@ExcelField(title="送样单位", align=2, sort=20)
	private String deliverUnit;
	/**
	 * 出单日期
	 */
	@ExcelField(title="出单日期", align=2, sort=20)
	private Date detectionDate;
	/**
	 * 锌
	 */
	@ExcelField(title="锌", align=2, sort=20)
	private Double Zn;
	/**
	 * 铁
	 */
	@ExcelField(title="铁", align=2, sort=20)
	private Double Fe;
	/**
	 * 铜
	 */
	@ExcelField(title="铜", align=2, sort=20)
	private Double Cu;
	/**
	 * 钙
	 */
	@ExcelField(title="钙", align=2, sort=20)
	private Double Ca;
	/**
	 * 镁
	 */
	@ExcelField(title="镁", align=2, sort=20)
	private Double Mg;
	/**
	 * 铅
	 */
	@ExcelField(title="铅", align=2, sort=20)
	private Double Pb;
	/**
	 * 锰
	 */
	@ExcelField(title="锰", align=2, sort=20)
	private Double Mn;
	/**
	 * 锶
	 */
	@ExcelField(title="锶", align=2, sort=20)
	private Double Sr;
	/**
	 * 镉
	 */
	@ExcelField(title="镉", align=2, sort=20)
	private Double Cd;
	/**
	 * 铝
	 */
	@ExcelField(title="铝", align=2, sort=20)
	private Double Al;
	/**
	 * 铬
	 */
	@ExcelField(title="铬", align=2, sort=20)
	private Double Cr;
	/**
	 * 镍
	 */
	@ExcelField(title="镍", align=2, sort=20)
	private Double Ni;
	/**
	 * 钼
	 */
	@ExcelField(title="钼", align=2, sort=20)
	private Double Mo;
	/**
	 * 钴
	 */
	@ExcelField(title="钴", align=2, sort=20)
	private Double Co;
	/**
	 * 钡
	 */
	@ExcelField(title="钡", align=2, sort=20)
	private Double Ba;
	/**
	 * 钒
	 */
	@ExcelField(title="钒", align=2, sort=20)
	private Double V;
	/**
	 * 钛
	 */
	@ExcelField(title="钛", align=2, sort=20)
	private Double Ti;
	/**
	 * 硼
	 */
	@ExcelField(title="硼", align=2, sort=20)
	private Double B;
	/**
	 * 锡
	 */
	@ExcelField(title="锡", align=2, sort=20)
	private Double Sn;
	/**
	 * 钾
	 */
	@ExcelField(title="钾", align=2, sort=20)
	private Double K;
	/**
	 * 磷
	 */
	@ExcelField(title="磷", align=2, sort=20)
	private Double P;

	public String getBatch() {
		return batch;
	}
	public void setBatch(String batch) {
		this.batch = batch;
	}
	public Integer getReportNum() {
		return reportNum;
	}
	public void setReportNum(Integer reportNum) {
		this.reportNum = reportNum;
	}
	public String getPerson() {
		return person;
	}
	public void setPerson(String person) {
		this.person = person;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getAge() {
		return age;
	}
	public void setAge(String age) {
		this.age = age;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getDeliverUnit() {
		return deliverUnit;
	}
	public void setDeliverUnit(String deliverUnit) {
		this.deliverUnit = deliverUnit;
	}
	public Double getZn() {
		return Zn;
	}
	public void setZn(Double zn) {
		Zn = zn;
	}
	public Double getFe() {
		return Fe;
	}
	public void setFe(Double fe) {
		Fe = fe;
	}
	public Double getCu() {
		return Cu;
	}
	public void setCu(Double cu) {
		Cu = cu;
	}
	public Double getCa() {
		return Ca;
	}
	public void setCa(Double ca) {
		Ca = ca;
	}
	public Double getMg() {
		return Mg;
	}
	public void setMg(Double mg) {
		Mg = mg;
	}
	public Double getPb() {
		return Pb;
	}
	public void setPb(Double pb) {
		Pb = pb;
	}
	public Double getMn() {
		return Mn;
	}
	public void setMn(Double mn) {
		Mn = mn;
	}
	public Double getSr() {
		return Sr;
	}
	public void setSr(Double sr) {
		Sr = sr;
	}
	public Double getCd() {
		return Cd;
	}
	public void setCd(Double cd) {
		Cd = cd;
	}
	public Double getAl() {
		return Al;
	}
	public void setAl(Double al) {
		Al = al;
	}
	public Double getCr() {
		return Cr;
	}
	public void setCr(Double cr) {
		Cr = cr;
	}
	public Double getNi() {
		return Ni;
	}
	public void setNi(Double ni) {
		Ni = ni;
	}
	public Double getMo() {
		return Mo;
	}
	public void setMo(Double mo) {
		Mo = mo;
	}
	public Double getCo() {
		return Co;
	}
	public void setCo(Double co) {
		Co = co;
	}
	public Double getBa() {
		return Ba;
	}
	public void setBa(Double ba) {
		Ba = ba;
	}
	public Double getV() {
		return V;
	}
	public void setV(Double v) {
		V = v;
	}
	public Double getTi() {
		return Ti;
	}
	public void setTi(Double ti) {
		Ti = ti;
	}
	public Double getB() {
		return B;
	}
	public void setB(Double b) {
		B = b;
	}
	public Double getSn() {
		return Sn;
	}
	public void setSn(Double sn) {
		Sn = sn;
	}
	public Double getK() {
		return K;
	}
	public void setK(Double k) {
		K = k;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public Date getDetectionDate() {
		return detectionDate;
	}
	public void setDetectionDate(Date detectionDate) {
		this.detectionDate = detectionDate;
	}
	public Double getP() {
		return P;
	}
	public void setP(Double p) {
		P = p;
	}
	
	

}
