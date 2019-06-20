<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="content" type="java.lang.String" required="true" description="消息内容"%>
<%@ attribute name="type" type="java.lang.String" description="消息类型：info、success、warning、error、loading"%>
<%@ attribute name="showTip" type="java.lang.String" description="是否有提示效果,0/1"%>
<%@ attribute name="code" type="java.lang.String" description="仅用于区分多个提示"%>
<script type="text/javascript">top.$.jBox.closeTip();</script>
<c:if test="${not empty content}">
	<c:if test="${not empty type}"><c:set var="ctype" value="${type}"/></c:if><c:if test="${empty type}"><c:set var="ctype" value="${fn:indexOf(content,'失败') eq -1?'success':'error'}"/></c:if>
	<div id="messageBox${code }" class="alert alert-${ctype} hide"><button data-dismiss="alert" class="close">×</button>${content}</div> 
	<script type="text/javascript">
		var showTip = '${showTip}';
		if(showTip==null || showTip==''){
			showTip = '1';
		}
		if(!top.$.jBox.tip.mess){
			//top.$.jBox.tip.mess=1;
		if(showTip!='0'){
			top.$.jBox.tip("${content}","${ctype}",
			{persistent:true,opacity:0});
		}
			$("#messageBox${code }").show();
		}
	</script>
</c:if>