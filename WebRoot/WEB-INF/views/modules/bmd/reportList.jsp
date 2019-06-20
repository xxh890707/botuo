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
					$("#printForm").submit();
				}else{
					alertx("请先选择你要打印的数据");
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
	<form:form id="searchForm" modelAttribute="medicalReport" action="${ctx}/bmd/medicalReport/reportList" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<input id="exportFlag" name="exportFlag" type="hidden" value=""/>
		<input id="type" name="type" type="hidden" value="${medicalReport.type}"/>
		<label>出单日期：</label>
		<input id="beginDate"  name="beginDate"  type="text" readonly="readonly" maxlength="20" class="input-medium Wdate" style="width:163px;"
			value=""
				onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"/>
			　--　
		<input id="endDate" name="endDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate" style="width:163px;"
			value=""
				onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"/>
		<label>批次：</label>
		<form:input path="batch" htmlEscape="false" maxlength="50" class="input-small"/>&nbsp;
		<label>编号：</label>
		<form:input path="reportNum" htmlEscape="false" maxlength="50" class="input-small"/>&nbsp;
		<label>姓名：</label>
		<form:input path="person" htmlEscape="false" maxlength="50" class="input-small"/>&nbsp;
		<label>送样地址：</label>
		<form:input path="deliverUnit" htmlEscape="false" maxlength="50" class="input-small"/>&nbsp;
		<label>性别：</label>
		<form:select path="sex" class="input-medium">
			<form:option value="">全部</form:option>
			<form:options items="${fns:getDictList('sex')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
		</form:select>&nbsp;&nbsp;
                <label>电话：</label>
		<form:input path="phone" htmlEscape="false" maxlength="50" class="input-small"/>&nbsp;
		<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>&nbsp;&nbsp;
		<!-- <input id="export" class="btn btn-primary" type="button" onclick="exportExcel()"   value="导出"/>&nbsp;&nbsp; -->
	</form:form>
		<input id="print" class="btn btn-primary" type="button"  value="批量打印"/>&nbsp;&nbsp;
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th><input type="checkbox" onchange="swapCheck();" /></th>
	 			<th>打印</th> 
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
				<th id="Mn">锰</th>
				<th id="K">钾</th>
 <!--			<th id="Sr">锶</th>
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
 				<td style="width: 20px;"><c:if test="${medicalReport.isPrint ==1}"><img src="${ctxStatic}/images/print.png" style="width: 20px;height: 20px;"></c:if>
 				</td> 
				<td>
					<fmt:formatNumber value="${medicalReport.reportNum}" />
				</td>
				<td><a href="${ctxFrontPath}/report/form?id=${medicalReport.id}&type=${medicalReport.type}" target="_blank">
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
					<c:if test="${' ' != medicalReport.phone}">
					<fmt:formatNumber value="${medicalReport.phone}" pattern="#" />
					</c:if>
				</td>
				<td>
					${medicalReport.deliverUnit}
				</td>
				<td id="Zn">
					<c:if test="${medicalReport.type ==1}"><fmt:formatNumber value="${medicalReport.zn}" pattern="#0.0"/></c:if>
					<c:if test="${medicalReport.type ==2}"><fmt:formatNumber value="${medicalReport.zn}" pattern="#0.00"/></c:if>
				</td><td name="Fe">
					<c:if test="${medicalReport.type ==1}"><fmt:formatNumber value="${medicalReport.fe}" pattern="#0.0"/></c:if>
					<c:if test="${medicalReport.type ==2}"><fmt:formatNumber value="${medicalReport.fe}" pattern="#"/></c:if>
				</td><td name="Cu">
					<c:if test="${medicalReport.type ==1}"><fmt:formatNumber value="${medicalReport.cu}" pattern="#0.0"/></c:if>
					<c:if test="${medicalReport.type ==2}"><fmt:formatNumber value="${medicalReport.cu}" pattern="#0.00"/></c:if>
				</td><td name="Ca">
					<c:if test="${medicalReport.type ==1}"><fmt:formatNumber value="${medicalReport.ca}" pattern="#"/></c:if>
					<c:if test="${medicalReport.type ==2}"><fmt:formatNumber value="${medicalReport.ca}" pattern="#0.0"/></c:if>
				</td><td name="Mg">
					<fmt:formatNumber value="${medicalReport.mg}" pattern="#0.0"/>
				</td>
				<td name ="Pb">
					<c:if test="${medicalReport.type ==1}"><fmt:formatNumber value="${medicalReport.pb}" pattern="#0.0"/></c:if>
					<c:if test="${medicalReport.type ==2}"><fmt:formatNumber value="${medicalReport.pb}" pattern="#0.000"/></c:if>
				</td><td name="Mn">
					<c:if test="${medicalReport.type ==1}"><fmt:formatNumber value="${medicalReport.mn}" pattern="#0.0"/></c:if>
					<c:if test="${medicalReport.type ==2}"><fmt:formatNumber value="${medicalReport.mn}" pattern="#0.000"/></c:if>
				</td><td name="K">
					<fmt:formatNumber value="${medicalReport.k}" pattern="#.0"/>
				</td>
<!-- 				<td id="Sr">${medicalReport.sr}</td>
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
    				<a href="${ctxFrontPath}/report/form?id=${medicalReport.id}&type=${medicalReport.type}" target="_blank">查看</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
	
		<div id="printBox" class="hide">
		<form:form id="printForm" modelAttribute="medicalReport" action="${ctx}/bmd/medicalReport/print" method="post" target="_blank"
			class="form-search" style="padding-left:20px;text-align:center;"><br/>
			<input type="hidden" id="printId" name="printId" value="" /> 
			<input type="hidden" id="company" name="company" value="0" /> 
			<input id="type" name="type" type="hidden" value="${medicalReport.type}"/>
			<br/><br/>　　
			<input id="btnImportSubmit" class="btn btn-primary" type="submit" value="   打    印   "/>
			<%-- <a href="${ctx}/sys/user/import/template">下载模板</a> --%>
		</form:form>
	</div>
</body>
</html>