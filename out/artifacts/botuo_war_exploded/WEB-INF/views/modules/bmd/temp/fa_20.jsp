<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fns" uri="/WEB-INF/tlds/fns.tld" %>
<html>
<head>
	<title>检查报告打印</title>
	<meta charset="utf-8">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/print_B5.css" media="print">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/print_B5.css">


  </head>
  
<body>

    <div class="printbox fontsize_14">

        <p style="text-align: right;"><span style="display: none">检测号：</span><span>${medicalReport.reportNum}</span></p>
            <div class="ewm"><img src="${medicalReport.gscode}"></div>
            <div class="ewmp">扫描右边的二维码<br>在线查询报告单</div>
            <div class="kongge">
                <img src="${pageContext.request.contextPath}/static/images/title_b5_yjzx_toufa.jpg">
            </div>

            <table cellpadding="0" cellspacing="0" class="table_2 fontsize_14">
                <tr>
                    <td style="width: 20%">姓名：<span>${medicalReport.person}</span></td>
                    <td style="width: 10%">性别：<span>${fns:getDictLabel(medicalReport.sex,'sex','') }</span></td>
                    <td style="width: 20%">年龄：<span>${medicalReport.age}</span></td>
                    <td style="width: 50%"><span style="display: none">电话：</span><span style="margin-left: 70px;"><fmt:formatNumber value="${medicalReport.phone}" pattern="#" /></span></td>
                </tr>
                <tr>
                    <td colspan="4">来样单位：<span>${medicalReport.deliverUnit}</span></td>
                </tr>
            </table>

            <div class="nbsp_5"></div>
            <table cellpadding="0" cellspacing="0" class="table fontsize_14">
                <tr>
                    <td colspan="2" style="width: 16%">元素<br>(μg/g)</td>
                    <td style="width: 12%">锌(Zn)</td>
                    <td style="width: 12%">铁(Fe)</td>
                    <td style="width: 12%">铜(Cu)</td>
                    <td style="width: 12%">钙(Ca)</td>
                    <td style="width: 12%">镁(Mg)</td>
                    <td style="width: 12%">锰(Mn)</td>
                    <td style="width: 12%">钾(K)</td>
                </tr>
                <tr>
                    <td rowspan="2" style="width: 8%;">参<br>考<br>值</td>
                    <td>儿童</td>
                    <td>111.2<br>87.7-134.5</td>
                    <td>29.6<br>8.9-64.8</td>
                    <td>10.7<br>5.7-19.5</td>
                    <td>849<br>380-1115</td>
                    <td>64.8<br>20.0-129.2</td>
                    <td>4.0<br>2.1-8.5</td>
                    <td>155.1<br>80.2-303</td>
                </tr>
                <tr>
                    <td>成人</td>
                    <td>127.7<br>105.7-159.7</td>
                    <td>35.2<br>8.9-94.9</td>
                    <td>11.6<br>6.5-23.9</td>
                    <td>1034<br>380-1343</td>
                    <td>74.4<br>21.9-150.2</td>
                    <td>4.6<br>2.4-9.4</td>
                    <td>210.4<br>150.4-734</td>
                </tr>
                <tr>
                    <td colspan="2">检测值<br>(μg/g)</td>
                    <td style="font-size: 20px;">
                 		<c:if test="${empty medicalReport.zn}">/</c:if>
                 		<c:if test="${!empty medicalReport.zn}"><fmt:formatNumber value="${medicalReport.zn}" pattern="#0.0" /></c:if>
                 	</td>
                 	<td style="font-size: 20px;">
                 		<c:if test="${empty medicalReport.fe}">/</c:if>
                 		<c:if test="${!empty medicalReport.fe}"><fmt:formatNumber value="${medicalReport.fe}" pattern="#0.0" /></c:if>
                 	</td>
                 	<td style="font-size: 20px;">
                 		<c:if test="${empty medicalReport.cu}">/</c:if>
                 		<c:if test="${!empty medicalReport.cu}"><fmt:formatNumber value="${medicalReport.cu}" pattern="#0.0" /></c:if>
                 	</td>
                 	<td style="font-size: 20px;">
                 		<c:if test="${empty medicalReport.ca}">/</c:if>
                 		<c:if test="${!empty medicalReport.ca}"><fmt:formatNumber value="${medicalReport.ca}" pattern="#" /></c:if>
                 	</td>
                 	<td style="font-size: 20px;">
                 		<c:if test="${empty medicalReport.mg}">/</c:if>
                 		<c:if test="${!empty medicalReport.mg}"><fmt:formatNumber value="${medicalReport.mg}" pattern="#0.0" /></c:if>
                 	</td>
                 	<td style="font-size: 20px;">
                 		<c:if test="${empty medicalReport.mn}">/</c:if>
                 		<c:if test="${!empty medicalReport.mn}"><fmt:formatNumber value="${medicalReport.mn}" pattern="#0.0" /></c:if>
                 	</td>
                 	<td style="font-size: 20px;">
                 		<c:if test="${empty medicalReport.k}">/</c:if>
                 		<c:if test="${!empty medicalReport.k}"><fmt:formatNumber value="${medicalReport.k}" pattern="#0.0" /></c:if>
                 	</td>
                </tr>
                <tr>
                    <td colspan="2">元素<br>(μg/g)</td>
                    <td>锶(Sr)</td>
                    <td>铬(Cr)</td>
                    <td>钼(Mo)</td>
                    <td>钴(Co)</td>
                    <td>镍(Ni)</td>
                    <td>钒(V)</td>
                    <td>钛(Ti)</td>
                </tr>
                <tr>
                    <td rowspan="2">参<br>考<br>值</td>
                    <td>儿童</td>
                    <td>1.84<br>0.51-3.68</td>
                    <td>0.96<br>0.10-1.99</td>
                    <td>0.38<br>0.14-1.96</td>
                    <td>0.05<br>0.01-0.81</td>
                    <td>0.24<br>0.11-1.84</td>
                    <td>0.06<br>0.01-0.51</td>
                    <td>4.49<br>1.76-12.43</td>
                </tr>
                <tr>
                    <td>成人</td>
                    <td>2.63<br>0.68-5.36</td>
                    <td>0.96<br>0.18-2.51</td>
                    <td>0.49<br>0.17-2.14</td>
                    <td>0.06<br>0.01-0.91</td>
                    <td>0.84<br>0.15-2.76</td>
                    <td>0.07<br>0.01-0.55</td>
                    <td>4.42<br>1.22-12.03</td>
                </tr>
                <tr>
                    <td colspan="2">检测值<br>(μg/g)</td>
                    <td style="font-size: 20px;">
                 		<c:if test="${empty medicalReport.sr}">/</c:if>
                 		<c:if test="${!empty medicalReport.sr}"><fmt:formatNumber value="${medicalReport.sr}" pattern="#0.00" /></c:if>
                 	</td>
                 	<td style="font-size: 20px;">
                 		<c:if test="${empty medicalReport.cr}">/</c:if>
                 		<c:if test="${!empty medicalReport.cr}"><fmt:formatNumber value="${medicalReport.cr}" pattern="#0.00" /></c:if>
                 	</td>
                 	<td style="font-size: 20px;">
                 		<c:if test="${empty medicalReport.mo}">/</c:if>
                 		<c:if test="${!empty medicalReport.mo}"><fmt:formatNumber value="${medicalReport.mo}" pattern="#0.00" /></c:if>
                 	</td>
                 	<td style="font-size: 20px;">
                 		<c:if test="${empty medicalReport.co}">/</c:if>
                 		<c:if test="${!empty medicalReport.co}"><fmt:formatNumber value="${medicalReport.co}" pattern="#0.00" /></c:if>
                 	</td>
                 	<td style="font-size: 20px;">
                 		<c:if test="${empty medicalReport.ni}">/</c:if>
                 		<c:if test="${!empty medicalReport.ni}"><fmt:formatNumber value="${medicalReport.ni}" pattern="#0.00" /></c:if>
                 	</td>
                 	<td style="font-size: 20px;">
                 		<c:if test="${empty medicalReport.v}">/</c:if>
                 		<c:if test="${!empty medicalReport.v}"><fmt:formatNumber value="${medicalReport.v}" pattern="#0.00" /></c:if>
                 	</td>
                 	<td style="font-size: 20px;">
                 		<c:if test="${empty medicalReport.ti}">/</c:if>
                 		<c:if test="${!empty medicalReport.ti}"><fmt:formatNumber value="${medicalReport.ti}" pattern="#0.00" /></c:if>
                 	</td>
                </tr>
                <tr>
                    <td colspan="2">元素<br>(μg/g)</td>
                    <td>钡(Ba)</td>
                    <td>硼(B)</td>
                    <td>锡(Sn)</td>
                    <td>铅(Pb)</td>
                    <td>镉(Cd)</td>
                    <td>铝(Al)</td>
                </tr>
                <tr>
                    <td rowspan="2">参<br>考<br>值</td>
                    <td>儿童</td>
                    <td>1.16<br>0.32-4.20</td>
                    <td>0.88<br>0.22-3.20</td>
                    <td>0.81<br>0.15-1.89</td>
                    <td>&lt;10.0</td>
                    <td>0.20<br>0.05-0.86</td>
                    <td>53.4<br>20.1-98.4</td>
                </tr>
                <tr>
                    <td>成人</td>
                    <td>2.03<br>0.38-5.14</td>
                    <td>1.31<br>0.17-4.36</td>
                    <td>1.10<br>0.16-2.56</td>
                    <td>&lt;10.0</td>
                    <td>0.36<br>0.08-1.08</td>
                    <td>56.4<br>21.3-101.4</td>
                </tr>
                <tr>
                    <td colspan="2">检测值<br>(μg/g)</td>
                    <td style="font-size: 20px;">
                 		<c:if test="${empty medicalReport.ba}">/</c:if>
                 		<c:if test="${!empty medicalReport.ba}"><fmt:formatNumber value="${medicalReport.ba}" pattern="#0.00" /></c:if>
                 	</td>
                 	<td style="font-size: 20px;">
                 		<c:if test="${empty medicalReport.b}">/</c:if>
                 		<c:if test="${!empty medicalReport.b}"><fmt:formatNumber value="${medicalReport.b}" pattern="#0.00" /></c:if>
                 	</td>
                 	<td style="font-size: 20px;">
                 		<c:if test="${empty medicalReport.sn}">/</c:if>
                 		<c:if test="${!empty medicalReport.sn}"><fmt:formatNumber value="${medicalReport.sn}" pattern="#0.00" /></c:if>
                 	</td>
                 	<td style="font-size: 20px;">
                 		<c:if test="${empty medicalReport.pb}">/</c:if>
                 		<c:if test="${!empty medicalReport.pb}"><fmt:formatNumber value="${medicalReport.pb}" pattern="#0.0" /></c:if>
                 	</td>
                 	<td style="font-size: 20px;">
                 		<c:if test="${empty medicalReport.cd}">/</c:if>
                 		<c:if test="${!empty medicalReport.cd}"><fmt:formatNumber value="${medicalReport.cd}" pattern="#0.00" /></c:if>
                 	</td>
                 	<td style="font-size: 20px;">
                 		<c:if test="${empty medicalReport.al}">/</c:if>
                 		<c:if test="${!empty medicalReport.al}"><fmt:formatNumber value="${medicalReport.al}" pattern="#0.0" /></c:if>
                 	</td>
                </tr>
            </table>
            <div class="nbsp_10"></div>
            <table cellpadding="0" cellspacing="0" class="table_2 fontsize_14">
                <tr>
                    <td style="width: 69%"><div style="font-size: 14px;">分析人：<span>唐志鹏</span></div></td>
                    <td style="width: 31%">报告日期：<span><fmt:formatDate type="date" value="${medicalReport.detectionDate}" pattern="yyyy-MM-dd"/></span></td>
                </tr>
            </table>
            <div class="nbsp_5"></div>

            <ul class="ultable">
                <li class="w35">说明:</li>
                <li class="whitespacenormal">
                    1、此报告仅对送检样本负责！结果仅用于医学保健目的,仅供医生参考使用,不作为职业病或铅中毒诊断的依据。<br>
                    2、取样方法：用不锈钢剪刀在后脑部贴近头皮处剪取头发不少于0.5g，已染色的头发不予检测。
                </li>
            </ul>
            <ul class="ultable">
                <li class="w35">地址：</li>
                <li class="whitespacenormal">广州科学城崖鹰石路10号中山大学国家大学科技园。电话：020-37630722</li>
            </ul>

        </div>
        <!-- printend -->
    </body>
</html>