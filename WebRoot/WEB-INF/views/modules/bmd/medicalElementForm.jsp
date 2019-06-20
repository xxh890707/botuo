<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>医学元素表管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/bmd/medicalElement/">医学元素表列表</a></li>
		<li class="active"><a href="${ctx}/bmd/medicalElement/form?id=${medicalElement.id}">医学元素表<shiro:hasPermission name="bmd:medicalElement:edit">${not empty medicalElement.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="bmd:medicalElement:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="medicalElement" action="${ctx}/bmd/medicalElement/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="medicalType.id" htmlEscape="false" maxlength="32" class="input-xlarge "/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">名称：</label>
			<div class="controls">
				<form:input path="name" htmlEscape="false" maxlength="200" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">英文名：</label>
			<div class="controls">
				<form:input path="ename" htmlEscape="false" maxlength="200" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">排序：</label>
			<div class="controls">
				<form:input path="sort" htmlEscape="false" maxlength="11" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">标准值（成人）：</label>
			<div class="controls">
				<form:input path="bzzCr" htmlEscape="false" maxlength="50" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">参考值（成人小）：</label>
			<div class="controls">
				<form:input path="ckzCrs" htmlEscape="false" maxlength="50" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">参考值（成人大）：</label>
			<div class="controls">
				<form:input path="ckzCrb" htmlEscape="false" maxlength="50" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">标准值（儿童）：</label>
			<div class="controls">
				<form:input path="bzzEt" htmlEscape="false" maxlength="50" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">参考值（儿童小）：</label>
			<div class="controls">
				<form:input path="ckzEts" htmlEscape="false" maxlength="50" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">参考值（儿童大）：</label>
			<div class="controls">
				<form:input path="ckzEtb" htmlEscape="false" maxlength="50" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">标准值（女成人）：</label>
			<div class="controls">
				<form:input path="bzzNcr" htmlEscape="false" maxlength="50" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">参考值（女成人小）：</label>
			<div class="controls">
				<form:input path="ckzNcrs" htmlEscape="false" maxlength="50" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">参考值（女成人大）：</label>
			<div class="controls">
				<form:input path="ckzNcrb" htmlEscape="false" maxlength="50" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">标准值（女儿童）：</label>
			<div class="controls">
				<form:input path="bzzNet" htmlEscape="false" maxlength="50" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">参考值（女儿童小）：</label>
			<div class="controls">
				<form:input path="ckzNets" htmlEscape="false" maxlength="50" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">参考值（女儿童大）：</label>
			<div class="controls">
				<form:input path="ckzNetb" htmlEscape="false" maxlength="50" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注信息：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="1000" class="input-xxlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="bmd:medicalElement:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>