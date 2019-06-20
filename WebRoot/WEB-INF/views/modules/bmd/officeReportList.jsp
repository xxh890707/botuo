<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>检查报告表管理</title>
	<meta name="decorator" content="default"/>
		<style type="text/css">
	.form-search {
	overflow:hidden;}
	.form-search label{
		margin-bottom:15px;
	}
	.form-search label.chelabel {
		margin-bottom:0px;
		margin-left:0px;
		margin-right:5px;
		line-height:1;
	}
	.form-search label.chelabel em{
		font-style:normal;
		position: relative;
		top:2px;
	}
	.breadcrumb {
		padding:8px 15px 0 15px
	}
	.alv-select-boxs {
		border:1px solid #cecece;
		padding:5px;
		margin-bottom:8px;
	}
	</style>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#btnSubmit").click(function(){
				$("#exportFlag").val("");
			});
			
			//打印按钮
			$("#print").click(function(){
				var checkVal = "";
				$("input[name='id']:checkbox:checked").each(function(){ 
					checkVal+=$(this).val()+",";
				});
				if(checkVal){
					$("#printId").val(checkVal);
					$("#searchForm").submit();
				}else{
					alertx("请先选择你要变更的数据");
				}
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
		
		   var isCheckAll = false;  
	       function swapCheck() {  
	           if (isCheckAll) {  
	               $("input[name='id']").each(function() {  
	                   this.checked = false;  
	               });  
	               isCheckAll = false;  
	           } else {  
	               $("input[name='id']").each(function() {  
	                   this.checked = true;  
	               });  
	               isCheckAll = true;  
	           }  
	       } 
	</script>
</head>
<body>
		<form:form id="searchForm" modelAttribute="medicalReport" action="${ctx}/bmd/medicalReport/change" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<input type="hidden" id="printId" name="printId" value=""/>
		<form:input path="type" type="hidden" />
		<sys:multipleTreeselect id="office" name="office.id" value="${medicalReport.office.id}" labelName="office.name" labelValue="${medicalReport.office.name}" 
		title="部门" url="/sys/office/treeData" cssClass="input-small" allowClear="true" notAllowSelectParent="false" checked="false"/>
		<input id="print" class="btn btn-primary" type="button"  value=" 变   更  "/>&nbsp;&nbsp;
			</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th><input type="checkbox" onchange="swapCheck();" /></th>
	 			<th>批次</th> 
				<th>编号</th>
				<th>姓名</th>
				<th>出单日期</th>
				<th>性别</th>
				<th>年龄</th>
				<th>电话</th>
				<th>送样地址</th>
				<th id="Zn">锌</th>
				<th id="Fe">铁</th>
				<th id="Cu">铜</th>
				<th id="Ca">钙</th>
				<th id="Mg">镁</th>
				<th id="Pb">铅</th>
<!--				<th id="Mn">锰</th>
 			<th id="Sr">锶</th>
				<th id="Cd">镉</th>
				<th id="Al">铝</th>
				<th id="Cr">铬</th>
				<th id="Ni">镍</th>
				<th id="Mo">钼</th>
				<th id="Co">钴</th>
				<th id="Ba">钡</th>
				<th id="V">钒</th>
				<th id="Ti">钛</th>
				<th id="B">硼</th>
				<th id="Sn">锡</th> 	
				<th id="K">钾</th>-->
				<shiro:hasPermission name="bmd:medicalReport:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="medicalReport">
			<tr>
				<td><input type="checkbox" name="id" value="${medicalReport.id}" /></td>
 				<td><a href="${ctxFrontPath}/report/form?id=${medicalReport.id}" target="_blank">
					${medicalReport.batch}
				</a></td> 
				<td>
					<fmt:formatNumber value="${medicalReport.reportNum}" />
				</td>
				<td><a href="${ctxFrontPath}/report/form?id=${medicalReport.id}" target="_blank">
					${medicalReport.person}
				</a></td>
				<td>
					<fmt:formatDate value="${medicalReport.detectionDate}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
					${fns:getDictLabel(medicalReport.sex,'sex','') }
				</td>
				<td>
					${medicalReport.age}
				</td>
				<td>
					<fmt:formatNumber value="${medicalReport.phone}" pattern="#" />
				</td>
				<td>
					${medicalReport.deliverUnit}
				</td>
				<td id="Zn">
					<c:if test="${medicalReport.type ==1}"><fmt:formatNumber value="${medicalReport.zn}" pattern="#0.0" /></c:if>
					<c:if test="${medicalReport.type ==2}"><fmt:formatNumber value="${medicalReport.zn}" pattern="#.00" /></c:if>
				</td><td name="Fe">
					<c:if test="${medicalReport.type ==1}"><fmt:formatNumber value="${medicalReport.fe}" pattern="#0.0" /></c:if>
					<c:if test="${medicalReport.type ==2}"><fmt:formatNumber value="${medicalReport.fe}" pattern="#" /></c:if>
				</td><td name="Cu">
					<c:if test="${medicalReport.type ==1}"><fmt:formatNumber value="${medicalReport.cu}" pattern="#0.0" /></c:if>
					<c:if test="${medicalReport.type ==2}"><fmt:formatNumber value="${medicalReport.cu}" pattern="#0.00" /></c:if>
				</td><td name="Ca">
					<c:if test="${medicalReport.type ==1}"><fmt:formatNumber value="${medicalReport.ca}" pattern="#" /></c:if>
					<c:if test="${medicalReport.type ==2}"><fmt:formatNumber value="${medicalReport.ca}" pattern="#0.0" /></c:if>
				</td><td name="Mg">
					<fmt:formatNumber value="${medicalReport.mg}" pattern="#0.0" />
				</td><td name="Pb">
					<c:if test="${medicalReport.type ==1}"><fmt:formatNumber value="${medicalReport.pb}" pattern="#0.0" /></c:if>
					<c:if test="${medicalReport.type ==2}"><fmt:formatNumber value="${medicalReport.pb}" pattern="#0.000" /></c:if>
<!--				</td><td name="Mn">
					<fmt:formatNumber value="${medicalReport.mn}" pattern="#0.0" />
				</td><td name="K">
					<fmt:formatNumber value="${medicalReport.k}" pattern="#0.00" />
				</td>
 				<td id="Sr">${medicalReport.sr}</td>
				<td id="Cd">${medicalReport.cd}</td>
				<td id="Al">${medicalReport.al}</td>
				<td id="Cr">${medicalReport.cr}</td>
				<td id="Ni">${medicalReport.ni}</td>
				<td id="Mo">${medicalReport.mo}</td>
				<td id="Co">${medicalReport.co}</td>
				<td id="Ba">${medicalReport.ba}</td>
				<td id="V">${medicalReport.b}</td>
				<td id="Ti">${medicalReport.ti}</td>
				<td id="B">${medicalReport.b}</td>
				<td id="Sn">${medicalReport.sn}</td> -->
				<shiro:hasPermission name="bmd:medicalReport:edit"><td>
    				<a href="${ctxFrontPath}/report/form?id=${medicalReport.id}" target="_blank">查看</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</body>
</html>