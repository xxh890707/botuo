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
	<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery/jquery.qrcode.min.js"></script>
  </head>
  
<body>
        <!-- printstart -->
        <c:forEach items="${reports}" var="r">
        <div class="printbox_12x fontsize_15">
            <div style="position: relative;">
                <p style="text-align: right; padding-top: 10px;"><span style="display: none">检测号：</span><span>${r.reportNum}</span></p>
                <div class="ewm" style="top: 90px;"><div id="qrcode_${r.id }"></div></div>
                <div class="ewmp" style="top: 110px;">扫描右边的二维码<br>在线查询报告单</div>
            </div>
            <div class="kongge" style="height: 140px;">
                
            </div>

            <table cellpadding="0" cellspacing="0" class="table_2 fontsize_15">
                <tr>
                    <td style="width: 20%">姓名：<span>${r.person}</span></td>
                    <td style="width: 15%">性别：<span>${fns:getDictLabel(r.sex,'sex','') }</span></td>
                    <td style="width: 20%">年龄：<span>${r.age}</span></td>
                    <td style="width: 45%"><span style="display: none">电话：</span><span style="margin-left: 80px;"><fmt:formatNumber value="${r.phone}" pattern="#" /></span></td>
                </tr>
                <tr>
                    <td colspan="4">来样单位：<span>${r.deliverUnit}</span></td>
                </tr>
            </table>

            <div class="nbsp_5"></div>
            <table cellpadding="0" cellspacing="0" class="table fontsize_14">
                <tr>
                    <td colspan="2" style="width: 16%;">元素<br>(μg/g)</td>
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
                 		<c:if test="${empty r.sr}">/</c:if>
                 		<c:if test="${!empty r.sr}"><fmt:formatNumber value="${r.sr}" pattern="#0.00" /></c:if>
                 	</td>
                 	<td style="font-size: 20px;">
                 		<c:if test="${empty r.cr}">/</c:if>
                 		<c:if test="${!empty r.cr}"><fmt:formatNumber value="${r.cr}" pattern="#0.00" /></c:if>
                 	</td>
                 	<td style="font-size: 20px;">
                 		<c:if test="${empty r.mo}">/</c:if>
                 		<c:if test="${!empty r.mo}"><fmt:formatNumber value="${r.mo}" pattern="#0.00" /></c:if>
                 	</td>
                 	<td style="font-size: 20px;">
                 		<c:if test="${empty r.co}">/</c:if>
                 		<c:if test="${!empty r.co}"><fmt:formatNumber value="${r.co}" pattern="#0.00" /></c:if>
                 	</td>
                 	<td style="font-size: 20px;">
                 		<c:if test="${empty r.ni}">/</c:if>
                 		<c:if test="${!empty r.ni}"><fmt:formatNumber value="${r.ni}" pattern="#0.00" /></c:if>
                 	</td>
                 	<td style="font-size: 20px;">
                 		<c:if test="${empty r.v}">/</c:if>
                 		<c:if test="${!empty r.v}"><fmt:formatNumber value="${r.v}" pattern="#0.00" /></c:if>
                 	</td>
                 	<td style="font-size: 20px;">
                 		<c:if test="${empty r.ti}">/</c:if>
                 		<c:if test="${!empty r.ti}"><fmt:formatNumber value="${r.ti}" pattern="#0.00" /></c:if>
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
                 		<c:if test="${empty r.ba}">/</c:if>
                 		<c:if test="${!empty r.ba}"><fmt:formatNumber value="${r.ba}" pattern="#0.00" /></c:if>
                 	</td>
                 	<td style="font-size: 20px;">
                 		<c:if test="${empty r.b}">/</c:if>
                 		<c:if test="${!empty r.b}"><fmt:formatNumber value="${r.b}" pattern="#0.00" /></c:if>
                 	</td>
                 	<td style="font-size: 20px;">
                 		<c:if test="${empty r.sn}">/</c:if>
                 		<c:if test="${!empty r.sn}"><fmt:formatNumber value="${r.sn}" pattern="#0.00" /></c:if>
                 	</td>
                 	<td style="font-size: 20px;">
                 		<c:if test="${empty r.pb}">/</c:if>
                 		<c:if test="${!empty r.pb}"><fmt:formatNumber value="${r.pb}" pattern="#0.0" /></c:if>
                 	</td>
                 	<td style="font-size: 20px;">
                 		<c:if test="${empty r.cd}">/</c:if>
                 		<c:if test="${!empty r.cd}"><fmt:formatNumber value="${r.cd}" pattern="#0.00" /></c:if>
                 	</td>
                 	<td style="font-size: 20px;">
                 		<c:if test="${empty r.al}">/</c:if>
                 		<c:if test="${!empty r.al}"><fmt:formatNumber value="${r.al}" pattern="#0.0" /></c:if>
                 	</td>
                </tr>
            </table>
            <div class="nbsp_10"></div>
            <table cellpadding="0" cellspacing="0" class="table_2 fontsize_14">
                <tr>
                    <td style="width: 35%;">分析人：<span>唐志鹏</span></td>
                    <td style="width: 34%">复核人：冯杏玲</td>
                    <td style="width: 31%">报告日期：<span><fmt:formatDate type="date" value="${r.detectionDate}" pattern="yyyy-MM-dd"/></span></td>
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
			    text: "http://www.bt-healthy.com/f/report/detail?id=${r.id}&type=1&num=20"
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