<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fns" uri="/WEB-INF/tlds/fns.tld" %>
<html>
<head>
	<title>检查报告查看</title>
	<meta charset="utf-8">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/print_A5.css" media="print">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/print_A5.css">
	<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery/jquery.qrcode.min.js"></script>
</head>
<body>
	    <div class="printbox fontsize_15">
            
            <p style="text-align:right"><span style="display:none">检测号：</span><span>${medicalReport.reportNum}</span></p>

            <div class="kongge">
                <img src="${pageContext.request.contextPath}/static/images/title_xue.jpg">
            </div>
            <div class="ewmbox">
                <div class="ewm"><div id="qrcode"></div></div>
                <div class="ewmp">扫描右边的二维码<br>在线查询报告单</div>
            </div>

            <table cellpadding="0" cellspacing="0" class="table_2 fontsize_15">
                <tr>
                    <td style="width: 17%">姓名：<span>${medicalReport.person}</span></td>
                    <td style="width: 10%">性别：<span>${fns:getDictLabel(medicalReport.sex,'sex','') }</span></td>
                    <td style="width: 15%">年龄：<span>${medicalReport.age}</span></td>
                    <td style="width: 58%"><span style="display:none">电话：</span><span style="padding-left:80px;"><fmt:formatNumber value="${medicalReport.phone}" pattern="#" /></span></td>
                </tr>
                <tr>
                    <td colspan="4">来样单位：<span>${medicalReport.deliverUnit}</span></td>
                </tr>
            </table>

            <table cellpadding="0" cellspacing="0" class="table fontsize_15">
                <tr>
                    <td colspan="2" style="width:16%">元素(μg/ml)</td>
                    <td style="width: 14%">锌(Zn)</td>
                    <td style="width: 14%">铁(Fe)</td>
                    <td style="width: 14%">铜(Cu)</td>
                    <td style="width: 14%">钙(Ca)</td>
                    <td style="width: 14%">镁(Mg)</td>
                    <td style="width: 14%">铅(Pb)</td>
                </tr>
                <tr>
                    <td rowspan="2" style="width: 8%">参<br>考<br>值</td>
                    <td>儿童</td>
                    <td class="whitespace">6.15<br>3.78-8.86</td>
                    <td class="whitespace">380<br>239-510</td>
                    <td class="whitespace">0.89<br>0.50-1.60</td>
                    <td class="whitespace">70.9<br>49.6-112.1</td>
                    <td class="whitespace">38.9<br>20.9-60.0</td>
                    <td class="whitespace">&lt;0.1</td>
                </tr>
                <tr>
                    <td>成人</td>
                    <td class="whitespace">6.40<br>4.53-9.33</td>
                    <td class="whitespace">382<br>351-571</td>
                    <td class="whitespace">0.88<br>0.56-1.71</td>
                    <td class="whitespace">70.1<br>43.7-121.4</td>
                    <td class="whitespace">46.6<br>25.0-59.3</td>
                    <td class="whitespace">&lt;0.1</td>
                </tr>
                <tr>
                    <td colspan="2">检测值(μg/ml)</td>
                    <td>
                 		<c:if test="${empty medicalReport.zn}">/</c:if>
                 		<c:if test="${!empty medicalReport.zn}"><fmt:formatNumber value="${medicalReport.zn}" pattern="#0.00" /></c:if>
                 	</td>
                 	<td>
                 		<c:if test="${empty medicalReport.fe}">/</c:if>
                 		<c:if test="${!empty medicalReport.fe}"><fmt:formatNumber value="${medicalReport.fe}" pattern="#" /></c:if>
                 	</td>
                 	<td>
                 		<c:if test="${empty medicalReport.cu}">/</c:if>
                 		<c:if test="${!empty medicalReport.cu}"><fmt:formatNumber value="${medicalReport.cu}" pattern="#0.00" /></c:if>
                 	</td>
                 	<td>
                 		<c:if test="${empty medicalReport.ca}">/</c:if>
                 		<c:if test="${!empty medicalReport.ca}"><fmt:formatNumber value="${medicalReport.ca}" pattern="#0.0" /></c:if>
                 	</td>
                 	<td>
                 		<c:if test="${empty medicalReport.mg}">/</c:if>
                 		<c:if test="${!empty medicalReport.mg}"><fmt:formatNumber value="${medicalReport.mg}" pattern="#0.0" /></c:if>
                 	</td>
                 	<td>
                 		<c:if test="${empty medicalReport.pb}">/</c:if>
                 		<c:if test="${!empty medicalReport.pb}"><fmt:formatNumber value="${medicalReport.pb}" pattern="#0.000" /></c:if>
                 	</td>
                </tr>
            </table>

            <div class="nbsp_10"></div>
            <table cellpadding="0" cellspacing="0" class="table_2 fontsize_15">
                <tr>
                    <td style="width: 35%;">分析人：<span>唐志鹏</span></td>
                    <td style="width: 35%">复核人：冯杏玲</td>
                    <td style="width: 30%;">报告日期：<span><fmt:formatDate type="date" value="${medicalReport.detectionDate}" pattern="yyyy-MM-dd"/></span></td>
                </tr>
            </table>

            <ul class="ultable fontsize_15">
                <li class="w35">说明:</li>
                <li class="whitespacenormal">
                    1、此报告仅对送检样本负责！结果仅用于医学保健目的,仅供医生参考使用,不作为职业病或铅中毒诊断的依据。<br>
                    2、取样方法：抽取不少于1ml全血，加入抗凝剂，冷藏保存。
                </li>
            </ul>
            <ul class="ultable fontsize_15">
                <li class="w35">地址：</li>
                <li class="whitespacenormal">广州科学城崖鹰石路10号中山大学国家大学科技园。电话：020-37630722</li>
            </ul>

        </div>
        <!-- printend -->
    </body>
            <script type="text/javascript">
	jQuery('#qrcode').qrcode({
	    render: "canvas", //也可以替换为table
	    width: 80,
	    height: 80,
		right: "1.8cm",
		top: "1cm",
	    text: "http://www.bt-healthy.com/f/report/detail?id=${medicalReport.id}&type=2&num=6"
	});
</script>
</html>