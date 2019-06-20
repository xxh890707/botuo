/**
 * 
 */
package com.botuo.modules.bmd.entity;

import java.util.Date;
import java.util.List;

import org.hibernate.validator.constraints.Length;

import com.botuo.common.persistence.DataEntity;
import com.botuo.entity.Office;
import com.botuo.entity.User;
import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 检查报告表Entity
 * @author xiaohu
 * @version 2018-01-18
 */
public class MedicalReport extends DataEntity<MedicalReport> {
	
	private static final long serialVersionUID = 1L;
	private OfficeMedicalType officeMedicalType;		// 公司医学类型编号
	private Office office;
	private String name;
	private Integer reportNum;		// 报告编号
	private String person;		// 检查人员
	private User user;		// 用户编号
	private String deliverUnit;		// 送样单位
	private String sex;		// 性别
	private String age;		// age
	private String detectionMethod;		// 检测方法
	private String technicalDirector;		// 技术负责人
	private String phone;		// phone
	private Date detectionDate;		// 检测日期
	private String qrcode;		// 二维码地址
	private String gscode;		//公司二维码
	private String batch;
	private String isPrint;		//是否打印
	private String template;
	private List<MedicalElement> elements;
	private List<MedicalResult> results;
	private String type;
	
	private Date beginDate;
	private Date endDate;
	private Double zn;
	private Double fe;
	private Double cu;
	private Double ca;
	private Double mg;
	private Double pb;
	private Double mn;
	private Double sr;
	private Double cd;
	private Double al;
	private Double cr;
	private Double ni;
	private Double mo;
	private Double co;
	private Double ba;
	private Double v;
	private Double ti;
	private Double b;
	private Double sn;
	private Double k;
	private Double si;
	private Double se;
	private Double p;
	private String[] ids;
	
	public MedicalReport() {
		super();
	}

	public MedicalReport(String id){
		super(id);
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getReportNum() {
		return reportNum;
	}

	public void setReportNum(Integer reportNum) {
		this.reportNum = reportNum;
	}
	
	@Length(min=0, max=100, message="检查人员长度必须介于 0 和 100 之间")
	public String getPerson() {
		return person;
	}

	public void setPerson(String person) {
		this.person = person;
	}
	
	
	@Length(min=0, max=255, message="送样单位长度必须介于 0 和 255 之间")
	public String getDeliverUnit() {
		return deliverUnit;
	}

	public void setDeliverUnit(String deliverUnit) {
		this.deliverUnit = deliverUnit;
	}
	
	@Length(min=0, max=1, message="性别长度必须介于 0 和 1 之间")
	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}
	
	@Length(min=0, max=50, message="age长度必须介于 0 和 50 之间")
	public String getAge() {
		return age;
	}

	public void setAge(String age) {
		this.age = age;
	}
	
	@Length(min=0, max=100, message="检测方法长度必须介于 0 和 100 之间")
	public String getDetectionMethod() {
		return detectionMethod;
	}

	public void setDetectionMethod(String detectionMethod) {
		this.detectionMethod = detectionMethod;
	}
	
	@Length(min=0, max=100, message="技术负责人长度必须介于 0 和 100 之间")
	public String getTechnicalDirector() {
		return technicalDirector;
	}

	public void setTechnicalDirector(String technicalDirector) {
		this.technicalDirector = technicalDirector;
	}
	
	@Length(min=0, max=50, message="phone长度必须介于 0 和 50 之间")
	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getDetectionDate() {
		return detectionDate;
	}

	public void setDetectionDate(Date detectionDate) {
		this.detectionDate = detectionDate;
	}
	
	@Length(min=0, max=255, message="二维码地址长度必须介于 0 和 255 之间")
	public String getQrcode() {
		return qrcode;
	}

	public void setQrcode(String qrcode) {
		this.qrcode = qrcode;
	}

	public OfficeMedicalType getOfficeMedicalType() {
		return officeMedicalType;
	}

	public void setOfficeMedicalType(OfficeMedicalType officeMedicalType) {
		this.officeMedicalType = officeMedicalType;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getBatch() {
		return batch;
	}

	public void setBatch(String batch) {
		this.batch = batch;
	}

	public List<MedicalElement> getElements() {
		return elements;
	}

	public void setElements(List<MedicalElement> elements) {
		this.elements = elements;
	}

	public String getTemplate() {
		return template;
	}

	public void setTemplate(String template) {
		this.template = template;
	}

	public List<MedicalResult> getResults() {
		return results;
	}

	public void setResults(List<MedicalResult> results) {
		this.results = results;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Double getZn() {
		return zn;
	}

	public void setZn(Double zn) {
		this.zn = zn;
	}

	public Double getFe() {
		return fe;
	}

	public void setFe(Double fe) {
		this.fe = fe;
	}

	public Double getCu() {
		return cu;
	}

	public void setCu(Double cu) {
		this.cu = cu;
	}

	public Double getCa() {
		return ca;
	}

	public void setCa(Double ca) {
		this.ca = ca;
	}

	public Double getMg() {
		return mg;
	}

	public void setMg(Double mg) {
		this.mg = mg;
	}



	public Date getBeginDate() {
		return beginDate;
	}

	public void setBeginDate(Date beginDate) {
		this.beginDate = beginDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public String getGscode() {
		return gscode;
	}

	public void setGscode(String gscode) {
		this.gscode = gscode;
	}

	public Office getOffice() {
		return office;
	}

	public void setOffice(Office office) {
		this.office = office;
	}

	public String[] getIds() {
		return ids;
	}

	public void setIds(String[] ids) {
		this.ids = ids;
	}

	public Double getPb() {
		return pb;
	}

	public void setPb(Double pb) {
		this.pb = pb;
	}

	public Double getMn() {
		return mn;
	}

	public void setMn(Double mn) {
		this.mn = mn;
	}

	public Double getSr() {
		return sr;
	}

	public void setSr(Double sr) {
		this.sr = sr;
	}

	public Double getCd() {
		return cd;
	}

	public void setCd(Double cd) {
		this.cd = cd;
	}

	public Double getAl() {
		return al;
	}

	public void setAl(Double al) {
		this.al = al;
	}

	public Double getCr() {
		return cr;
	}

	public void setCr(Double cr) {
		this.cr = cr;
	}

	public Double getNi() {
		return ni;
	}

	public void setNi(Double ni) {
		this.ni = ni;
	}

	public Double getMo() {
		return mo;
	}

	public void setMo(Double mo) {
		this.mo = mo;
	}

	public Double getCo() {
		return co;
	}

	public void setCo(Double co) {
		this.co = co;
	}

	public Double getBa() {
		return ba;
	}

	public void setBa(Double ba) {
		this.ba = ba;
	}

	public Double getV() {
		return v;
	}

	public void setV(Double v) {
		this.v = v;
	}

	public Double getTi() {
		return ti;
	}

	public void setTi(Double ti) {
		this.ti = ti;
	}

	public Double getB() {
		return b;
	}

	public void setB(Double b) {
		this.b = b;
	}

	public Double getSn() {
		return sn;
	}

	public void setSn(Double sn) {
		this.sn = sn;
	}

	public Double getK() {
		return k;
	}

	public void setK(Double k) {
		this.k = k;
	}

	public Double getSi() {
		return si;
	}

	public void setSi(Double si) {
		this.si = si;
	}

	public Double getSe() {
		return se;
	}

	public void setSe(Double se) {
		this.se = se;
	}

	public Double getP() {
		return p;
	}

	public void setP(Double p) {
		this.p = p;
	}

	public String getIsPrint() {
		return isPrint;
	}

	public void setIsPrint(String isPrint) {
		this.isPrint = isPrint;
	}

	
}