<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="id" type="java.lang.String" required="false" description="id"%>
<%@ attribute name="type" type="java.lang.String" required="true" description="字典类型"%>
<%@ attribute name="path" type="java.lang.String" required="true" description="path"%>
<%@ attribute name="value" type="java.lang.String" required="false" description="值"%>
<%@ attribute name="cssClass" type="java.lang.String" required="false" description="cssClass"%>

<div class="select-tag${path }${id}"></div>
<script type="text/javascript">
    $(".select-tag${path }${id}").load("${ctx}/sys/dict/dictSelectTag?type=${type}&path=${path}&myvalue=${value}&cssClass=${cssClass}&t="+new Date().getTime());
</script>