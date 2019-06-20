<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="input" type="java.lang.String" required="true" description="输入框"%>
<%@ attribute name="buttonText" type="java.lang.String" required="false" description="按扭名称"%>
<%@ attribute name="buttonWidth" type="java.lang.String" required="false" description="按扭宽度"%>
<%@ attribute name="type" type="java.lang.String" required="true" description="files、images、flash、thumb"%>
<%@ attribute name="uploadPath" type="java.lang.String" required="true" description="文件路径"%>
<%@ attribute name="selectMultiple" type="java.lang.Boolean" required="false" description="是否允许多选"%>
<%@ attribute name="readonly" type="java.lang.Boolean" required="false" description="是否查看模式"%>
<%@ attribute name="maxWidth" type="java.lang.String" required="false" description="最大宽度"%>
<%@ attribute name="maxHeight" type="java.lang.String" required="false" description="最大高度"%>
<%@ attribute name="checkbox" type="java.lang.Boolean" required="false" description="增加可选项"%>
<%@ attribute name="randomPath" type="java.lang.Boolean" required="false" description="使用随机路径"%>
<link href="${ctxStatic}/uploadify/css/uploadify.css" rel="stylesheet" />
<script type='text/javascript' src='${pageContext.request.contextPath}/static/uploadify/scripts/jquery.uploadify.js'></script>
<c:if test="${!readonly }">
<input type="file" id="${input}btn"/>
</c:if>
<ol id="${input}Preview"></ol>
<script type="text/javascript">
var selectMultiple = '${selectMultiple}';
var randomPath = '${randomPath}';
if(selectMultiple==""){
	selectMultiple = 'true';
}
if(randomPath==""){
	randomPath = 'true';
}
$(function(){
	var buttonText = '${buttonText}';
	var buttonWidth = '${buttonWidth}';
	var type = '${type}';
	switch (type) {
	case "files":
		type = "*.*";
		break;
	case "images":
		type = "*.BMP;*.GIF;*.PNG;*.JPG";
		break;
	case "flash":
		type = "*.swf";
		break;
	case "thumb":
		type = "*.BMP;*.GIF;*.PNG;*.JPG";
		break;
	}
	
	if(buttonText==""){
		buttonText = "添加附件";
	}
	if(buttonWidth==""){
		buttonWidth = "102";
	}
	$("#${input}btn").uploadify({
		swf: '${pageContext.request.contextPath}/static/uploadify/scripts/uploadify.swf',//控件flash文件位置
        uploader: '${pageContext.request.contextPath}/common/upload',
        width:buttonWidth,
		fileTypeExts: type, //控制可上传文件的扩展名
		auto:true,
		formData:{uploadPath:'${uploadPath}',randomPath:'${randomPath}'},
		multi: ${selectMultiple},
		method:'post',
		buttonText:buttonText,
		onFallback: function() {//检测FLASH失败调用
			alert("您未安装FLASH控件，无法上传图片！请安装FLASH控件后再试。");
		},
		onUploadSuccess: function(file, data, response) {//上传完成后的处理方法
			var obj = eval("("+data+")");
			${input}Add(obj);
		},
		removeCompleted:true,
		removeTimeout:0
	});
	
	${input}Preview();
});
	 function ${input}Add(obj){
		 if(selectMultiple=='false'){
			 $("#${input}").val(obj.path);
		 }else{
			 var urls = $("#${input}").val();
			 urls += "|"+obj.path;
			 $("#${input}").val(urls);
		 }
		 ${input}Preview();
	 }
	 function ${input}Del(obj){
		 var url = $(obj).prev().attr("url");
		 $("#${input}").val($("#${input}").val().replace("|"+url,"","").replace(url+"|","","").replace(url,"",""));
		 ${input}Preview();
	}
	 
	 function ${input}Preview(){
			var li, urls = $("#${input}").val().split("|");
			$("#${input}Preview").children().remove();
			var uploadPath = '${pageContext.request.contextPath}/upload';
			for (var i=0; i<urls.length; i++){
			    var cbchecked="";
				if(urls[i].lastIndexOf("&")>0){
				    cbchecked=urls[i].substring(urls[i].lastIndexOf("&")+1);
					urls[i]=urls[i].substring(0,urls[i].lastIndexOf("&"));
				}
				if (urls[i]!=""){
					if(urls[i].lastIndexOf(uploadPath)==-1){
						urls[i] = '${pageContext.request.contextPath}/upload'+urls[i];
					}
					//<c:if test="${type eq 'thumb' || type eq 'images'}">
					li = "<li><img src=\""+urls[i]+"\" url=\""+urls[i]+"\" style=\"max-width:${empty maxWidth ? 200 : maxWidth}px;max-height:${empty maxHeight ? 200 : maxHeight}px;_height:${empty maxHeight ? 200 : maxHeight}px;border:0;padding:3px;\">";//</c:if><c:if test="${type ne 'thumb' && type ne 'images'}">
					li = "<li><a href=\""+urls[i]+"\" url=\""+urls[i]+"\" target=\"_blank\">"+decodeURIComponent(urls[i].substring(urls[i].lastIndexOf("/")+1))+"</a>";//</c:if>
					li += "&nbsp;&nbsp;<c:if test="${!readonly}"><a href=\"javascript:\" onclick=\"${input}Del(this);\">×</a></c:if>";
					li +="<c:if test="${checkbox}">&nbsp;&nbsp;<input id=\"${input}Checkbox\" type=\"checkbox\" "+cbchecked+" onclick=\"${input}Selected(this);  \"><span>不显示</span></input> </c:if>";
					li +="</li>";
					$("#${input}Preview").append(li);
				}
			}
			if ($("#${input}Preview").text() == ""){
				$("#${input}Preview").html("<li style='list-style:none;padding-top:5px;'>无</li>");
			}
		}
	 function ${input}Selected(obj){
		 $(obj).attr("checked",this.checked);
		 var checkflag="&checked";
		 var docurl= $("#${input}").val();
		 var thisurl = $(obj).prev().prev().attr("url");
		 
		 if ($(obj).attr("checked")) {
			$("#${input}").val( docurl.replace(thisurl+checkflag,thisurl).replace(thisurl,thisurl+checkflag) );
		 }else{
			$("#${input}").val( docurl.replace(thisurl+checkflag,thisurl) );
		 }
	}
</script>