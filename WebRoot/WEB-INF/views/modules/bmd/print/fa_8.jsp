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
	<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery/jquery.qrcode.min.js"></script>
  </head>
  
<body>
        <!-- printstart -->
        <c:forEach items="${reports}" var="r">
        <div class="printbox fontsize_16">
            
            <p style="text-align:right"><span style="display:none">检测号：</span><span>${r.reportNum}</span></p>
            
            <div class="kongge"></div>

            <div style="height:60px; position:relative">
                <div class="ewm"><div id="qrcode_${r.id }"></div></div>
                <div class="ewmp">扫描右边的二维码<br>在线查询报告单</div>
            </div>


            <table cellpadding="0" cellspacing="0" class="table_2 fontsize_16">
                <tr>
                    <td style="width: 20%">姓名：<span>${r.person}</span></td>
                    <td style="width: 10%">性别：<span>${fns:getDictLabel(r.sex,'sex','') }</span></td>
                    <td style="width: 20%">年龄：<span>${r.age}</span></td>
                    <td style="width: 50%"><span style="display:none">电话：</span>
                        <span style="padding-left:80px;"><fmt:formatNumber value="${r.phone}" pattern="#" /></span></td>
                </tr>
                <tr>
                    <td colspan="4">
                        来样单位：<span>${r.deliverUnit}</span>
                    </td>
                </tr>
            </table>


            <table cellpadding="0" cellspacing="0" class="table fontsize_16">
                <tr>
                    <td colspan="2" style="width: 12%">元素(μg/g)</td>
                    <td style="width: 11%">锌(Zn)</td>
                    <td style="width: 11%">铁(Fe)</td>
                    <td style="width: 11%">铜(Cu)</td>
                    <td style="width: 11%">钙(Ca)</td>
                    <td style="width: 11%">镁(Mg)</td>
                    <td style="width: 11%">锰(Mn)</td>
                    <td style="width: 11%">钾(K)</td>
                    <td style="width: 11%">铅(Pb)</td>
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
                    <td>127.7<br>105.7-159.7</td>
                    <td>35.2<br>8.9-94.9</td>
                    <td>11.6<br>6.5-23.9</td>
                    <td>1034<br>380-1343</td>
                    <td>74.4<br>21.9-150.2</td>
                    <td>4.6<br>2.4-9.4</td>
                    <td>210.4<br>150.4-734</td>
                    <td>&lt;10.0</td>
                </tr>
                <tr>
                    <td colspan="2">检测值(μg/g)</td>
                    <td style="font-size: 20px;">
                 		<c:if test="${empty r.zn}">/</c:if>
                 		<c:if test="${!empty r.zn}"><fmt:formatNumber value="${r.zn}" pattern="#0.0" /></c:if>
                 	</td>
                 	<td style="font-size: 20px;">
                 		<c:if test="${empty r.fe}">/</c:if>
                 		<c:if test="${!empty r.fe}"><fmt:formatNumber value="${r.fe}" pattern="#0.0" /></c:if>
                 	</td>
                 	<td style="font-size: 20px;">
                 		<c:if test="${empty r.cu}">/</c:if>
                 		<c:if test="${!empty r.cu}"><fmt:formatNumber value="${r.cu}" pattern="#0.0" /></c:if>
                 	</td>
                 	<td style="font-size: 20px;">
                 		<c:if test="${empty r.ca}">/</c:if>
                 		<c:if test="${!empty r.ca}"><fmt:formatNumber value="${r.ca}" pattern="#" /></c:if>
                 	</td>
                 	<td style="font-size: 20px;">
                 		<c:if test="${empty r.mg}">/</c:if>
                 		<c:if test="${!empty r.mg}"><fmt:formatNumber value="${r.mg}" pattern="#0.0" /></c:if>
                 	</td>
                 	<td style="font-size: 20px;">
                 		<c:if test="${empty r.mn}">/</c:if>
                 		<c:if test="${!empty r.mn}"><fmt:formatNumber value="${r.mn}" pattern="#0.0" /></c:if>
                 	</td>
                 	<td style="font-size: 20px;">
                 		<c:if test="${empty r.k}">/</c:if>
                 		<c:if test="${!empty r.k}"><fmt:formatNumber value="${r.k}" pattern="#0.0" /></c:if>
                 	</td>
                 	<td style="font-size: 20px;">
                 		<c:if test="${empty r.pb}">/</c:if>
                 		<c:if test="${!empty r.pb}"><fmt:formatNumber value="${r.pb}" pattern="#0.0" /></c:if>
                 	</td>
                </tr>
            </table>

            <div class="nbsp_10"></div>
            <div class="nbsp_10"></div>
            <table cellpadding="0" cellspacing="0" class="table_2 fontsize_16">
                <tr>
                    <td style="width: 35%;">分析人：<span>唐志鹏</span></td>
<td style="width:35%">复核人：冯杏玲</td>
                    <td style="width: 30%;">报告日期：<span><fmt:formatDate type="date" value="${r.detectionDate}" pattern="yyyy-MM-dd"/></span></td>
                </tr>
            </table>
            
        </div>
        <script type="text/javascript">
			jQuery('#qrcode_${r.id}').qrcode({
			    render: "canvas", //也可以替换为table
			    width: 80,
			    height: 80,
				right: "1.8cm",
				top: "1cm",
			    text: "http://www.bt-healthy.com/f/report/detail?id=${r.id}&type=1&num=8"
			});
        </script>
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