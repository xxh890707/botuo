<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fns" uri="/WEB-INF/tlds/fns.tld" %>
<html>
<head>
	<title>检查报告打印</title>
	<meta charset="utf-8">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/print.css" media="print">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/print.css">


  </head>
  
<body>
        <!-- printstart -->
               <div class="printbox4" id="printbox">
            <p style="text-align: right;"><span style="display: none">检测号：</span><span>${medicalReport.reportNum}</span></p>
            <div class="ewm2"><img src="${medicalReport.gscode}"></div>
            <div class="ewmp2">扫描右边的二维码<br>在线查询报告单</div>
            <div style="height: 100px;">
                
            </div>
            <ul class="ultable">
                <li class="wp20">姓名：<span>${medicalReport.person}</span></li>
                <li class="wp10">性别：<span>${fns:getDictLabel(medicalReport.sex,'sex','') }</span></li>
                <li class="wp20">年龄：<span>${medicalReport.age}</span></li>
                <li class="wp50">来样单位：<span>${medicalReport.deliverUnit}</span></li>
                <li class="wp50">&nbsp;</li>
                <li class="wp50">&nbsp;<span style="display: none">电话：</span><span><fmt:formatNumber value="${medicalReport.phone}" pattern="#" /></span></li>
            </ul>
            <div class="nbsp"></div>
            <table cellpadding="0" cellspacing="0" class="table">
                <tr>
                    <td colspan="2">元素<br>(μg/g)</td>
                    <td>锌(Zn)</td>
                    <td>铁(Fe)</td>
                    <td>铜(Cu)</td>
                    <td>钙(Ca)</td>
                    <td>镁(Mg)</td>
                    <td>锰(Mn)</td>
                    <td>钾(K)</td>
                </tr>
                <tr>
                    <td rowspan="2" class="rowspans">参考值</td>
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
                    <c:forEach items="${r.elements}" var="e">
                    	<c:if test="${e.ename == 'Zn' || e.ename == 'Fe' || e.ename == 'Cu' || e.ename == 'Ca' || e.ename == 'Mg' || e.ename == 'Mn' || e.ename == 'K'}">
                    	<td><fmt:formatNumber type="number" value="${e.value}" pattern="0.0" /></td>
                    	</c:if>
                 	</c:forEach>
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
                    <td rowspan="2" class="rowspans">参考值</td>
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
                    <c:forEach items="${r.elements}" var="e">
                    	<c:if test="${e.ename == 'Sr' || e.ename == 'Cr' || e.ename == 'Mo' || e.ename == 'Co' || e.ename == 'Ni' || e.ename == 'V' || e.ename == 'Ti'}">
                    	<td><fmt:formatNumber type="number" value="${e.value}" pattern="0.0" /></td>
                    	</c:if>
                 	</c:forEach>
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
                    <td rowspan="2" class="rowspans">参考值</td>
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
                    <c:forEach items="${r.elements}" var="e">
                    	<c:if test="${e.ename == 'Ba' || e.ename == 'B' || e.ename == 'Sn' || e.ename == 'Pb' || e.ename == 'Cd' || e.ename == 'Al'}">
                    	<td><fmt:formatNumber type="number" value="${e.value}" pattern="0.0" /></td>
                    	</c:if>
                 	</c:forEach>
                </tr>
            </table>
            <div style="padding:10px 20px;">
                <ul class="ultable">
                    <li class="wp69">分析人：<span>唐志鹏</span></li>
                    <li class="wp31">报告日期：<span><fmt:formatDate type="date" value="${medicalReport.detectionDate}" pattern="yyyy-MM-dd"/></span></li>
                </ul>
                <div class="nbsp"></div>
            </div>
        </div>
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