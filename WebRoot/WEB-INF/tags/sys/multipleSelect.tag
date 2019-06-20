<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="id" type="java.lang.String" required="true" description="id"%>
<%@ attribute name="name" type="java.lang.String" required="true" description="name"%>
<%@ attribute name="leftOptions" type="java.util.List" required="true" description="左边options"%>
<%@ attribute name="rightOptions" type="java.util.List" required="true" description="右边options"%>
<%@ attribute name="value" type="java.lang.String" required="true" description="value"%>
<%@ attribute name="label" type="java.lang.String" required="true" description="label"%>

<div class="multiple-select">
	<select id="${id}Left" name="${name}Left" multiple="multiple">
		<c:forEach items="${leftOptions}" var="leftOption" varStatus="leftOptionStatus">
			<option value=""></option>
		</c:forEach>
	</select>
</div>
<script type="text/javascript">
	
</script>