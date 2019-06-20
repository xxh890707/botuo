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

</head>
<body>
	      <!-- printstart -->
	     <c:forEach items="${reports}" var="r">
        <div class="printbox_kh fontsize_14">
            
            <p class="jch_kh"><span style="display:none">检测号：</span><span>${r.reportNum}</span></p>
            <div class="ewm_kh"><img src="${r.qrcode}"></div>
            <div class="ewmp_kh">扫描右边的二维码<br>在线查询报告单</div>
            
            <div class="kongge">
                <h1 class="title">中山大学中山医学院科技开发中心</h1>
                <p class="title-smi">全血微量元素检测报告</p>
            </div>
            
            <div class="nbsp_10"></div>
            
            <table cellpadding="0" cellspacing="0" class="table_2 fontsize_14">
                <tr>
                    <td style="width: 17%">姓名：<span>${r.person}</span></td>
                    <td style="width: 10%">性别：<span>${fns:getDictLabel(r.sex,'sex','') }</span></td>
                    <td style="width: 13%">年龄：<span>${r.age}</span></span></td>
                    <td style="width: 40%">来样单位：<span>${r.deliverUnit}</span></td>
                    <td><span style="display:none">电话：</span><span><fmt:formatNumber value="${r.phone}" pattern="#" /></span></td>
                </tr>
            </table>

            <table cellpadding="0" cellspacing="0" class="table fontsize_14">
                <tr>
                    <td colspan="2" style="width: 16%">元素(μg/ml)</td>
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
                    <td>6.15<br>3.78-8.86</td>
                    <td>380<br>239-510</td>
                    <td>0.89<br>0.50-1.60</td>
                    <td>70.9<br>49.6-112.1</td>
                    <td>38.9<br>20.9-60.0</td>
                    <td>&lt;0.1</td>
                </tr>
                <tr>
                    <td>成人</td>
                    <td>6.40<br>4.53-9.33</td>
                    <td>382<br>351-571</td>
                    <td>0.88<br>0.56-1.71</td>
                    <td>70.1<br>43.7-121.4</td>
                    <td>46.6<br>25.0-59.3</td>
                    <td>&lt;0.1</td>
                </tr>
                <tr>
                    <td colspan="2">检测值(μg/ml)</td>
                    <td>
                 		<c:if test="${empty r.zn}">/</c:if>
                 		<c:if test="${!empty r.zn}"><fmt:formatNumber value="${r.zn}" pattern="#0.00" /></c:if>
                 	</td>
                 	<td>
                 		<c:if test="${empty r.fe}">/</c:if>
                 		<c:if test="${!empty r.fe}"><fmt:formatNumber value="${r.fe}" pattern="#" /></c:if>
                 	</td>
                 	<td>
                 		<c:if test="${empty r.cu}">/</c:if>
                 		<c:if test="${!empty r.cu}"><fmt:formatNumber value="${r.cu}" pattern="#0.00" /></c:if>
                 	</td>
                 	<td>
                 		<c:if test="${empty r.ca}">/</c:if>
                 		<c:if test="${!empty r.ca}"><fmt:formatNumber value="${r.ca}" pattern="#0.0" /></c:if>
                 	</td>
                 	<td>
                 		<c:if test="${empty r.mg}">/</c:if>
                 		<c:if test="${!empty r.mg}"><fmt:formatNumber value="${r.mg}" pattern="#0.0" /></c:if>
                 	</td>
                 	<td>
                 		<c:if test="${empty r.pb}">/</c:if>
                 		<c:if test="${!empty r.pb}"><fmt:formatNumber value="${r.pb}" pattern="#0.000" /></c:if>
                 	</td>
                </tr>
            </table>
            <div class="nbsp_5"></div>
            <table cellpadding="0" cellspacing="0" class="table_2 fontsize_14">
                <tr>
                    <td style="width: 70%;">分析人：<span>唐志鹏</span></td>
                    <td style="width: 30%;">报告日期：<span><fmt:formatDate type="date" value="${r.detectionDate}" pattern="yyyy-MM-dd"/></span></td>
                </tr>
            </table>

            <div class="nbsp_5"></div>

            <ul class="ultable">
                <li class="w35">说明:</li>
                <li class="whitespacenormal">
                    1、此报告仅对送检样本负责！结果仅用于医学保健目的,仅供医生参考使用,不作为职业病或铅中毒诊断的依据。<br>
                    2、取样方法：抽取不少于1ml全血，加入抗凝剂，冷藏保存。
                </li>
            </ul>
            <ul class="ultable">
                <li class="w35">地址：</li>
                <li class="whitespacenormal">广州科学城崖鹰石路10号中山大学国家大学科技园。电话：020-37630722</li>
            </ul>
            <div class="nbsp_5"></div>
            <ul class="ultable">
                <li class="wp100">以下所附资料非本中心报告内容：</li>
            </ul>
            <div class="nbsp_5"></div>
            <table cellpadding="0" cellspacing="0" class="table fontsize_14">
                <tr>
                    <td colspan="3">人体内元素不平衡症状</td>
                    <td>人体内元素均衡调理方法(食物或食品调理)</td>
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
        </c:forEach>
        <!-- printend -->
       
        <div class="printbtn" id="noPrint3">
            <a href="javascript:void(0)" onClick="doPrint();" rel="nofollow" target="_self">打印</a>
        </div>
        <script type="text/javascript">
            function doPrint(){
                document.getElementById('noPrint3').style.display = 'none';
                window.print();
            }
        </script>
    </body>
</html>