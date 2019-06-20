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
        <div class="printbox fontsize_16" style="font-size: 18px;">
            <div class="kongge_3" style="height: 130px;"></div>
            <div class="nbsp_10"></div>

            <!-- <div style="padding: 0 50px;"> -->
                
                <ul class="ultable">
                    <li class="wp50" style="width:40%">编号：<span>${r.reportNum}</span><p>Report No. <span></span></p></li>
                    <li class="wp50" style="width:60%;">样品名称：<span>${r.person}</span><span style="margin-left:20px;">${fns:getDictLabel(r.sex,'sex','')}</span><span style="margin-left:20px;">${r.age}</span><p>Sample Name <span></span></p></li>
                    <li style="width: 100%; clear: both;">委托单位：<span>${r.deliverUnit}</span><p>Customer <span></span></p></li>
                    
                </ul>
                <!-- <div class="kongge_2"></div> -->
                <div class="printstitle" style="margin-top: -15px;">
                    <div class="ewm"><div id="qrcode_${r.id }"></div></div>
                    <div class="ewmp">扫描右边的二维码<br>在线查询报告单</div>
                    <h3 style="padding-right: 20px; font-size: 22px;">分析检测结果</h3>
                    <p style="line-height:1; padding-right: 20px;">Results</p>
                </div>
                <!-- <div class="nbsp_10"></div> -->
                <div class="listbox">
                    <ul style="padding-right: 40px; box-sizing: border-box;">
                        <li class="lefttitle">分析项目</li>
                        <li class="rightcont">检测结果（μg/g）</li>

                        <li class="lefttitle">1、锌（Zn)</li>
                        <li class="rightcont" style="font-weight: bold;">
                        	<c:if test="${empty r.zn}">&nbsp;</c:if>
                 			<c:if test="${!empty r.zn}"><fmt:formatNumber value="${r.zn}" pattern="#.0" /></c:if>
                 		</li>

                        <li class="lefttitle">2、铁（Fe)</li>
                        <li class="rightcont" style="font-weight: bold;">
							<c:if test="${empty r.fe}">&nbsp;</c:if>
                 			<c:if test="${!empty r.fe}"><fmt:formatNumber value="${r.fe}" pattern="#0.0" /></c:if>
						</li>

                        <li class="lefttitle">3、铜（Cu)</li>
                        <li class="rightcont" style="font-weight: bold;">
                        	<c:if test="${empty r.cu}">&nbsp;</c:if>
                 			<c:if test="${!empty r.cu}"><fmt:formatNumber value="${r.cu}" pattern="#0.0" /></c:if>
                        </li>

                        <li class="lefttitle">4、钙（Ca)</li>
                        <li class="rightcont" style="font-weight: bold;">
                        	<c:if test="${empty r.ca}">&nbsp;</c:if>
                 			<c:if test="${!empty r.ca}"><fmt:formatNumber value="${r.ca}" pattern="#" /></c:if>
                        </li>

                        <li class="lefttitle">5、镁（Mg)</li>
                        <li class="rightcont" style="font-weight: bold;">
                        	<c:if test="${empty r.mg}">&nbsp;</c:if>
                 			<c:if test="${!empty r.mg}"><fmt:formatNumber value="${r.mg}" pattern="#0.0" /></c:if>
                        </li>

                        <li class="lefttitle">6、铅（Pb)</li>
                        <li class="rightcont" style="font-weight: bold;">
                        	<c:if test="${empty r.pb}">&nbsp;</c:if>
                 			<c:if test="${!empty r.pb}"><fmt:formatNumber value="${r.pb}" pattern="#0.0" /></c:if>
                        </li>

                        <li class="lefttitle">7、锰（Mn)</li>
                        <li class="rightcont" style="font-weight: bold;">
                        	<c:if test="${empty r.mn}">&nbsp;</c:if>
                 			<c:if test="${!empty r.mn}"><fmt:formatNumber value="${r.mn}" pattern="#0.0" /></c:if>
                        </li>

                        <li class="lefttitle">8、钾（K)</li>
                        <li class="rightcont" style="font-weight: bold;">
                        	<c:if test="${empty r.k}">&nbsp;</c:if>
                 			<c:if test="${!empty r.k}"><fmt:formatNumber value="${r.k}" pattern="#0.0" /></c:if>
                        </li>

                        <li class="lefttitle">9、锶（Sr)</li>
                        <li class="rightcont" style="font-weight: bold;">
                        	<c:if test="${empty r.sr}">&nbsp;</c:if>
                 			<c:if test="${!empty r.sr}"><fmt:formatNumber value="${r.sr}" pattern="#0.00" /></c:if>
                        </li>

                        <li class="lefttitle">10、铬（Cr)</li>
                        <li class="rightcont" style="font-weight: bold;">
                        	<c:if test="${empty r.cr}">&nbsp;</c:if>
                 			<c:if test="${!empty r.cr}"><fmt:formatNumber value="${r.cr}" pattern="#0.00" /></c:if>
                        </li>

                        <li class="lefttitle">11、钼（Mo)</li>
                        <li class="rightcont" style="font-weight: bold;">
                        	<c:if test="${empty r.mo}">&nbsp;</c:if>
                 			<c:if test="${!empty r.mo}"><fmt:formatNumber value="${r.mo}" pattern="#0.00" /></c:if>
                        </li>

                    </ul>
                    <ul style="padding-left: 40px; box-sizing: border-box;">
                        <li class="lefttitle">分析项目</li>
                        <li class="rightcont">检测结果（μg/g）</li>

                        <li class="lefttitle">12、钴（Co)</li>
                        <li class="rightcont" style="font-weight: bold;">
                        	<c:if test="${empty r.co}">&nbsp;</c:if>
                 			<c:if test="${!empty r.co}"><fmt:formatNumber value="${r.co}" pattern="#0.00" /></c:if>
                        </li>

                        <li class="lefttitle">13、镍（Ni)</li>
                        <li class="rightcont" style="font-weight: bold;">
                        	<c:if test="${empty r.ni}">&nbsp;</c:if>
                 			<c:if test="${!empty r.ni}"><fmt:formatNumber value="${r.ni}" pattern="#0.00" /></c:if>
                        </li>

                        <li class="lefttitle">14、钒（V)</li>
                        <li class="rightcont" style="font-weight: bold;">
                        	<c:if test="${empty r.v}">&nbsp;</c:if>
                 			<c:if test="${!empty r.v}"><fmt:formatNumber value="${r.v}" pattern="#0.00" /></c:if>
                        </li>

                        <li class="lefttitle">15、钛（Ti)</li>
                        <li class="rightcont" style="font-weight: bold;">
                        	<c:if test="${empty r.ti}">&nbsp;</c:if>
                 			<c:if test="${!empty r.ti}"><fmt:formatNumber value="${r.ti}" pattern="#0.00" /></c:if>
                        </li>

                        <li class="lefttitle">16、钡（Ba)</li>
                        <li class="rightcont" style="font-weight: bold;">
                        	<c:if test="${empty r.ba}">&nbsp;</c:if>
                 			<c:if test="${!empty r.ba}"><fmt:formatNumber value="${r.ba}" pattern="#0.00" /></c:if>
                        </li>

                        <li class="lefttitle">17、硼（B)</li>
                        <li class="rightcont" style="font-weight: bold;">
                        	<c:if test="${empty r.b}">&nbsp;</c:if>
                 			<c:if test="${!empty r.b}"><fmt:formatNumber value="${r.b}" pattern="#0.00" /></c:if>
                        </li>

                        <li class="lefttitle">18、锡（Sn)</li>
                        <li class="rightcont" style="font-weight: bold;">
                        	<c:if test="${empty r.sn}">&nbsp;</c:if>
                 			<c:if test="${!empty r.sn}"><fmt:formatNumber value="${r.sn}" pattern="#0.00" /></c:if>
                        </li>

                        <li class="lefttitle">19、镉（Cd)</li>
                        <li class="rightcont" style="font-weight: bold;">
                        	<c:if test="${empty r.cd}">&nbsp;</c:if>
                 			<c:if test="${!empty r.cd}"><fmt:formatNumber value="${r.cd}" pattern="#0.00" /></c:if>
                        </li>

                        <li class="lefttitle">20、铝（Al)</li>
                        <li class="rightcont" style="font-weight: bold;">
                        	<c:if test="${empty r.al}">&nbsp;</c:if>
                 			<c:if test="${!empty r.al}"><fmt:formatNumber value="${r.al}" pattern="#0.0" /></c:if>
                        </li>

                        <li class="lefttitle">21、硅（Si)</li>
                        <li class="rightcont" style="font-weight: bold;">
                        	<c:if test="${empty r.si}">&nbsp;</c:if>
                 			<c:if test="${!empty r.si}"><fmt:formatNumber value="${r.si}" pattern="#0.00" /></c:if>
                        </li>

                        <li class="lefttitle">22、硒（Se)</li>
                        <li class="rightcont" style="font-weight: bold;">
                        	<c:if test="${empty r.se}">&nbsp;</c:if>
                 			<c:if test="${!empty r.se}"><fmt:formatNumber value="${r.se}" pattern="#0.00" /></c:if>
                        </li>

                    </ul>

                    
                </div>
                <ul class="ultable" style="margin-top: 30px;">
                    <li class="wp50">分析人：<span>唐志鹏</span><div style="float: right;">复核人:冯杏玲</div></li>
                    <li class="wp50"><div style="padding-left: 40px;">报告日期：<span><fmt:formatDate type="date" value="${r.detectionDate}" pattern="yyyy-MM-dd"/></span></div></li>
                </ul>
            <!-- </div> -->
            
        </div>
        <script type="text/javascript">
			jQuery('#qrcode_${r.id}').qrcode({
			    render: "canvas", //也可以替换为table
			    width: 80,
			    height: 80,
				right: "1.8cm",
				top: "1cm",
			    text: "http://www.bt-healthy.com/f/report/detail?id=${r.id}&type=1&num=yjy"
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