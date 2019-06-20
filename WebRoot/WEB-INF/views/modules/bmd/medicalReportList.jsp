<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>检查报告表管理</title>
	<meta name="decorator" content="default"/>
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
					$.jBox($("#printBox").html(), {title:"打印模板", buttons:{"关闭":true}, 
						bottomText:"请选择打印模板！"});
				}else{
					alertx("请先选择你要打印的数据");
				}
			});
			
			//批量删除
			$("#delete").click(function(){
				var checkVal = "";
				$("input[name='id']:checkbox:checked").each(function(){ 
					checkVal+=$(this).val()+",";
				});
				if(checkVal){
					confirmx('确认要删除报告吗？', "${ctx}/bmd/medicalReport/deleteAll?type=${medicalReport.type}&ids="+checkVal);
				}else{
					alertx("请先选择你要删除的数据");
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
		
		function checkeds(){   
			$(":checkbox").each(function(){
				if(this.checked == true){
					 $("th[name='"+$(this).val()+"']").css({"display":"inline-block","width":"40px"});
				     $("td[name='"+$(this).val()+"']").css({"display":"inline-block","width":"40px"});
				 }else{
					 $("th[name='"+$(this).val()+"']").css({"display":"none"});
				     $("td[name='"+$(this).val()+"']").css({"display":"none"});
				 }
			        
			   });  
			} 
		
		function importXls(id){
			$("#importId").val(id);
			$.jBox($("#importBox").html(), {title:"导入数据", buttons:{"关闭":true}, 
				bottomText:"导入文件不能超过5M，仅允许导入“xls”或“xlsx”格式文件！"});
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
	.table {
		width:auto;
		white-space:nowrap;
	}
	.table th,
	.table td {
		padding:0 10px;
	}
	.alv-select-boxs {
		border:1px solid #cecece;
		padding:5px;
		margin-bottom:8px;
	}
	</style>
</head>
<body>
	<form:form id="searchForm" modelAttribute="medicalReport" action="${ctx}/bmd/medicalReport/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<input id="exportFlag" name="exportFlag" type="hidden"/> 
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
			<form:option value="" >全部</form:option>
			<form:options items="${fns:getDictList('sex')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
		</form:select>&nbsp;&nbsp;
        <label>电话：</label>
		<form:input path="phone" htmlEscape="false" maxlength="50" class="input-small"/>&nbsp;
		<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>&nbsp;&nbsp;
  		<input id="export" class="btn btn-primary" type="button" onclick="exportExcel()"   value="导出"/>&nbsp;&nbsp;
 		<shiro:hasPermission name="bmd:medicalReport:edit">
		<c:if test="${medicalReport.type ==1}">
			<input id="export" class="btn btn-primary" type="button" onclick="importXls('1');" value="头发导入"/>&nbsp;&nbsp;
		</c:if>
		<c:if test="${medicalReport.type ==2}">
			<input id="export" class="btn btn-primary" type="button" onclick="importXls('2');" value="血液导入"/>&nbsp;&nbsp;
		</c:if>
		</shiro:hasPermission>
			</form:form>
		<input id="print" class="btn btn-primary" type="button"  value="批量打印"/>&nbsp;&nbsp;
		<input id="delete" class="btn btn-primary" type="button"  value="批量删除"/>&nbsp;&nbsp;
		
		<div class="alv-select-boxs">
			<label class="chelabel"><input type="checkbox" name="element" value="Zn" onclick="checkeds()">锌</em></label>
			<label class="chelabel"><input type="checkbox" name="element" value="Fe" onclick="checkeds()">铁</em></label>
			<label class="chelabel"><input type="checkbox" name="element" value="Cu" onclick="checkeds()">铜</em></label>
			<label class="chelabel"><input type="checkbox" name="element" value="Ca" onclick="checkeds()">钙</em></label>
			<label class="chelabel"><input type="checkbox" name="element" value="Mg" onclick="checkeds()">镁</em></label>
			<label class="chelabel"><input type="checkbox" name="element" value="Pb" onclick="checkeds()">铅</em></label>
			<label class="chelabel"><input type="checkbox" name="element" value="Mn" onclick="checkeds()">锰</em></label>
			<label class="chelabel"><input type="checkbox" name="element" value="Sr" onclick="checkeds()">锶</em></label>
			<label class="chelabel"><input type="checkbox" name="element" value="Cd" onclick="checkeds()">镉</em></label>
			<label class="chelabel"><input type="checkbox" name="element" value="Al" onclick="checkeds()">铝</em></label>
			<label class="chelabel"><input type="checkbox" name="element" value="Cr" onclick="checkeds()">铬</em></label>
			<label class="chelabel"><input type="checkbox" name="element" value="Ni" onclick="checkeds()">镍</em></label>
			<label class="chelabel"><input type="checkbox" name="element" value="Mo" onclick="checkeds()">钼</em></label>
			<label class="chelabel"><input type="checkbox" name="element" value="Co" onclick="checkeds()">钴</em></label>
			<label class="chelabel"><input type="checkbox" name="element" value="Ba" onclick="checkeds()">钡</em></label>
			<label class="chelabel"><input type="checkbox" name="element" value="V" onclick="checkeds()">钒</em></label>
			<label class="chelabel"><input type="checkbox" name="element" value="Ti" onclick="checkeds()">钛</em></label>
			<label class="chelabel"><input type="checkbox" name="element" value="B" onclick="checkeds()">硼</em></label>
			<label class="chelabel"><input type="checkbox" name="element" value="Sn" onclick="checkeds()">锡</em></label>
			<label class="chelabel"><input type="checkbox" name="element" value="K" onclick="checkeds()">钾</em></label>
			<label class="chelabel"><input type="checkbox" name="element" value="P" onclick="checkeds()">磷</em></label>
		</div>

	<sys:message content="${message}"/>
	<div style="width:100%; white-space:nowrap; overflow:auto;">
	<table id="contentTable" class="table table-striped table-bordered table-condensed" >
		<thead>
			<tr>
				<th><input type="checkbox" onchange="swapCheck();" /></th>
				<shiro:hasPermission name="bmd:medicalReport:edit"><th>操作</th></shiro:hasPermission>
				<th>批次</th>
				<th>出单日期</th>
				<th>编号</th>
				<th>姓名</th>
				<th>性别</th>
				<th>年龄</th>
				<th>电话</th>
				<th>送样地址</th>
				<th name="Zn">锌</th><th name="Fe">铁</th><th name="Cu">铜</th><th name="Ca">钙</th><th name="Mg">镁</th><th name="Pb">铅</th><th name="Mn">锰</th><th name="Sr">锶</th><th name="Cd">镉</th><th name="Al">铝</th><th name="Cr">铬</th><th name="Ni">镍</th><th name="Mo">钼</th><th name="Co">钴</th><th name="Ba">钡</th><th name="V">钒</th><th name="Ti">钛</th><th name="B">硼</th><th name="Sn">锡</th><th name="K">钾</th><th name="P">磷</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="medicalReport">
			<tr>
				<td><input type="checkbox" name="id" value="${medicalReport.id}" /></td>
				<shiro:hasPermission name="bmd:medicalReport:edit"><td>
    				<a href="${ctxFrontPath}/report/detail?id=${medicalReport.id}&type=${medicalReport.type}" target="_blank">查看</a>&nbsp;
    				<a href="${ctx}/bmd/medicalReport/update?id=${medicalReport.id}&type=${medicalReport.type}">修改</a>&nbsp;
    				<a href="${ctx}/bmd/medicalReport/delete?id=${medicalReport.id}" onclick="return confirmx('确认要删除该报告吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
				<td>
					${medicalReport.batch}
				</td>
				<td>
					<fmt:formatDate value="${medicalReport.detectionDate}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
					<fmt:formatNumber value="${medicalReport.reportNum}" />
				</td>
				<td>
					<a href="${ctxFrontPath}/report/detail?id=${medicalReport.id}&type=${medicalReport.type}" target="_blank">${medicalReport.person}</a>
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
				<td name="Zn">
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
				</td><td name="Pb">
					<c:if test="${medicalReport.type ==1}"><fmt:formatNumber value="${medicalReport.pb}" pattern="#0.0"/></c:if>
					<c:if test="${medicalReport.type ==2}"><fmt:formatNumber value="${medicalReport.pb}" pattern="#0.000"/></c:if>
				</td><td name="Mn">
					<c:if test="${medicalReport.type ==1}"><fmt:formatNumber value="${medicalReport.mn}" pattern="#0.0"/></c:if>
					<c:if test="${medicalReport.type ==2}"><fmt:formatNumber value="${medicalReport.mn}" pattern="#0.000"/></c:if>
				</td><td name="Sr">
					<fmt:formatNumber value="${medicalReport.sr}" pattern="#0.00"/>
				</td><td name="Cd">
					<fmt:formatNumber value="${medicalReport.cd}" pattern="#0.00"/>
				</td><td name="Al">
					<fmt:formatNumber value="${medicalReport.al}" pattern="#0.0"/>
				</td><td name="Cr">
					<fmt:formatNumber value="${medicalReport.cr}" pattern="#0.00"/>
				</td><td name="Ni">
					<fmt:formatNumber value="${medicalReport.ni}" pattern="#0.00"/>
				</td><td name="Mo">
					<fmt:formatNumber value="${medicalReport.mo}" pattern="#0.00"/>
				</td><td name="Co">
					<fmt:formatNumber value="${medicalReport.co}" pattern="#0.00"/>
				</td><td name="Ba">
					<fmt:formatNumber value="${medicalReport.ba}" pattern="#0.00"/>
				</td><td name="V">
					<fmt:formatNumber value="${medicalReport.v}" pattern="#0.00"/>
				</td><td name="Ti">
					<fmt:formatNumber value="${medicalReport.ti}" pattern="#0.00"/>
				</td><td name="B">
					<fmt:formatNumber value="${medicalReport.b}" pattern="#0.00"/>
				</td><td name="Sn">
					<fmt:formatNumber value="${medicalReport.sn}" pattern="#0.00"/>
				</td><td name="K">
					<fmt:formatNumber value="${medicalReport.k}" pattern="#0.0"/>
				</td><td name="P">
					<fmt:formatNumber value="${medicalReport.p}" pattern="#0.0"/>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	</div>
	<div class="pagination">${page}</div>
	
	<div id="importBox" class="hide">
		<form id="importForm" action="${ctx}/bmd/medicalReport/import" method="post" enctype="multipart/form-data"
			class="form-search" style="padding-left:20px;text-align:center;" onsubmit="loading('正在导入，请稍等...');"><br/>
			<input type="hidden" id="importId" name="type" value="" /> 
			<input id="uploadFile" name="file" type="file" style="width:330px"/><br/><br/>　　
			<input id="btnImportSubmit" class="btn btn-primary" type="submit" value="   导    入   "/>
			<%-- <a href="${ctx}/sys/user/import/template">下载模板</a> --%>
		</form>
	</div>
	
	<div id="printBox" class="hide">
		<div>
			<form:form id="printForm" modelAttribute="medicalReport" action="${ctx}/bmd/medicalReport/print" method="post" target="_blank"
				class="form-search" style="padding-left:20px;text-align:center;"><br/>
				<input type="hidden" id="printId" name="printId" value="" /> 
				<input type="hidden" id="company" name="company" value="1" /> 
				<input id="type" name="type" type="hidden" value="${medicalReport.type}"/>
				选择模板：
					<input type="radio" name="template" value="xue_6" />血六
					<input type="radio" name="template" value="xue_8" />血八 
					<!--<input type="radio" name="template" value="fa_6" />发六-->
					<input type="radio" name="template" value="fa_8" />发八
					<input type="radio" name="template" value="fa_20" />发二十
					<input type="radio" name="template" value="yjy" />研究院
				<br/><br/>　　
				<input id="btnImportSubmit" class="btn btn-primary" type="submit" value="   打    印   "/>
				<%-- <a href="${ctx}/sys/user/import/template">下载模板</a> --%>
			</form:form>
		</div>
	</div>
</body>
</html>