package com.botuo.common.security.shiro;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import com.botuo.modules.sys.utils.UserUtils;

public class FlowMenuPermissionTag extends TagSupport {
	/**
	 * 
	 */
	private static final long serialVersionUID = -7947963429481475564L;
	private String name;
	private String bidSectionStatus;
	public String getBidSectionStatus() {
		return bidSectionStatus;
	}
	public void setBidSectionStatus(String bidSectionStatus) {
		this.bidSectionStatus = bidSectionStatus;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	@Override
	public int doStartTag() throws JspException {
		if(UserUtils.getUser().isAdmin()){
			return super.doEndTag();
		}
		return super.doStartTag();
	}
}
