<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>医学元素表管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/bmd/medicalElement/">检测元素表列表</a></li>
		<shiro:hasPermission name="bmd:medicalElement:edit"><li><a href="${ctx}/bmd/medicalElement/form?medicalType.id=${medicalType.id}">检测元素表添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="medicalElement" action="${ctx}/bmd/medicalElement/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>名称：</label>
				<form:input path="name" htmlEscape="false" maxlength="200" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>名称</th>
				<th>英文名</th>
				<th>参考值（成人）</th>
				<th>标准值（成人）</th>
				<th>参考值（儿童）</th>
				<th>标准值（儿童）</th>
				<th>排序</th>
				<th>更新时间</th>
				<shiro:hasPermission name="bmd:medicalElement:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="medicalElement">
			<tr>
				<td><a href="${ctx}/bmd/medicalElement/form?id=${medicalElement.id}">
					${medicalElement.name}
				</a></td>
				<td>
					${medicalElement.ename}
				</td>
				<td>
					${medicalElement.referenceAdult}
				</td>
				<td>
					${medicalElement.standardAdult}
				</td>
				<td>
					${medicalElement.referenceChildren}
				</td>
				<td>
					${medicalElement.standardAdult}
				</td>
				<td>
					${medicalElement.sort}
				</td>
				<td>
					<fmt:formatDate value="${medicalElement.updateDate}" pattern="yyyy-MM-dd"/>
				</td>
				<shiro:hasPermission name="bmd:medicalElement:edit"><td>
    				<a href="${ctx}/bmd/medicalElement/form?id=${medicalElement.id}">修改</a>
					<a href="${ctx}/bmd/medicalElement/delete?id=${medicalElement.id}" onclick="return confirmx('确认要删除该医学元素表吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>