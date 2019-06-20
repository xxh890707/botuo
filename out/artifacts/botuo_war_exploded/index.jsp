<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/login/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<title>登录</title>
	<meta name="decorator" content="cms_default_${site.theme}"/>
	<link href="${ctxStatic}/css/login.css" type="text/css" rel="stylesheet" />
	<link href="${ctxStatic}/jquery-validation/1.11.0/jquery.validate.min.css" type="text/css" rel="stylesheet" />
	<link href="${ctxStatic}/jquery-jbox/2.3/Skins/Bootstrap/jbox.min.css" rel="stylesheet" />
	<script src="${ctxStatic}/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>
	<script src="${ctxStatic}/jquery-validation/1.11.0/jquery.validate.min.js" type="text/javascript"></script>
	<script src="${ctxStatic}/jquery-jbox/2.3/jquery.jBox-2.3.min.js" type="text/javascript"></script>
	<style type="text/css">
			* {margin: 0; padding: 0;}
            html,body { overflow: hidden; width: 100%; height: 100%;}
			body { font-family: "微软雅黑"; background: #1b73c2 url('${ctxStatic}/images/loginibg.jpg') no-repeat top center/100%; color: #999; position: relative;}
            body a { color: #999; text-decoration: none; }
            body a:hover { color: #333; text-decoration: underline; }
            .login-sec {
                /*margin: 300px auto 0 auto;*/
                width: 500px;
                height: 300px;
                background: #fff;
                border: 1px solid #fff;
                background: rgba(255,255,255,1);
                overflow: hidden;
                border-radius: 2px;
                padding: 3px;
                position: absolute;
                left: 50%;
                top: 50%;
                margin-top: 40px;
                -webkit-transform: translate(-50%,-50%);
                -moz-transform: translate(-50%,-50%);
                -ms-transform: translate(-50%,-50%);
                transform: translate(-50%,-50%);
            }
    		.login-div {
                width: 500px;
                height: 300px;
                background: #2698d3 url('${ctxStatic}/images/loginbox.jpg') no-repeat top center/100% 100%;
                margin: 0 auto;
                border-radius: 2px;
            }
            .login-div h1 {
                line-height: 50px;
                height: 50px;
                color: #2f2f2f;
                text-align: center;
                font-size: 20px;
                font-weight: normal;
            }
            .login-div .login {
                width: 428px;
                height: 362px;
                margin: 0 auto;
            }
            .login-div .login .error-box {
                height: 12px;
                line-height: 12px;
                font-size: 12px;
                padding: 15px 25px 5px 25px;
            }
            .login-div .login .error-box span {
                float: left;
                color: #fc355d;
            }
            /*.login-div .login .error-box span::after {
                content: " ";
                width: 12px;
                height: 12px;
                background: url(${ctxStatic}/images/error.gif) no-repeat top center/100%;
                float: left;
                display: block;
                margin-right: 5px;
            }*/
            .login-div .login ul {
                list-style: none;
                padding: 0px 25px 0 25px;
                margin: 0;
            }
            .login-div .login ul li .input-item {
                border: 1px solid #cfd5d9;
                height: 40px;
                overflow: hidden;
                background: #fff;
            }
            .login-div .login ul li .input-item span {
                width: 40px;
                display: block;
                line-height: 40px;
                font-size: 14px;
                float: left;
                height: 40px;
                text-align: center;
            }
            .login-div .login ul li .input-item span.name-i{
                background: url(${ctxStatic}/images/login-name-ico.jpg) no-repeat top center;
            }
            .login-div .login ul li .input-item span.pswd-i{
                background: url(${ctxStatic}/images/login-pswd-ico.jpg) no-repeat top center;
            }
            .login-div .login ul li input {
                border: none;
                /*background: #999;*/
                height: 28px;
                padding: 6px 0;
                line-height: 28px;
                font-size: 16px;
                width: 280px;
                float: left;
                outline: none;
                outline: medium;
            }
            .login-div .login ul .errorsed {
                height: 10px;
                line-height: 10px;
            }
            .login-div .login ul .errorsed span {
                display: none;
            }
            .login-div .login ul .errorsed span {

            }
            .login-div .login .login-btn {
                border: 1px solid #29aae1;
                background: #29aae1;
                height: 50px;
                line-height: 50px;
                text-align: center;
                color: #fff;
                overflow: hidden;
                display: block;
                -webkit-transition: all linear 1s;
                -moz-transition: all linear 1s;
                -ms-transition: all linear 1s;
                transition: all linear 1s;
            }
            .login-div .login .login-btn:hover {
                background: #1286b8;
                text-decoration: none;
            }
            .login-div .login .not {
                font-size: 12px;
                text-align: center;
                padding-top: 10px;
                color: #eef7fb;
            }
            .bottom {
                height: 30px;
                line-height: 30px;
                text-align: center;
                width: 100%;
                /*border-top: 2px solid #f3e500;*/
                /*background: #fff;*/
                color: #fff;
                font-size: 12px;
                position: absolute;
                left: 0;
                bottom: 0;
            }
            .bottom a {
                color: #fff;
            }
        </style>

	<script type="text/javascript">
		var nowDate = "${nowDate}";
		var ctx = "${ctx}";
		var ctxStatic = "${ctxStatic}";
		var proCtx = "${pageContext.request.contextPath}";
		$(document).ready(function() {
			

			
			$("#username").focus();
			//回车事件
			$("#loginForm input").keydown(function(event){
				if(event.keyCode == 13){
					$("#userLoginSubmitId").trigger("click");
				}
			});
			
			$("#userLoginSubmitId").click(function(){
				top.$.jBox.tip('登录中...','loading',{opacity:0});
				$(this).text('登录中...').attr("disabled");
				setTimeout(function(){
					top.$.jBox.closeTip();
					$("#userLoginSubmitId").text('立刻登录').removeAttr("disabled");
				}, 30000);
			});
		});
	</script>
	<script type="text/javascript" src="${ctxStatic}/js/frontIndex.js"></script>
</head>
<body>
<div class="login-sec">
            
            <div class="login-logo">
                
            </div>
            <div class="login-div">
                <h1>用户登录</h1>
                <div class="login">
                   <!-- 错误信息提示 -->
                    <div class="error-box">
                        
                        <%--  <span id="messageBox">${message }！</span>--%>
						<span id="messageBox" class="alert alert-error hide">
							<label id="loginError" style="width:220px;text-shadow:0;" >${message}</label>
						</span>
                    </div>
                    <!-- 错误信息提示结束 --> 
         			    
			    <form id="loginForm" method="post">
                    <ul>
                        <li>
                            <div class="input-item">
                                <span class="name-i"></span>
                                <input type="text" placeholder="输入账号" name="username" id="username">
                            </div>
                        </li>

                        <li class="errorsed"><!-- 请勿删除li --></li>

                        <li>
                            <div class="input-item">
                                <span class="pswd-i"></span>
                                <input type="password" placeholder="输入密码" id="password" name="password">
                            </div>
                        </li>

                        <li class="errorsed"><!-- 请勿删除li --></li>

                        <li>
                            <a class="login-btn" id="userLoginSubmitId" href="javascript:;" onclick="userLoginSubmit();">立刻登录</a>
                        </li>
                        <li class="not">
                            <p>忘记密码找系统管理员!</p>
                        </li>
                    </ul>
                    </form>
                </div>
            </div>

        </div>
        <div class="bottom">
            版权所有 © 广州市博拓生物医学科技有限公司 <a href="http://www.miitbeian.gov.cn/" target="_blank">粤ICP备18019762号-1</a> 技术支持：<a href="http://www.soowork.com" title="SOOWORK" target="_blank">SOWOORK.COM</a>
        </div>
    </body>
<%-- 	<div class="login-wrap">
	<div class="banner-show">
		<div class="cell bns-01">
			<div class="con"><img src="${ctxStatic }/images/login-bg.png"></div>
		</div>
	</div>
	<div class="login-container">
		<div class="register-box">
        	<!--登陆框-->
			<div class="tk_login reg-form">
				<div class="pop_header">
			    	<ul id="loginul">
						<li class="menub1_1" id="menutab_1">用户登陆</li>
			        </ul>
			        
			    </div>
			    <!--用户登录框-->
			    <div class="menugtab" id="menutab_1_div">
			    <form id="loginForm" method="post">
			    <span id="messageBox" class="alert alert-error hide">
						<label
						id="loginError" style="width:220px;text-shadow:0;" class="error">${message}</label>
					</span>
			    	<!--登录信息-->

					<div class="cell">
	                	<i class="user"></i>
						<input type="text" name="username" id="username" placeholder="请填写用户名" class="text required" value="${username }"/>
					</div>
					<div class="cell">
	                	<i class="pwd"></i>
						<input type="password" id="password" name="password" placeholder="请输入密码" class="text required"/>
	                </div>
	                <c:if test="${isValidateCodeLogin}">
					<div class="validateCode" id="valid_box" style="margin: 0 0 8px 0px;">
						<sys:validateCode name="validateCode" inputCssStyle="margin-bottom:0;padding: 9px 11px 9px 45px;"/>
					</div>
					</c:if>
					<div class="bottom">
						<a href="javascript:;" id="userLoginSubmitId" onclick="userLoginSubmit();" class="button btn-green">立即登录</a>
	                </div>
	                <!--登录信息完-->
	                </form>        
			    </div>
			</div>
			<!--end-->
		</div>
        <!--用户登陆完-->
	</div>
</div> --%>
</html>