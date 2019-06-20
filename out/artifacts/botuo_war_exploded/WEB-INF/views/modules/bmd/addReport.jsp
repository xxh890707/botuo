<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>检查报告表管理</title>
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
		<li><a href="${ctx}/bmd/medicalReport/">检查报告表列表</a></li>
		<li class="active"><a href="${ctx}/bmd/medicalReport/form?id=${medicalReport.id}">检查报告表<shiro:hasPermission name="bmd:medicalReport:edit">${not empty medicalReport.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="bmd:medicalReport:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="medicalReport" action="${ctx}/bmd/medicalReport/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="officeMedicalType.id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">报告编号：</label>
			<div class="controls">
				<form:input path="reportNum" htmlEscape="false" maxlength="50" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">检查人员：</label>
			<div class="controls">
				<form:input path="person" htmlEscape="false" maxlength="100" class="input-xlarge "/>
			</div>
		</div>
<%-- 		<div class="control-group">
			<label class="control-label">用户编号：</label>
			<div class="controls">
				<sys:treeselect id="user" name="user.id" value="${medicalReport.user.id}" labelName="user.name" labelValue="${medicalReport.user.name}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="" allowClear="true" notAllowSelectParent="true"/>
			</div>
		</div> --%>
		<div class="control-group">
			<label class="control-label">送样单位：</label>
			<div class="controls">
				<form:input path="deliverUnit" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">性别：</label>
			<div class="controls">
				<form:radiobuttons path="sex" items="${fns:getDictList('sex')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">age：</label>
			<div class="controls">
				<form:input path="age" htmlEscape="false" maxlength="50" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">检测方法：</label>
			<div class="controls">
				<form:input path="detectionMethod" htmlEscape="false" maxlength="100" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">技术负责人：</label>
			<div class="controls">
				<form:input path="technicalDirector" htmlEscape="false" maxlength="100" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">phone：</label>
			<div class="controls">
				<form:input path="phone" htmlEscape="false" maxlength="50" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">检测日期：</label>
			<div class="controls">
				<input name="detectionDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${medicalReport.detectionDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		<c:forEach items="${elements}" var="e" varStatus="i">
		<div class="control-group">
			<label class="control-label">${e.name }：</label>
			<div class="controls">
				<input name="results[${i.index}].elementId" value="${e.id}" type="hidden"  maxlength="50" class="input-xlarge "/> 
				<input name="results[${i.index}].value"  type="text"  maxlength="50" class="input-xlarge "/> 
			</div>
		</div>
		</c:forEach>
		<div class="control-group">
			<label class="control-label">备注信息：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="1000" class="input-xxlarge "/>
			</div>
		</div>

		<div class="form-actions">
			<shiro:hasPermission name="bmd:medicalReport:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>