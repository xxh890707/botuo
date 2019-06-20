/**
 * 
 */
package com.botuo.common.persistence;

import java.util.Date;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.validator.constraints.Length;

import com.botuo.common.utils.IdGen;
import com.botuo.entity.User;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * 数据Entity类
 * 
 * 05-16
 */
public abstract class DataEntity<T> extends BaseEntity<T> {

	private static final long serialVersionUID = 1L;
	
	protected String remarks;	// 备注
	protected User createBy;	// 创建者
	protected Date createDate;	// 创建日期
	protected User updateBy;	// 更新者
	protected Date updateDate;	// 更新日期
	protected String attachmentCode; //附件,统一处理只有一个附件的信息字段
	protected String oldAttachmentCode; //旧附件id
	protected String delFlag; 	// 删除标记（0：正常；1：删除；2：审核）
	protected String operationFlag; 	//操作标记（view：查看；edit：修改；create：创建；audit：审批）
	protected String bsid;
	protected boolean isFromControlCenter = false;
	
	String[] serviceApiArray = new String[]{};


	protected String examinerName;
	
	protected String examinerCodeType;
	
	protected String examinerCode;
	
	protected String infoReporterName;
	
	protected String infoReporterCodeType;
	
	protected String infoReporterCode;
	
	protected Date verifyTime;


	protected String isOpen;
	
	protected String openType;
	
	protected String createTime;
	
	protected String url;
	
	protected String platfVerifier;

	protected String platfVerifierTime;
	
	protected int interfaceInstanceId;
	
	protected String attachmentId;
	
	public String getAttachmentId() {
		return attachmentId;
	}

	public void setAttachmentId(String attachmentId) {
		this.attachmentId = attachmentId;
	}

	public int getInterfaceInstanceId() {
		return interfaceInstanceId;
	}

	public void setInterfaceInstanceId(int interfaceInstanceId) {
		this.interfaceInstanceId = interfaceInstanceId;
	}

	public String getPlatfVerifier() {
		return platfVerifier;
	}

	public void setPlatfVerifier(String platfVerifier) {
		this.platfVerifier = platfVerifier;
	}

	public String getPlatfVerifierTime() {
		return platfVerifierTime;
	}

	public void setPlatfVerifierTime(String platfVerifierTime) {
		this.platfVerifierTime = platfVerifierTime;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	protected Date version;
	public Date getVersion() {
		return version;
	}

	public void setVersion(Date version) {
		this.version = version;
	}

	public String getOldAttachmentCode() {
		return oldAttachmentCode;
	}

	public void setOldAttachmentCode(String oldAttachmentCode) {
		this.oldAttachmentCode = oldAttachmentCode;
	}
	
	public DataEntity() {
		super();
		this.delFlag = DEL_FLAG_NORMAL;
	}
	
	public DataEntity(String id) {
		super(id);
	}
	public DataEntity(String id,String[] serviceApiArray) {
		super(id);
		this.serviceApiArray = serviceApiArray;
	}
	
	
	public boolean isFromControlCenter() {
		return isFromControlCenter || StringUtils.isNotBlank(getBsid());
	}

	public void setFromControlCenter(boolean isFromControlCenter) {
		this.isFromControlCenter = isFromControlCenter;
	}
	public String getAttachmentCode() {
		return attachmentCode;
	}

	public void setAttachmentCode(String attachmentCode) {
		this.attachmentCode = attachmentCode;
	}
	/**
	 * 插入之前执行方法，需要手动调用
	 */
	@Override
	public void preInsert(){
		// 不限制ID为UUID，调用setIsNewRecord()使用自定义ID
		if (!this.isNewRecord){
			String uuid = IdGen.uuid();
			setId(uuid);
			/*//处理附件业务
			for(Attachment attachment : this.attachmentList){
				attachment.setBusinessId(uuid);
			}*/
		}
		User user = this.getCurrentUser();
		if (user != null && StringUtils.isNotBlank(user.getId())){
			this.updateBy = user;
			this.createBy = user;
		}else {
			this.updateBy = new User("1");
			this.createBy = new User("1");
		}
		Date nowDate = new Date();
		if(this.updateDate == null)this.updateDate = nowDate;
		if(this.createDate == null)this.createDate = nowDate;
		//AttachmentUtils.saveAttachment(attachmentList);
	}
	
	/**
	 * 更新之前执行方法，需要手动调用
	 */
	@Override
	public void preUpdate(){
		User user = this.getCurrentUser();;
		if (user != null &&  StringUtils.isNotBlank(user.getId())){
			this.updateBy = user;
		}
		this.updateDate = new Date();
		/*for(Attachment attachment : this.attachmentList){
			attachment.setBusinessId(this.id);
		};
		AttachmentUtils.deleteByBusinessId(new Attachment("",this.id));
		AttachmentUtils.saveAttachment(attachmentList);*/
	}
	
	
	@Length(min=0, max=255)
	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	
	@JsonIgnore
	public User getCreateBy() {
		return createBy;
	}

	public void setCreateBy(User createBy) {
		this.createBy = createBy;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	@JsonIgnore
	public User getUpdateBy() {
		return updateBy;
	}

	public void setUpdateBy(User updateBy) {
		this.updateBy = updateBy;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}

	@JsonIgnore
	@Length(min=1, max=1)
	public String getDelFlag() {
		return delFlag;
	}

	public void setDelFlag(String delFlag) {
		this.delFlag = delFlag;
	}

	@JsonIgnore
	public String getOperationFlag() {
		return operationFlag;
	}

	public void setOperationFlag(String operationFlag) {
		this.operationFlag = operationFlag;
	}
	

	@JsonIgnore
	public String getBsid() {
		return bsid;
	}

	public void setBsid(String bsid) {
		this.bsid = bsid;
	}

	/*public List<Attachment> getAttachmentList() {
		return attachmentList;
	}

	public void setAttachmentList(List<Attachment> attachmentList) {
		this.attachmentList = attachmentList;
	}*/
	public String getExaminerName() {
		return examinerName;
	}

	public void setExaminerName(String examinerName) {
		this.examinerName = examinerName;
	}

	public String getExaminerCodeType() {
		return examinerCodeType;
	}

	public void setExaminerCodeType(String examinerCodeType) {
		this.examinerCodeType = examinerCodeType;
	}

	public String getExaminerCode() {
		return examinerCode;
	}

	public void setExaminerCode(String examinerCode) {
		this.examinerCode = examinerCode;
	}
	public String getIsOpen() {
		return isOpen;
	}

	public void setIsOpen(String isOpen) {
		this.isOpen = isOpen;
	}

	public String getOpenType() {
		return openType;
	}

	public void setOpenType(String openType) {
		this.openType = openType;
	}
	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public String getInfoReporterName() {
		return infoReporterName;
	}

	public void setInfoReporterName(String infoReporterName) {
		this.infoReporterName = infoReporterName;
	}

	public String getInfoReporterCodeType() {
		return infoReporterCodeType;
	}

	public void setInfoReporterCodeType(String infoReporterCodeType) {
		this.infoReporterCodeType = infoReporterCodeType;
	}

	public String getInfoReporterCode() {
		return infoReporterCode;
	}

	public void setInfoReporterCode(String infoReporterCode) {
		this.infoReporterCode = infoReporterCode;
	}
	

	public String[] getServiceApiArray() {
		return serviceApiArray;
	}

	public void setServiceApiArray(String[] serviceApiArray) {
		this.serviceApiArray = serviceApiArray;
	}
	
	public Date getVerifyTime() {
		return verifyTime;
	}

	public void setVerifyTime(Date verifyTime) {
		this.verifyTime = verifyTime;
	}
}
