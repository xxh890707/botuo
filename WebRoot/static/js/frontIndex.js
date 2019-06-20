        
        //string转换成date
        function stringToDate(str){ 
            var tempStrs = str.split(" "); 
            var dateStrs = tempStrs[0].split("-"); 
            var year = parseInt(dateStrs[0], 10); 
            var month = parseInt(dateStrs[1], 10) - 1; 
            var day = parseInt(dateStrs[2], 10); 
            var timeStrs = tempStrs[1].split(":"); 
            var hour = parseInt(timeStrs [0], 10); 
            var minute = parseInt(timeStrs[1], 10); 
            var second = parseInt(timeStrs[2], 10); 
            var date = new Date(year, month, day, hour, minute, second); 
            return date; 
        }
        

        
        
		$(document).ready(function() {
			$("#loginForm").validate({
				rules: {
					validateCode: {remote: proCtx+"/servlet/validateCodeServlet"}
				},
				messages: {
					username: {required: "请填写用户名."},password: {required: "请填写密码."},
					validateCode: {remote: "验证码不正确.", required: "请填写验证码."}
				},
				errorLabelContainer: "#messageBox",
				errorPlacement: function(error, element) {
					error.appendTo($("#loginError").parent());
				} 
			});
			
			
			//地址栏错误 信息隐藏处理
					/*function getUrlParam(name) {
					    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
					    var r = window.location.search.substr(1).match(reg);  //匹配目标参数
					    if (r != null) return unescape(r[2]); return null; //返回参数值
					}
					var j_message = getUrlParam('message');					
					if(j_message){
						//2秒后自动隐藏错误信息
						setTimeout(function(){
							$("#messageBox").fadeOut(1000);
						},1000)
					}*/
			
		});
		// 如果在框架或在对话框中，则弹出提示并跳转到首页
		if(self.frameElement && self.frameElement.tagName == "IFRAME" || $('#left').length > 0 || $('.jbox').length > 0){
			alert('未登录或登录超时。请重新登录，谢谢！');
			top.location = "";
		}
		
		function userLoginSubmit(){ 
			 var path = proCtx+"/a/login";
			 $("#loginForm").attr("action", path).submit();
			 
		}

	
		
		
