<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>检查报告表管理</title>
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
		<li class="active"><a href="${ctx}/bmd/medicalReport/">检查报告表列表</a></li>
		<shiro:hasPermission name="bmd:medicalReport:edit"><li><a href="${ctx}/bmd/medicalReport/form">检查报告表添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="medicalReport" action="${ctx}/bmd/medicalReport/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>报告名称</th>
				<shiro:hasPermission name="bmd:medicalReport:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="medicalReport">
			<tr>
				<td><a href="${ctx}/bmd/medicalReport/form?id=${medicalReport.id}" target="_blank">
					${medicalReport.name}
				</a></td>
				<td>
					${medicalReport.reportNum}
				</td>
				<td>
					${medicalReport.person}
				</td>
				<td>
					${fns:getDictLabel(medicalReport.sex,'sex','') }
				</td>
				<td>
					${medicalReport.age}
				</td>
				<td>
					${medicalReport.deliverUnit}
				</td>
				<td>
					<fmt:formatDate value="${medicalReport.detectionDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<shiro:hasPermission name="bmd:medicalReport:edit"><td>
    				<a href="${ctx}/bmd/medicalReport/form?id=${medicalReport.id}" target="_blank">查看</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>