<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>用户管理</title>
	<meta name="decorator" content="default"/>
	<style type="text/css">
		.form-horizontal .control-label {
			width: 80px;
		}
		.form-horizontal .controls {
			margin-left: 100px;
		} 
		.span_index{ display:inline-block; border:#aaa solid 1px; border-radius:5px; padding:5px 12px; margin:5px 5px 5px; text-decoration:none; color:#999;cursor:pointer;}
		span.span_index.active{ color:#fff; background:#167ec7; }
	</style>
	<script type="text/javascript" src="${ctxStatic}/js/ca.js"></script>
	<script type="text/javascript" src="${ctxStatic}/js/CryptoKit.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#btnExport").click(function(){
				top.$.jBox.confirm("确认要导出用户数据吗？","系统提示",function(v,h,f){
					if(v=="ok"){
						$("#searchForm").attr("action","${ctx}/sys/user/export");
						$("#searchForm").submit();
					}
				},{buttonsFocus:1});
				top.$('.jbox-body .jbox-icon').css('top','55px');
			});
			$("#btnImport").click(function(){
				$.jBox($("#importBox").html(), {title:"导入数据", buttons:{"关闭":true}, 
					bottomText:"导入文件不能超过5M，仅允许导入“xls”或“xlsx”格式文件！"});
			});
			
		});
		function page(n,s){
			if(n) $("#pageNo").val(n);
			if(s) $("#pageSize").val(s);
			$("#searchForm").attr("action","${ctx}/sys/user/list");
			$("#searchForm").submit();
	    	return false;
	    }
	    
	    
	    //string转换成date
        function stringToDate(str){ 
            var tempStrs = str.split(" "); 
            var dateStrs = tempStrs[0].split("-"); 
            var year = parseInt(dateStrs[0], 10); 
            var month = parseInt(dateStrs[1], 10) - 1; 
            var day = parseInt(dateStrs[2], 10); 
            var timeStrs = tempStrs[1].split(":"); 
            var hour = parseInt(timeStrs [0], 10); 
            var minute = parseInt(timeStrs[1], 10); 
            var second = parseInt(timeStrs[2], 10); 
            var date = new Date(year, month, day, hour, minute, second); 
            return date; 
        }
	    
		
	</script>
</head>
<body>
	<div id="importBox" class="hide">
		<form id="importForm" action="${ctx}/sys/user/import" method="post" enctype="multipart/form-data"
			class="form-search" style="padding-left:20px;text-align:center;" onsubmit="loading('正在导入，请稍等...');"><br/>
			<input id="uploadFile" name="file" type="file" style="width:330px"/><br/><br/>　　
			<input id="btnImportSubmit" class="btn btn-primary" type="submit" value="   导    入   "/>
			<a href="${ctx}/sys/user/import/template">下载模板</a>
		</form>
	</div>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/sys/user/list?office.code=${office.code}&office.id=${office.id}">用户列表</a></li>
		<c:if test="${user.office.id != '4'}">
			<shiro:hasPermission name="sys:user:edit"><li><a href="${ctx}/sys/user/form?office.code=${office.code}">用户添加</a></li></shiro:hasPermission>
		</c:if>
	</ul>
	<form:form id="searchForm" modelAttribute="user" action="${ctx}/sys/user/list" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<sys:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
		<%-- 	<li>
			<label>归属公司：</label>
			<sys:treeselect id="company" name="company.id" value="${user.company.id}" labelName="company.name" labelValue="${user.company.name}" 
				title="公司" url="/sys/office/treeData?type=1" cssClass="input-small" allowClear="true"/>
			</li> --%>
			<li><label>登录名：</label><form:input path="loginName" htmlEscape="false" maxlength="50" class="input-medium"/></li>
			<li class="clearfix">
			<label>所属公司：</label><sys:treeselect id="office" name="office.id" value="${user.office.id}" labelName="office.name" labelValue="${user.office.name}" 
				title="部门" url="/sys/office/treeData?type=2" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/></li>
			<li><label>姓&nbsp;&nbsp;&nbsp;名：</label><form:input path="name" htmlEscape="false" maxlength="50" class="input-medium"/></li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
				<%-- <input id="btnExport" class="btn btn-primary" type="button" value="导出"/>
				<c:if test="${user.office.id != '4'}"><input id="btnImport" class="btn btn-primary" type="button" value="导入"/> </c:if>--%></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead><tr><th>公司</th><th class="sort-column login_name">登录名</th><th class="sort-column name">姓名</th><th>电话</th><th>手机</th><th>注册时间</th><%--<th>角色</th> --%><shiro:hasPermission name="sys:user:edit"><th>操作</th></shiro:hasPermission></tr></thead>
		<tbody>
		<c:forEach items="${page.list}" var="user">
			<tr>
				<td>${user.office.name}</td>
				<td>
				<a href="${ctx}/sys/user/form?id=${user.id}">${user.loginName}</a>
				</td>
				<td>${user.name}</td>
				<td>${user.phone}</td>
				<td>${user.mobile}</td>
				<td><fmt:formatDate value="${user.createDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
				<shiro:hasAnyPermissions name="sys:user:edit,sys:user:managerca">
				<td>
					<shiro:hasPermission name="sys:user:edit">
    				<a href="${ctx}/sys/user/form?id=${user.id}">修改</a>
					<a href="${ctx}/sys/user/delete?id=${user.id}" onclick="return confirmx('确认要删除该用户吗？', this.href)">删除</a>
					</shiro:hasPermission>
				</td>
				</shiro:hasAnyPermissions>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
