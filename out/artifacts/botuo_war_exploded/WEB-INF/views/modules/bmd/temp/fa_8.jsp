<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fns" uri="/WEB-INF/tlds/fns.tld" %>
<html>
<head>
	<title>检查报告打印</title>
	<meta charset="utf-8">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/print_A5.css" media="print">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/print_A5.css">


  </head>
  
<body>
        <div class="printbox fontsize_15">
            
            <p style="text-align:right"><span style="display:none">检测号：</span><span>${medicalReport.reportNum}</span></p>
            <div class="kongge">
                <img src="${pageContext.request.contextPath}/static/images/title_toufa.jpg">
            </div>


            <div class="ewmbox">
                <div class="ewm"><img src="${medicalReport.gscode}"></div>
                <div class="ewmp">扫描右边的二维码<br>在线查询报告单</div>
            </div>

            <table cellpadding="0" cellspacing="0" class="table_2 fontsize_15">
                <tr>
                    <td style="width: 17%">姓名：<span>${medicalReport.person}</span></td>
                    <td style="width: 10%">性别：<span>${fns:getDictLabel(medicalReport.sex,'sex','') }</span></td>
                    <td style="width: 15%">年龄：<span>${medicalReport.age}</span></td>
                    <td style="width: 58%">来样单位：<span>${medicalReport.deliverUnit}</span></td>
                </tr>
                <tr>
                    <td colspan="3">&nbsp;</td>
                    <td><span style="display:none">电话：</span>
                        <span style="padding-left:80px;"><fmt:formatNumber value="${medicalReport.phone}" pattern="#" /></span>
                    </td>
                </tr>
            </table>

            <table cellpadding="0" cellspacing="0" class="table fontsize_15">
                <tr>
                    <td colspan="2" style="width:12%">元素(μg/g)</td>
                    <td style="width:11%">锌(Zn)</td>
                    <td style="width:11%">铁(Fe)</td>
                    <td style="width:11%">铜(Cu)</td>
                    <td style="width:11%">钙(Ca)</td>
                    <td style="width:11%">镁(Mg)</td>
                    <td style="width:11%">锰(Mn)</td>
                    <td style="width:11%">钾(K)</td>
                    <td style="width:11%">铅(Pb)</td>
                </tr>
                <tr>
                    <td rowspan="2" style="width: 6%">参<br>考<br>值</td>
                    <td>儿童</td>
                    <td class="whitespace">111.2<br>87.7-134.5</td>
                    <td class="whitespace">29.6<br>8.9-64.8</td>
                    <td class="whitespace">10.7<br>5.7-19.5</td>
                    <td class="whitespace">849<br>380-1115</td>
                    <td class="whitespace">64.8<br>20.0-129.2</td>
                    <td class="whitespace">4.0<br>2.1-8.5</td>
                    <td class="whitespace">155.1<br>80.2-303</td>
                    <td class="whitespace">&lt;10.0</td>
                </tr>
                <tr>
                    <td>成人</td>
                    <td class="whitespace">127.7<br>105.7-159.7</td>
                    <td class="whitespace">35.2<br>8.9-94.9</td>
                    <td class="whitespace">11.6<br>6.5-23.9</td>
                    <td class="whitespace">1034<br>380-1343</td>
                    <td class="whitespace">74.4<br>21.9-150.2</td>
                    <td class="whitespace">4.6<br>2.4-9.4</td>
                    <td class="whitespace">210.4<br>150.4-734</td>
                    <td class="whitespace">&lt;10.0</td>
                </tr>
                <tr>
                    <td colspan="2">检测值(μg/g)</td>
                    <td>
                 		<c:if test="${empty medicalReport.zn}">/</c:if>
                 		<c:if test="${!empty medicalReport.zn}"><fmt:formatNumber value="${medicalReport.zn}" pattern="#0.0" /></c:if>
                 	</td>
                 	<td>
                 		<c:if test="${empty medicalReport.fe}">/</c:if>
                 		<c:if test="${!empty medicalReport.fe}"><fmt:formatNumber value="${medicalReport.fe}" pattern="#0.0" /></c:if>
                 	</td>
                 	<td>
                 		<c:if test="${empty medicalReport.cu}">/</c:if>
                 		<c:if test="${!empty medicalReport.cu}"><fmt:formatNumber value="${medicalReport.cu}" pattern="#0.0" /></c:if>
                 	</td>
                 	<td>
                 		<c:if test="${empty medicalReport.ca}">/</c:if>
                 		<c:if test="${!empty medicalReport.ca}"><fmt:formatNumber value="${medicalReport.ca}" pattern="#" /></c:if>
                 	</td>
                 	<td>
                 		<c:if test="${empty medicalReport.mg}">/</c:if>
                 		<c:if test="${!empty medicalReport.mg}"><fmt:formatNumber value="${medicalReport.mg}" pattern="#0.0" /></c:if>
                 	</td>
                 	<td>
                 		<c:if test="${empty medicalReport.mn}">/</c:if>
                 		<c:if test="${!empty medicalReport.mn}"><fmt:formatNumber value="${medicalReport.mn}" pattern="#0.0" /></c:if>
                 	</td>
                 	<td>
                 		<c:if test="${empty medicalReport.k}">/</c:if>
                 		<c:if test="${!empty medicalReport.k}"><fmt:formatNumber value="${medicalReport.k}" pattern="#0.0" /></c:if>
                 	</td>
                 	<td>
                 		<c:if test="${empty medicalReport.pb}">/</c:if>
                 		<c:if test="${!empty medicalReport.pb}"><fmt:formatNumber value="${medicalReport.pb}" pattern="#0.0" /></c:if>
                 	</td>
                </tr>
            </table>

            <div class="nbsp_10"></div>
            <table cellpadding="0" cellspacing="0" class="table_2 fontsize_15">
                <tr>
                    <td style="width: 70%;">分析人：<span>唐志鹏</span></td>
                    <td style="width: 30%;">报告日期：<span><fmt:formatDate type="date" value="${medicalReport.detectionDate}" pattern="yyyy-MM-dd"/></span></td>
                </tr>
            </table>
            <ul class="ultable fontsize_15">
                <li class="w35">说明:</li>
                <li class="whitespacenormal">
                    1、此报告仅对送检样本负责！结果仅用于医学保健目的,仅供医生参考使用,不作为职业病或铅中毒诊断的依据。<br>
                    2、取样方法：用不锈钢剪刀在后脑部贴近头皮处剪取头发不少于0.5g，已染色的头发不予检测。
                </li>
            </ul>
            <ul class="ultable fontsize_15">
                <li class="w35">地址：</li>
                <li class="whitespacenormal">广州科学城崖鹰石路10号中山大学国家大学科技园。电话：020-37630722</li>
            </ul>            

        </div>
    </body>
</html>