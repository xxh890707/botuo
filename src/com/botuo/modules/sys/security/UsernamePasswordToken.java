/**
 * 
 */
package com.botuo.modules.sys.security;

/**
 * 用户和密码（包含验证码）令牌类
 * 
 * 5-19
 */
public class UsernamePasswordToken extends org.apache.shiro.authc.UsernamePasswordToken {

	private static final long serialVersionUID = 1L;

	private String captcha;
//	private boolean mobileLogin;
//	private boolean caLogin;
//	private String userType;


	public UsernamePasswordToken() {
		super();
	}

	public UsernamePasswordToken(String username, char[] password,
			boolean rememberMe, String host, String captcha) {
		super(username, password, rememberMe, host);
		this.captcha = captcha;
//		this.mobileLogin = mobileLogin;
//		this.caLogin = caLogin;
//		this.userType = userType;
	}

	public String getCaptcha() {
		return captcha;
	}

	public void setCaptcha(String captcha) {
		this.captcha = captcha;
	}

//	public boolean isMobileLogin() {
//		return mobileLogin;
//	}
//	public boolean isCaLogin() {
//		return caLogin;
//	}
//
//	public void setCaLogin(boolean caLogin) {
//		this.caLogin = caLogin;
//	}
//	public String getUserType() {
//		return userType;
//	}
//
//	public void setUserType(String userType) {
//		this.userType = userType;
//	}
	
}