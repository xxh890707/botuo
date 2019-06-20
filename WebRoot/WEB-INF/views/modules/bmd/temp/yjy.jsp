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
        <div class="printbox fontsize_16">
            <div class="kongge_3">
                <img src="${pageContext.request.contextPath}/static/images/title_b5_yjzx.jpg">
            </div>
            <div class="nbsp_10"></div>

            <!-- <div style="padding: 0 50px;"> -->
                
                <ul class="ultable">
                    <li class="wp50" style="width:40%">编号：<span>${medicalReport.reportNum}</span><p>Report No. <span></span></p></li>
                    <li class="wp50" style="width:60%">样品名称：<span>${medicalReport.person}</span><span style="margin-left:20px;">${fns:getDictLabel(medicalReport.sex,'sex','') }</span><span style="margin-left:20px;">${medicalReport.age}</span><p>Sample Name <span></span></p></li>
                    <li style="width: 100%; clear: both;">委托单位：<span>${medicalReport.deliverUnit}</span><p>Customer <span></span></p></li>
                </ul>
                <div class="nbsp_10"></div>
                <div class="printstitle" style="margin-top: -15px;">
                    <div class="ewm"><div id="qrcode"></div></div>
                    <div class="ewmp">扫描右边的二维码<br>在线查询报告单</div>
                    <h3 style="padding-right: 20px; font-size: 22px;">分析检测结果</h3>
                    <p style="line-height:1; padding-right: 20px;">Results</p>
                </div>
                <div class="nbsp_10"></div>
                <div class="listbox">
                    <ul style="padding-right: 40px; box-sizing: border-box;">
                        <li class="lefttitle">分析项目</li>
                        <li class="rightcont">检测结果（μg/g）</li>

                        <li class="lefttitle">1、锌（Zn)</li>
                        <li class="rightcont" style="font-weight: bold;">
                        	<c:if test="${empty medicalReport.zn}">&nbsp;</c:if>
                 			<c:if test="${!empty medicalReport.zn}"><fmt:formatNumber value="${medicalReport.zn}" pattern="#0.0" /></c:if>
                 		</li>

                        <li class="lefttitle">2、铁（Fe)</li>
                        <li class="rightcont" style="font-weight: bold;">
							<c:if test="${empty medicalReport.fe}">&nbsp;</c:if>
                 			<c:if test="${!empty medicalReport.fe}"><fmt:formatNumber value="${medicalReport.fe}" pattern="#0.0" /></c:if>
						</li>

                        <li class="lefttitle">3、铜（Cu)</li>
                        <li class="rightcont" style="font-weight: bold;">
                        	<c:if test="${empty medicalReport.cu}">&nbsp;</c:if>
                 			<c:if test="${!empty medicalReport.cu}"><fmt:formatNumber value="${medicalReport.cu}" pattern="#0.0" /></c:if>
                        </li>

                        <li class="lefttitle">4、钙（Ca)</li>
                        <li class="rightcont" style="font-weight: bold;">
                        	<c:if test="${empty medicalReport.ca}">&nbsp;</c:if>
                 			<c:if test="${!empty medicalReport.ca}"><fmt:formatNumber value="${medicalReport.ca}" pattern="#" /></c:if>
                        </li>

                        <li class="lefttitle">5、镁（Mg)</li>
                        <li class="rightcont" style="font-weight: bold;">
                        	<c:if test="${empty medicalReport.mg}">&nbsp;</c:if>
                 			<c:if test="${!empty medicalReport.mg}"><fmt:formatNumber value="${medicalReport.mg}" pattern="#0.0" /></c:if>
                        </li>

                        <li class="lefttitle">6、铅（Pb)</li>
                        <li class="rightcont" style="font-weight: bold;">
                        	<c:if test="${empty medicalReport.pb}">&nbsp;</c:if>
                 			<c:if test="${!empty medicalReport.pb}"><fmt:formatNumber value="${medicalReport.pb}" pattern="#0.0" /></c:if>
                        </li>

                        <li class="lefttitle">7、锰（Mn)</li>
                        <li class="rightcont" style="font-weight: bold;">
                        	<c:if test="${empty medicalReport.mn}">&nbsp;</c:if>
                 			<c:if test="${!empty medicalReport.mn}"><fmt:formatNumber value="${medicalReport.mn}" pattern="#0.0" /></c:if>
                        </li>

                        <li class="lefttitle">8、钾（K)</li>
                        <li class="rightcont" style="font-weight: bold;">
                        	<c:if test="${empty medicalReport.k}">&nbsp;</c:if>
                 			<c:if test="${!empty medicalReport.k}"><fmt:formatNumber value="${medicalReport.k}" pattern="#0.0" /></c:if>
                        </li>

                        <li class="lefttitle">9、锶（Sr)</li>
                        <li class="rightcont" style="font-weight: bold;">
                        	<c:if test="${empty medicalReport.sr}">&nbsp;</c:if>
                 			<c:if test="${!empty medicalReport.sr}"><fmt:formatNumber value="${medicalReport.sr}" pattern="#0.00" /></c:if>
                        </li>

                        <li class="lefttitle">10、铬（Cr)</li>
                        <li class="rightcont" style="font-weight: bold;">
                        	<c:if test="${empty medicalReport.cr}">&nbsp;</c:if>
                 			<c:if test="${!empty medicalReport.cr}"><fmt:formatNumber value="${medicalReport.cr}" pattern="#0.00" /></c:if>
                        </li>

                        <li class="lefttitle">11、钼（Mo)</li>
                        <li class="rightcont" style="font-weight: bold;">
                        	<c:if test="${empty medicalReport.mo}">&nbsp;</c:if>
                 			<c:if test="${!empty medicalReport.mo}"><fmt:formatNumber value="${medicalReport.mo}" pattern="#0.00" /></c:if>
                        </li>

                    </ul>
                    <ul style="padding-left: 40px; box-sizing: border-box;">
                        <li class="lefttitle">分析项目</li>
                        <li class="rightcont">检测结果（μg/g）</li>

                        <li class="lefttitle">12、钴（Co)</li>
                        <li class="rightcont" style="font-weight: bold;">
                        	<c:if test="${empty medicalReport.co}">&nbsp;</c:if>
                 			<c:if test="${!empty medicalReport.co}"><fmt:formatNumber value="${medicalReport.co}" pattern="#0.00" /></c:if>
                        </li>

                        <li class="lefttitle">13、镍（Ni)</li>
                        <li class="rightcont" style="font-weight: bold;">
                        	<c:if test="${empty medicalReport.ni}">&nbsp;</c:if>
                 			<c:if test="${!empty medicalReport.ni}"><fmt:formatNumber value="${medicalReport.ni}" pattern="#0.00" /></c:if>
                        </li>

                        <li class="lefttitle">14、钒（V)</li>
                        <li class="rightcont" style="font-weight: bold;">
                        	<c:if test="${empty medicalReport.v}">&nbsp;</c:if>
                 			<c:if test="${!empty medicalReport.v}"><fmt:formatNumber value="${medicalReport.v}" pattern="#0.00" /></c:if>
                        </li>

                        <li class="lefttitle">15、钛（Ti)</li>
                        <li class="rightcont" style="font-weight: bold;">
                        	<c:if test="${empty medicalReport.ti}">&nbsp;</c:if>
                 			<c:if test="${!empty medicalReport.ti}"><fmt:formatNumber value="${medicalReport.ti}" pattern="#0.00" /></c:if>
                        </li>

                        <li class="lefttitle">16、钡（Ba)</li>
                        <li class="rightcont" style="font-weight: bold;">
                        	<c:if test="${empty medicalReport.ba}">&nbsp;</c:if>
                 			<c:if test="${!empty medicalReport.ba}"><fmt:formatNumber value="${medicalReport.ba}" pattern="#0.00" /></c:if>
                        </li>

                        <li class="lefttitle">17、硼（B)</li>
                        <li class="rightcont" style="font-weight: bold;">
                        	<c:if test="${empty medicalReport.b}">&nbsp;</c:if>
                 			<c:if test="${!empty medicalReport.b}"><fmt:formatNumber value="${medicalReport.b}" pattern="#0.00" /></c:if>
                        </li>

                        <li class="lefttitle">18、锡（Sn)</li>
                        <li class="rightcont" style="font-weight: bold;">
                        	<c:if test="${empty medicalReport.sn}">&nbsp;</c:if>
                 			<c:if test="${!empty medicalReport.sn}"><fmt:formatNumber value="${medicalReport.sn}" pattern="#0.00" /></c:if>
                        </li>

                        <li class="lefttitle">19、镉（Cd)</li>
                        <li class="rightcont" style="font-weight: bold;">
                        	<c:if test="${empty medicalReport.cd}">&nbsp;</c:if>
                 			<c:if test="${!empty medicalReport.cd}"><fmt:formatNumber value="${medicalReport.cd}" pattern="#0.00" /></c:if>
                        </li>

                        <li class="lefttitle">20、铝（Al)</li>
                        <li class="rightcont" style="font-weight: bold;">
                        	<c:if test="${empty medicalReport.al}">&nbsp;</c:if>
                 			<c:if test="${!empty medicalReport.al}"><fmt:formatNumber value="${medicalReport.al}" pattern="#0.0" /></c:if>
                        </li>

                        <li class="lefttitle">21、硅（Si)</li>
                        <li class="rightcont" style="font-weight: bold;">
                        	<c:if test="${empty medicalReport.si}">&nbsp;</c:if>
                 			<c:if test="${!empty medicalReport.si}"><fmt:formatNumber value="${medicalReport.si}" pattern="#0.00" /></c:if>
                        </li>

                        <li class="lefttitle">22、硒（Se)</li>
                        <li class="rightcont" style="font-weight: bold;">
                        	<c:if test="${empty medicalReport.se}">&nbsp;</c:if>
                 			<c:if test="${!empty medicalReport.se}"><fmt:formatNumber value="${medicalReport.se}" pattern="#0.00" /></c:if>
                        </li>

                    </ul>
                </div>
                <ul class="ultable" style="margin-top: 30px;">
                    <li class="wp50">分析人：<span>唐志鹏</span><div style="float: right;">复核人：冯杏玲</div></li>
                    <li class="wp50"><div style="padding-left: 40px;">报告日期：<span><fmt:formatDate type="date" value="${medicalReport.detectionDate}" pattern="yyyy-MM-dd"/></span></div></li>
                </ul>
                <div class="kongge_2"></div>
                <ul class="ultable">
                    <li class="wp100 wnormal">标准方法  头发样品用硝酸和高氯酸消化处理后，用AAS法测定</li>
                    <li class="wp100 wnormal">Standard Methods(JY/T 015-1996测定）</li>
                    <li class="wp100 wnormal">标准物质：①GBW09101 头发成分分析标准物质</li>
                    <li class="wp100 wnormal">Standard Mer.②GBW07601(GSH-1)头发成分分析标准物质</li>
                    <li class="wp100 wnormal">声明：</li>
                    <li class="wp100 wnormal">①未经本中心的书面批准不得部份复制本报告（全部复制除外）</li>
                    <li class="wp100 wnormal">②本报告为委托检测报告，只对来样负责。</li>
                    <li class="wp100 wnormal">③本检测项目仅用于医学保健目的，仅供医生参考使用，不作为职业病或铅中毒诊断的依据</li>
                </ul>
                <ul class="ultable">
                    <li class="wp100">地址：广州科学城崖鹰石路10号中山大学国家大学科技园　邮编：510080</li>
                </ul>
                <ul class="ultable">
                    <li class="wp100">电话：<span>020-37630722</span></li>
                </ul>

            <!-- </div> -->

        </div>
        <!-- printend -->
                    <script type="text/javascript">
	jQuery('#qrcode').qrcode({
	    render: "canvas", //也可以替换为table
	    width: 80,
	    height: 80,
		right: "1.8cm",
		top: "1cm",
	    text: "http://www.bt-healthy.com/f/report/detail?id=${medicalReport.id}&type=1&num=yjy"
	});
</script>
    </body>
</html>