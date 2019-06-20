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
<!-- printstart -->
		<div class="printbox fontsize_14">
            <p class="jch_kh"><span style="display:none">检测号：</span><span>${medicalReport.reportNum}</span></p>
            <div class="ewm_kh" id="qrcode"></div>
            <div class="ewmp_kh">扫描右边的二维码<br>在线查询报告单</div>
            <div class="kongge">
                <h1 class="title">中山大学中山医学院科技开发中心</h1>
                <p class="title-smi">头发微量元素检测报告</p>
            </div>
            <div class="nbsp_10"></div>

            <table cellpadding="0" cellspacing="0" class="table_2 fontsize_16">
                <tr>
                    <td style="width: 17%">姓名：<span>${medicalReport.person}</span></td>
                    <td style="width: 10%">性别：<span>${fns:getDictLabel(medicalReport.sex,'sex','') }</span></td>
                    <td style="width: 13%">年龄：<span>${medicalReport.age}</span></span></td>
                    <td style="width: 40%">来样单位：<span>${medicalReport.deliverUnit}</span></td>
                    <td><span style="display:none">电话：</span><span><fmt:formatNumber value="${medicalReport.phone}" pattern="#" /></span></td>
                </tr>
            </table>

            <table cellpadding="0" cellspacing="0" class="table fontsize_14">
                <tr>
                    <td colspan="2" style="width: 16%">元素(μg/g)</td>
                    <td style="width: 14%">锌(Zn)</td>
                    <td style="width: 14%">铁(Fe)</td>
                    <td style="width: 14%">铜(Cu)</td>
                    <td style="width: 14%">钙(Ca)</td>
                    <td style="width: 14%">镁(Mg)</td>
                    <td style="width: 14%">铅(Pb)</td>
                </tr>
                <tr>
                    <td rowspan="2" style="width: 8%">参<br>考<br>值</td>
                    <td class="whitespace">儿童</td>
                    <td class="whitespace">111.2<br>87.7-134.5</td>
                    <td class="whitespace">29.6<br>8.9-64.8</td>
                    <td class="whitespace">10.7<br>5.7-19.5</td>
                    <td class="whitespace">849<br>380-1115</td>
                    <td class="whitespace">64.8<br>20.0-129.2</td>
                    <td class="whitespace">&lt;10.0</td>
                </tr>
                <tr>
                    <td>成人</td>
                    <td>127.7<br>105.7-159.7</td>
                    <td>35.2<br>8.9-94.9</td>
                    <td>11.6<br>6.5-23.9</td>
                    <td>1034<br>380-1343</td>
                    <td>74.4<br>21.9-150.2</td>
                    <td>&lt;10.0</td>
                </tr>
                <tr>
                    <td colspan="2">检测值(μg/g)</td>
                    <td style="font-weight: bold;">
                 		<c:if test="${empty medicalReport.zn}">/</c:if>
                 		<c:if test="${!empty medicalReport.zn}"><fmt:formatNumber value="${medicalReport.zn}" pattern="#0.0" /></c:if>
                 	</td>
                 	<td style="font-weight: bold;">
                 		<c:if test="${empty medicalReport.fe}">/</c:if>
                 		<c:if test="${!empty medicalReport.fe}"><fmt:formatNumber value="${medicalReport.fe}" pattern="#0.0" /></c:if>
                 	</td>
                 	<td style="font-weight: bold;">
                 		<c:if test="${empty medicalReport.cu}">/</c:if>
                 		<c:if test="${!empty medicalReport.cu}"><fmt:formatNumber value="${medicalReport.cu}" pattern="#0.0" /></c:if>
                 	</td>
                 	<td style="font-weight: bold;">
                 		<c:if test="${empty medicalReport.ca}">/</c:if>
                 		<c:if test="${!empty medicalReport.ca}"><fmt:formatNumber value="${medicalReport.ca}" pattern="#" /></c:if>
                 	</td>
                 	<td style="font-weight: bold;">
                 		<c:if test="${empty medicalReport.mg}">/</c:if>
                 		<c:if test="${!empty medicalReport.mg}"><fmt:formatNumber value="${medicalReport.mg}" pattern="#0.0" /></c:if>
                 	</td>
                 	<td style="font-weight: bold;">
                 		<c:if test="${empty medicalReport.pb}">/</c:if>
                 		<c:if test="${!empty medicalReport.pb}"><fmt:formatNumber value="${medicalReport.pb}" pattern="#0.0" /></c:if>
                 	</td>
                </tr>
            </table>
            <div class="nbsp_5"></div>
            <table cellpadding="0" cellspacing="0" class="table_2 fontsize_14">
                <tr>
		<td style="width: 35%;">分析人：<span>唐志鹏</span></td>
                    <td style="width: 35%;">复核人:冯杏玲</td>
                    <td style="width: 30%;">报告日期：<span><fmt:formatDate type="date" value="${medicalReport.detectionDate}" pattern="yyyy-MM-dd"/></span></td>
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
            <div class="nbsp_5"></div>
            <ul class="ultable">
                <li>以下所附资料非本中心报告内容：</li>
            </ul>
            <div class="nbsp_5"></div>
            <table cellpadding="0" cellspacing="0" class="table fontsize_14">
                <tr>
                    <td colspan="3">人体内元素不平衡症状</td>
                    <td>人体内元素均衡调理方法（食物或食品调理）</td>
                </tr>
                <tr>
                    <td rowspan="6" class="rowspans">微<br>量<br>元<br>素<br>知<br>识</td>
                    <td>锌(缺乏)</td>
                    <td>食欲不振、生长发育迟缓、免疫力低下等。</td>
                    <td>海参、牡蛎、蘑菇、板栗。</td>
                </tr>
                <tr>
                    <td>铁(缺乏)</td>
                    <td>贫血、免疫力低下、口腔炎等。</td>
                    <td>猪红、蛋黄、黑木耳、黑枣。</td>
                </tr>
                <tr>
                    <td>铜(缺乏)</td>
                    <td>卷发、毛发褪色、枯黄、神经衰弱等。</td>
                    <td>河虾、虾皮、牡蛎、莲子。</td>
                </tr>
                <tr>
                    <td>钙(缺乏)</td>
                    <td>佝偻病、骨质疏松、肌肉痉挛等。</td>
                    <td>海带、黄豆、牛乳、金针菜。</td>
                </tr>
                <tr>
                    <td>镁(缺乏)</td>
                    <td>心肌坏死、动脉硬化、心血管病等。</td>
                    <td>燕麦、苋菜、香蕉、蜂蜜。</td>
                </tr>
                <tr>
                    <td>铅(过多)</td>
                    <td>上课精神不集中、智力低下、多动、反应迟钝等。</td>
                    <td>猕猴桃、海带、紫菜、黑枣。</td>
                </tr>
            </table>
        </div>
        <!-- printend -->
<script type="text/javascript">
	jQuery('#qrcode').qrcode({
	    render: "canvas", //也可以替换为table
	    width: 80,
	    height: 80,
		right: "1.8cm",
		top: "1cm",
	    text: "http://www.bt-healthy.com/f/report/form?id=${medicalReport.id}&type=1"
	});
</script>
    </body>
</html>