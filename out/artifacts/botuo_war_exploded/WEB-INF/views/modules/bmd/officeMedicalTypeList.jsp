<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>公司报告类型表管理</title>
	<meta name="decorator" content="default"/>
	
	<script type="text/javascript">
		$(document).ready(function() {
/* 			$("#btnImport").click(function(){
				$.jBox($("#importBox").html(), {title:"导入数据", buttons:{"关闭":true}, 
					bottomText:"导入文件不能超过5M，仅允许导入“xls”或“xlsx”格式文件！"});
			}); */
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
		
		function importXls(id){
			$("#importId").val(id);
			$.jBox($("#importBox").html(), {title:"导入数据", buttons:{"关闭":true}, 
				bottomText:"导入文件不能超过5M，仅允许导入“xls”或“xlsx”格式文件！"});
		}
		
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/bmd/officeMedicalType/">公司报告类型表列表</a></li>
		<shiro:hasPermission name="bmd:officeMedicalType:edit"><li><a href="${ctx}/bmd/officeMedicalType/form?office.id=${office.id}">公司报告类型表添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="officeMedicalType" action="${ctx}/bmd/officeMedicalType/" method="post" class="breadcrumb form-search">
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
				<th>名称</th>
				<shiro:hasPermission name="bmd:officeMedicalType:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="officeMedicalType">
			<tr>
				<td><a href="${ctx}/bmd/officeMedicalType/form?id=${officeMedicalType.id}">
					${officeMedicalType.medicalType.name}
				</a></td>
				<td>
				<shiro:hasPermission name="bmd:medicalReport:edit">
					<a href="${ctx}/bmd/medicalReport/add?officeMedicalType.id=${officeMedicalType.id}">添加检测报告</a>
					<a href="javascript:void(0);" onclick="importXls('${officeMedicalType.id}');">导入检测数据数据</a>
				</shiro:hasPermission>
				<shiro:hasPermission name="bmd:officeMedicalType:edit">
    				<a href="${ctx}/bmd/officeMedicalType/form?id=${officeMedicalType.id}">修改检测报告</a>
					<a href="${ctx}/bmd/officeMedicalType/delete?id=${officeMedicalType.id}" onclick="return confirmx('确认要删除该公司报告类型表吗？', this.href)">删除</a>
				</shiro:hasPermission></td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
	
	<div id="importBox" class="hide">
		<form id="importForm" action="${ctx}/bmd/medicalReport/import" method="post" enctype="multipart/form-data"
			class="form-search" style="padding-left:20px;text-align:center;" onsubmit="loading('正在导入，请稍等...');"><br/>
			<input type="hidden" id="importId" name="officeMedicalType.id" value="" /> 
			<input id="uploadFile" name="file" type="file" style="width:330px"/><br/><br/>　　
			<input id="btnImportSubmit" class="btn btn-primary" type="submit" value="   导    入   "/>
			<%-- <a href="${ctx}/sys/user/import/template">下载模板</a> --%>
		</form>
	</div>
</body>
</html>