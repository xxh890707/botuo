<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>检查报告表管理</title>
	<meta name="decorator" content="default"/>
	<link rel="stylesheet" type="text/css" media="screen" href="${ctxStatic}/jqGrid/css/ui.jqgrid.css" />
	<link rel="stylesheet" type="text/css" media="screen" href="${ctxStatic}/jqGrid/themes/cupertino/jquery-ui-1.10.3.custom.css" />
	<script src="${ctxStatic}/jqGrid/js/i18n/grid.locale-cn.js" type="text/javascript"></script> 
	<script src="${ctxStatic}/jqGrid/js/jquery.jqGrid.src.js" type="text/javascript"></script>
	<script src="${ctxStatic}/jqGrid/plugins/jquery.contextmenu.js" type="text/javascript"></script> 
	<script src="${ctxStatic}/js/PJ.js" type="text/javascript"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			var layout, grid, searchHeight, heightDiff = 155;
			$("#btnSubmit").click(function(){
				$("#exportFlag").val("");
			});
			
			
			grid = jQuery("#list1").jqGrid({
	         	url:'${ctx}/bmd/medicalReport/getPage',
		      	datatype: "json",
				width: PJ.getCenterWidth(),
				height: PJ.getCenterHeight() - heightDiff,
				shrinkToFit:false,
				rownumbers:true,
				multiselect:true,
		        colNames: ["主键", "批次", "报告日期", "编号", "姓名", "性别", "年龄", 
		                   "电话", "送样单位","锌","铁","铜","钙","镁","铅","锰","锶","镉","铝","铬","镍","钼","钴",
		                   "钡","钒","钛","硼","锡","钾",],
		        colModel:[
		            PJ.grid_column("id", { key: true, sortable: true, hidden: true }),
		            PJ.grid_column("batch", { sortable: true }),
		            PJ.grid_column("detectionDate", { sortable: true,width:100}),
		            PJ.grid_column("reportNum", { sortable: true,width:100}),
		            PJ.grid_column("person", { sortable: true, width: 100 }),
		            PJ.grid_column("sex", { sortable: true, width: 120 }),
		            PJ.grid_column("age", { sortable: true, width: 100 }),
		            PJ.grid_column("phone", { sortable: true,align:"center" }),
		            PJ.grid_column("deliverUnit", { sortable: true, width: 100 }),
		            PJ.grid_column("Zn", { sortable: true, width: 80 }),
		            PJ.grid_column("Fe", { sortable: true, width: 80 }),
		            PJ.grid_column("Cu", { sortable: true, width: 80 }),
		            PJ.grid_column("Ca", { sortable: true, width: 80 }),
		            PJ.grid_column("Mg", { sortable: true, width: 80 }),
		            PJ.grid_column("Pb", { sortable: true, width: 80 }),
		            PJ.grid_column("Mn", { sortable: true, width: 80 }),
		            PJ.grid_column("Sr", { sortable: true, width: 80 }),
		            PJ.grid_column("Cd", { sortable: true, width: 80 }),
		            PJ.grid_column("Al", { sortable: true, width: 80 }),
		            PJ.grid_column("Cr", { sortable: true, width: 80 }),
		            PJ.grid_column("Ni", { sortable: true, width: 80 }),
		            PJ.grid_column("Mo", { sortable: true, width: 80 }),
		            PJ.grid_column("Co", { sortable: true, width: 80 }),
		            PJ.grid_column("Ba", { sortable: true, width: 80 }),
		            PJ.grid_column("V", { sortable: true, width: 80 }),
		            PJ.grid_column("Ti", { sortable: true, width: 80 }),
		            PJ.grid_column("B", { sortable: true, width: 80 }),
		            PJ.grid_column("Sn", { sortable: true, width: 80 }),
		            PJ.grid_column("K", { sortable: true, width: 80 })
	        	],
	        	pager:"#pager1",
	        	sortname:"detectionDate",
	        	sortorder:"desc"
	        	
			 });
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
		
		function exportExcel(){
			$("#exportFlag").val("export");
			$("#searchForm").submit();
		}
		
		function importXls(id){
			$("#importId").val(id);
			$.jBox($("#importBox").html(), {title:"导入数据", buttons:{"关闭":true}, 
				bottomText:"导入文件不能超过5M，仅允许导入“xls”或“xlsx”格式文件！"});
		}
	</script>
</head>
<body>
	<form:form id="searchForm" modelAttribute="medicalReport" action="${ctx}/bmd/medicalReport/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<input id="exportFlag" name="exportFlag" type="hidden" value=""/>
		<label>批次：</label>
		<form:input path="batch" htmlEscape="false" maxlength="50" class="input-small"/>&nbsp;
		<label>编号：</label>
		<form:input path="reportNum" htmlEscape="false" maxlength="50" class="input-small"/>&nbsp;
		<label>姓名：</label>
		<form:input path="person" htmlEscape="false" maxlength="50" class="input-small"/>&nbsp;
		<label>性别：</label>
		<form:radiobutton path="sex" value="1"/>男   &nbsp;
        <form:radiobutton path="sex" value="0"/>女   &nbsp;&nbsp;
		<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>&nbsp;&nbsp;
		<input id="export" class="btn btn-primary" type="button" onclick="exportExcel()"   value="导出"/>&nbsp;&nbsp;<br />
		<shiro:hasPermission name="bmd:medicalReport:edit">
		<input id="export" class="btn btn-primary" type="button" onclick="importXls('1');" value="头发导入"/>&nbsp;&nbsp;
		<input id="export" class="btn btn-primary" type="button" onclick="importXls('2');" value="血液导入"/>&nbsp;&nbsp;
		</shiro:hasPermission>
	</form:form>
	<sys:message content="${message}"/>
	<table id="list1"></table>
	<div id="pager1"></div>
	
	<div id="importBox" class="hide">
		<form id="importForm" action="${ctx}/bmd/medicalReport/import" method="post" enctype="multipart/form-data"
			class="form-search" style="padding-left:20px;text-align:center;" onsubmit="loading('正在导入，请稍等...');"><br/>
			<input type="hidden" id="importId" name="type" value="" /> 
			<input id="uploadFile" name="file" type="file" style="width:330px"/><br/><br/>　　
			<input id="btnImportSubmit" class="btn btn-primary" type="submit" value="   导    入   "/>
			<%-- <a href="${ctx}/sys/user/import/template">下载模板</a> --%>
		</form>
	</div>
</body>
</html>