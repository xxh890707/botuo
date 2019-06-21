(function($) {
	// 全局系统对象
	window['PJ'] = {};

	// 判断页面是否在框架中
	PJ.inIframe = function() {
		if (window.top == window.self) {
			return false;
		} else {
			return true;
		}
	};
	// 显示loading
	PJ.showLoading = function(message) {
		message = message || "正在加载中...";
		top.$.ligerDialog.waitting(message);
	};

	// 隐藏loading
	PJ.hideLoading = function(message) {
		top.$.ligerDialog.closeWaitting();
	};

	// 显示成功提示窗口
	PJ.success = function(message, callback) {
		if (typeof (message) == "function" || arguments.length == 0) {
			callback = message;
			message = "操作成功!";
		}
		top.$.ligerDialog.success(message, '提示信息', callback);
	};

	// 显示警告提示窗口
	PJ.warn = function(message, callback) {
		if (typeof (message) == "function" || arguments.length == 0) {
			callback = message;
			message = "操作有误!";
		}
		top.$.ligerDialog.warn(message, '警告信息', callback);
	};

	// 显示失败提示窗口
	PJ.error = function(message, callback) {
		if (typeof (message) == "function" || arguments.length == 0) {
			callback = message;
			message = "操作失败!";
		}
		top.$.ligerDialog.error(message, '提示信息', callback);
	};
	// 显示提示窗口(无图标)
	PJ.alert = function(message, callback) {
		if (typeof (message) == "function" || arguments.length == 0) {
			callback = message;
			message = "操作失败!";
		}
		top.$.ligerDialog.alert(message, '提示信息', callback);
	};

	// 右下角的提示框
	PJ.tip = function(message, callback) {
		clearTimeout(PJ.tiptimeout);
		if (PJ.wintip) {
			PJ.wintip.set('content', message);
			PJ.wintip.show();
			if (callback) {
				callback();
			}
		} else {
			PJ.wintip = $.ligerDialog.tip({
				content : message
			});
			if (callback) {
				callback();
			}
		}
		PJ.tiptimeout = setTimeout(function() {
			PJ.wintip.hide();
		}, 4000);
	};

	// 右下角的提示框无时间限制,而且不覆盖
	PJ.tipNoTimeOut = function(message, callback) {
		PJ.wintip = $.ligerDialog.tip({
			content : message
		});
		if (callback) {
			callback();
		}
	};

	// 确认提示
	PJ.confirm = function(message, callback) {
		top.$.ligerDialog.confirm(message, callback);
	};

	// 填充表单,根据json
	PJ.loadFormJson = function(mainform, data) {
		if (!mainform)
			mainform = $("form:first");
		data = data || {};
		PJ.showLoading('正在加载表单数据中...');
		for ( var p in data) {
			var ele = $("[name=" + p + "]", mainform);
			// 针对复选框和单选框 处理
			if (ele.is(":checkbox,:radio")) {
				ele.each(function() {
					if ($(this).val() == data[p]) {
						$(this).attr("checked", "checked");
					}
				});
				// ele[0].checked = data[p] ? true : false;
			} else {
				ele.val(data[p]);
			}
		}
		PJ.hideLoading();
	};

	// 填充表单数据(通过url)
	PJ.loadForm = function(mainform, options, callback) {
		options = options || {};
		if (!mainform)
			mainform = $("form:first");
		var p = $.extend({
			beforeSend : function() {
				PJ.showLoading('正在加载表单数据中...');
			},
			complete : function() {
				PJ.hideLoading();
			},
			success : function(data) {
				var preID = options.preID || "";
				// 根据返回的属性名，找到相应ID的表单元素，并赋值
				for ( var p in data) {
					var ele = $("[name=" + (preID + p) + "]", mainform);
					// 针对复选框和单选框 处理
					if (ele.is(":checkbox,:radio")) {
						ele.each(function() {
							if ($(this).val() == data[p]) {
								$(this).attr("checked", "checked");
							}
						});
					} else {
						ele.val(data[p]);
					}
				}
				// 下面是更新表单的样式
				var managers = $.ligerui.find($.ligerui.controls.Input);
				for (var i = 0, l = managers.length; i < l; i++) {
					// 改变了表单的值，需要调用这个方法来更新ligerui样式
					var o = managers[i];
					o.updateStyle();
					if (managers[i] instanceof $.ligerui.controls.TextBox)
						o.checkValue();
				}
				if (callback)
					callback(data);
			},
			error : function(message) {
				PJ.error('数据加载失败!<BR>错误信息：' + message);
			}
		}, options);
		PJ.ajax(p);
	};

	// Ajax提交
	PJ.ajax = function(options) {
		var p = options || {};
		var url = p.url;
		var async = true;
		if(p.async != undefined) {
			async = p.async;
		}

		$.ajax({
			cache : false,
			async : async,
			url : url,
			data : p.data,
			dataType : 'json',
			type : 'post',
			beforeSend : function() {
				PJ.loading = true;
				if (p.beforeSend)
					p.beforeSend();
				else
					PJ.showLoading(p.loading);
			},
			complete : function() {
				PJ.loading = false;
				if (p.complete)
					p.complete();
				else
					PJ.hideLoading();
			},
			success : function(result) {
				if (!result)
					return;
				if (p.success)
					p.success(result);
			},
			error : function(result, b) {
				if (p.error) {
					p.error(result);
				} else {
					PJ.tip('系统错误 <BR>错误码：' + result.status);
				}
			}
		});
	};

	// 单选树,id为ul的id,url为数据来源url,callback为onSelect的方法(不指定则默认是打开新tab)
	PJ.pidTree = function(id, url, callback, options) {
		options = options || {};
		var autoCheckboxEven = true;
		if(options.autoCheckboxEven != undefined) {
			autoCheckboxEven = options.autoCheckboxEven;
		}
		
		var tree = $("#" + id).ligerTree({
			url : url,
			checkbox : options.checkbox || false,
			autoCheckboxEven : autoCheckboxEven,
			slide : false,
			idFieldName : 'id',
			parentIDFieldName : 'pid',
			isExpand : options.isExpand || false,
			attribute : [ 'nodename', 'url' ],
			onSelect : function(node) {
				if (callback) {
					callback(node);
				} else {
					if (!node.data.url)
						return;
					var tabid = $(node.target).attr("tabid");
					if (!tabid) {
						tabid = new Date().getTime();
						$(node.target).attr("tabid", tabid);
					}
					PJ.addTab(node.data.text, node.data.url, tabid);
				}
			},
			onSuccess :function(data){
				if (options.onSuccess)
					options.onSuccess(data);
			}
		});
		return tree;
	};

	// 获取数据
	PJ.iframeGetFormData = function(iframeId) {
		if (PJ.inIframe()) {
			return top.PJ.iframeGetFormData(iframeId);
		}
		return window.frames[iframeId].getFormData();
	};
	// 校验
	PJ.iframeValidate = function(iframeId) {
		if (PJ.inIframe()) {
			return top.PJ.iframeValidate(iframeId);
		}
		return window.frames[iframeId].validate();
	};

	// 打开对话框
	PJ.topdialog = function(id, title, url, savedCallback, cancleCallback,
			width, height, showMax, saveTitle, cancleTitle,allowClose) {
		if (PJ.inIframe()) {
			top.PJ.dialog(id, title, url, savedCallback, cancleCallback, width,
					height, showMax, saveTitle, cancleTitle,allowClose);
			return;
		}
		PJ.dialog(id, title, url, savedCallback, cancleCallback, width,
				height, showMax, saveTitle, cancleTitle,allowClose);
	};
	
	
	// 在最上层打开对话框
	PJ.openTopDialog = function(id,title,url,options) {
		if (PJ.inIframe()) {
			top.PJ.openDialog(id,title,url,options);
			return;
		}
		PJ.openDialog(id,title,url,options);
	};
	
	//打开对话框
	PJ.openDialog = function(id,title,url,options){
		options = options || {};
		if (!url) {
			PJ.error("未指定链接地址！");
			return;
		}
		if (!title) {
			title = "系统";
		}
		
		var buttons = [];
		var cancleCallback = options.cancle || undefined;
		if (cancleCallback) {
			buttons.push({
				text : options.cancleTitle || "关闭",
				onclick : function(item, dialog) {
					cancleCallback(item, dialog);
				}
			});
		}
		var savedCallback = options.save || undefined;
		if (savedCallback) {
			buttons.push({
				text : options.saveTitle || "确定",
				onclick : function(item, dialog) {
					savedCallback(item, dialog);
				}
			});
		}
		
		$.ligerDialog.open({
			title : title || "系统 ",
			name : id || "dialog",
			width : options.width || 900,
			height : options.height || 600,
			isResize : true,
			allowClose : options.allowClose || false,
			url : url,
			showMax : options.showMax || false,
			buttons : options.buttons || buttons
		});
	};

	// 打开对话框
	PJ.dialog = function(id, title, url, savedCallback, cancleCallback, width,
			height, showMax, saveTitle, cancleTitle,allowClose) {
		if (!showMax)
			showMax = false;
		if (!allowClose)
			allowClose = false;
		if (!url) {
			PJ.error("未指定链接地址！");
			return;
		}
		var buttons = [];
		if (cancleCallback) {
			if (!cancleTitle)
				cancleTitle = "关闭";
			buttons.push({
				text : cancleTitle,
				onclick : function(item, dialog) {
					cancleCallback(item, dialog);
				}
			});
		}
		if (savedCallback) {
			if (!saveTitle)
				saveTitle = "确定";
			buttons.push({
				text : saveTitle,
				onclick : function(item, dialog) {
					savedCallback(item, dialog);
				}
			});
		}
		if (!title) {
			title = "";
		}
		if (!width) {
			width = 900;
		}
		if (!height) {
			height = 600;
		}
		$.ligerDialog.open({
			title : title,
			name : id,
			width : width,
			height : height,
			isResize : true,
			allowClose : allowClose,
			url : url,
			showMax : showMax,
			buttons : buttons
		});
	};

	// 获取iframe中的form序列化，用于ajax
	PJ.iframeFormData = function(iframeName, formId) {
		return $(window.frames[iframeName].document).find(
				"form[id='" + formId + "']").serialize();
	};

	// 打开新tab页
	PJ.addTab = function(text, url, tabid) {
		if (!tabid)
			tabid = new Date().getTime();
		top.f_addTab(tabid, text, url);
	};

	// 获取布局center高度
	PJ.getCenterHeight = function() {
		return $(".l-layout-center").height();
	};
	// 获取布局center宽度
	PJ.getCenterWidth = function() {
		return $(".l-layout-center").width();
	};
	// 获取布局left高度
	PJ.getLeftHeight = function() {
		return $(".l-layout-left").height();
	};
	// 获取布局left宽度
	PJ.getLeftWidth = function() {
		return $(".l-layout-left").width();
	};

	//jqGrid
	PJ.grid = function (id,options){
		var bWidth = document.body.offsetWidth,
		bHeight = document.documentElement.clientHeight;
		options = options || {};
		var shrinkToFit = options.shrinkToFit;
		if(shrinkToFit!=undefined && !shrinkToFit){
			shrinkToFit = function(){
				return false;
			};
		}
		var pager = options.pager || '#pager1';
		var grid = jQuery("#"+id).jqGrid({
			url:options.url || '',
			data:options.data || '',
			datatype: "json",
			mtype:"post",
			loadtext:options.loadtext || "数据加载中...",
			multiselect: options.multiselect || false,
			gridview: options.gridview || false,
			width:options.width || bWidth-10,
			height: options.height || bHeight-300,
			toolbar : options.toolbar || [ false, "top" ],
			shrinkToFit:shrinkToFit || true,
			colNames:options.colNames || [],
			colModel:options.colModel || [],
			rowNum:options.rowNum || 20,
		   	rowList:options.rowList  || [20,30,50],
		   	pager: pager,
		   	sortname: options.sortname || 'id',
		    viewrecords: options.viewrecords || true,
		    sortorder: options.sortorder || "asc",
		    rownumbers:options.rownumbers || true,
		    rownumWidth : options.rownumWidth || 25,
		    jsonReader : {repeatitems: true},
		    editurl:options.editurl || '',
		    caption:options.caption || "",
		    sortable:options.sortable || false,
		    postData:options.postData || {},
		    afterInsertRow: function(rowid, aData){ 
		    	if(options.afterInsertRow){
		    		options.afterInsertRow(rowid, aData);
		    	}
		    },gridComplete:function(){
		    	//去外边框
				$("#gbox_"+id).css("border", "none");
				//BUG
				$("#ui-datepicker-div").hide();
				
		    	if(options.gridComplete){
		    		options.gridComplete();
		    	}
		    },onSelectRow:function(rowid,status,e){
		    	if(options.onSelectRow){
		    		options.onSelectRow(rowid,status,e);
		    	}
		    },
		    onSelectAll:function(aRowids,status){
		    	if(options.onSelectAll){
		    		options.onSelectAll(aRowids,status);
		    	}
		    },
		    ondblClickRow:options.ondblClickRow,
		    grouping:options.grouping || false,
		    groupingView : options.groupingView|| '',
		    footerrow: options.footerrow || false,
		    userDataOnFooter : options.userDataOnFooter ||false,
		    altRows: options.altRows ||false,
		    subGrid: options.subGrid || false,
		    subGridUrl: options.subGridUrl || '',
		    subGridModel: options.subGridModel || []
		});
		//默认有导出
		grid.navGrid(pager,{view:true,edit:false,add:false,del:false,search:false,refresh:false,"export":true},{},{},{});
		$("#export_"+id).hide();
		var hideview = options.hideview || false;
		if(hideview)
			$("#view_"+id).hide();
		return grid;
	};

	//jqgrid列
	PJ.grid_column = function(name,options){
		var column = {
			name:name,
			key:options.key || false,
			index:options.index || name,
			width:options.width || 120,
			frozen:options.frozen || false,
			hidden:options.hidden || false,
			editable:options.editable || false,
			edittype:options.edittype || "", 
			editrules:options.editrules || {},
			editoptions:options.editoptions || {},
			search:options.search || false,
			searchoptions:options.searchoptions || {},
			sortable:options.sortable || false,
			sorttype:options.sorttype || "String",
			formoptions:options.formoptions || {},
			formatter: options.formatter || "",
			align: options.align || "left",
			summaryType:options.summaryType ||"",
			summaryTpl:options.summaryTpl||""
		};
		return column;
	};

	
	// 获取jqgrid选中数据
	PJ.grid_getSelectedData = function(grid) {
		var rowKey = grid.getGridParam("selrow");
		if (rowKey) {
			var ret = grid.jqGrid('getRowData',rowKey);
			return ret;
		}else{
			PJ.warn("请选择需要操作的数据");
		}
	};

	// 获取jqgrid多选的id
	PJ.grid_getMutlSelectedRowkey = function(grid) {
		var rowKey = grid.getGridParam("selarrrow");
		if (rowKey != "") {
			return rowKey;
		} else {
			PJ.warn("请选择需要操作的数据");
			return false;
		}
	};

	// 刷新数据
	PJ.grid_reload = function(grid) {
		grid.trigger("reloadGrid");
	};

	// 清空数据
	PJ.grid_clear = function(grid) {
		grid.jqGrid("clearGridData");
	};
	
	//导出当前数据
	PJ.grid_export = function(id){
		$("#export_"+id).trigger("click");
	};
	
	//查看当前数据
	PJ.view = function(id){
		$("#view_"+id).trigger("click");
	};
	
	// 搜索按扭
	PJ.grid_search = function(grid, url) {
		var flag = true, searchString = "";
		$(document).find("[alias]").each(function(i, e) {
			if (!$(e).val() || !$.trim($(e).val()))
				return true;

			var result = checkRule(e);
			flag = result[0];
			if (flag) {
				var value = $(e).val();
				var name = $(e).attr("prefix");
				if (name) {
					name += ".";
				}else{
					name="";
				}
				name += $(e).attr("alias");
				var str = getRuleString(name, result[1], value, result[2]);
				if (searchString && str)
					searchString += " AND ";
				searchString += str;
			} else {
				return false;
			}
		});
		if (flag) {
			//grid.setParm("searchString",searchString);
			//grid.set("url",url);
			grid.jqGrid('setGridParam', {
				postData : {
					searchString : searchString
				},
				url : url
			}).trigger('reloadGrid');
		}
	};

	// 给搜索条件中所有elemType为date的input加上日期选择
	PJ.datepickerAll = function() {
		// 搜索条件加日期选择
		$("input[elemType=date]").each(function(i, elem) {
			$(elem).live("click", function() {
				WdatePicker();
			});
		});
		// 搜索条件加日期选择
		$("input[elemType=year]").each(function(i, elem) {
			$(elem).live("click", function() {
				WdatePicker({
					dateFmt:"yyyy"
				});
			});
		});
	};

	// 给指定ID的input加上日期选择
	PJ.datepicker = function(id) {
		$("#" + id).click(function() {
			WdatePicker();
		});
	};
	
	//取日期  txtMain:完整的日期ID; txtY,txtM,txtD: 年月日的id
	PJ.pickDate = function(txtMain,txtY,txtM,txtD){
		WdatePicker({el:txtMain,onpicked:function(){
	        
	         $dp.$(txtY).value=$dp.cal.getP('y');
	         $dp.$(txtM).value=$dp.cal.getP('M');
	         $dp.$(txtD).value=$dp.cal.getP('d');

	      }, oncleared: function() {  $dp.$(txtY).value='';
	         $dp.$(txtM).value='';
	         $dp.$(txtD).value=''; }
			,
		  errDealMode:3});
		
	};
	
	//取日期  txtMain:完整的日期ID; txtY,txtM,txtD: 年月日的id
	PJ.PickHDate = function(txtMain,txtY,txtM,txtD, txtH){
		WdatePicker({el:txtMain,dateFmt:"yyyy-MM-dd HH",onpicked:function(){
	         $dp.$(txtY).value=$dp.cal.getP('y');
	         $dp.$(txtM).value=$dp.cal.getP('M');
	         $dp.$(txtD).value=$dp.cal.getP('d');
	         $dp.$(txtH).value=$dp.cal.getP('H');
	         

	      }, oncleared: function() {  $dp.$(txtY).value='';
	         $dp.$(txtM).value='';
	         $dp.$(txtD).value=''; 
	         }
			,
		  errDealMode:3});
	};
	
	//取日期  txtMain:完整的日期ID; txtY,txtM,txtD: 年月日的id
	PJ.PickFullDate = function(txtMain,txtY,txtM,txtD, txtH, txtm){
		WdatePicker({el:txtMain,dateFmt:"yyyy-MM-dd HH:mm",onpicked:function(){
	         $dp.$(txtY).value=$dp.cal.getP('y');
	         $dp.$(txtM).value=$dp.cal.getP('M');
	         $dp.$(txtD).value=$dp.cal.getP('d');
	         $dp.$(txtH).value=$dp.cal.getP('H');
	         $dp.$(txtm).value=$dp.cal.getP('m');
	         

	      }, oncleared: function() {  $dp.$(txtY).value='';
	         $dp.$(txtM).value='';
	         $dp.$(txtD).value=''; 
	         }
			,
		  errDealMode:3});
	};
	
	//选译处理人
	PJ.selectAssignee = function(options,callback){
		options = options || {};
		var iframeId = 'taskAssigneeDialog';
		var title= options.title || '选择任务处理人';
		var url = options.url || basePath+'/flow/selectAssigneer';
		if(options.data){
			url += '?'+options.data;
		}else{
			url += '?type=select3';//默认三级选人
		}
		var width = 815;
		var height= 383;
		
		PJ.openTopDialog(iframeId, title, url, {
			save:function(item,dialog){
				var flag = PJ.iframeValidate(iframeId);
				if(flag){
					dialog.hide();
					var assigneedata = PJ.iframeGetFormData(iframeId);
					var ids;
					if(typeof assigneedata =='string'){
						ids = assigneedata;
					}else{
						for ( var i in assigneedata) {
							if(i==0){
								ids = assigneedata[i].data.id;
							}else{
								ids = ids+";"+assigneedata[i].data.id;
							}
						}
					}
					
					if(callback){
						callback(ids);
					}
					dialog.close();
				}else{
					PJ.warn("请选择岗位或者处理人");
				}
			},
			cancle:function(item,dialog){
				dialog.close();
			},
			width:width,
			height:height
		});
	};
	
	//附件管理dialog
	PJ.attachmentDialog = function(options,callback){
		options = options || {};
		var iframeId = 'attachmentListDialog';
		var title= options.title || '附件管理';
		var url = options.url || basePath+'/fj/list';
		var add = options.add || false,
			remove = options.remove || false,
			download = options.download || false;
		url += "?add="+add+"&remove="+remove+"&download="+download;
		if(options.data){
			url += '&data='+encodeURIComponent(options.data);
			var width = 755;
			var height= 383;
			PJ.openTopDialog(iframeId, title, url, {
				cancle:function(item,dialog){
					dialog.close();
				},
				width:width,
				height:height,
				showMax:true
			});
		}else{
			PJ.warn("调用异常,请传入data参数值");
		}
	};
	
	//生成附件iframe
	PJ.attachmentFrame = function(options){
		options = options || {};
		var url = options.url || basePath+'/fj/list';
		var width = options.width || 755;
		var height= options.height || 383;
		var add = options.add || false,
			remove = options.remove || false,
			download= options.download || true;//默认可下载不可上传和删除
		url += "?add="+add+"&remove="+remove+"&download="+download;
		if(options.data){
			url += '&data='+encodeURIComponent(options.data);
			document.write("<iframe width=\""+width+"\" height=\""+height+"\" frameborder=\"0\" name=\"attachmentlistFrame\" id=\"attachmentlistFrame\" src=\""+url+"\"></iframe>");
		}else{
			document.write("<h3 style='color:red'>调用异常,请传入data参数值</h2>");
		}
	};
	
	//附件上传
	PJ.uploadAttachment = function(id,data,callback){
		if(id){
			$(id).click(function(){
				uploadFile(data,callback);
			});
		}else{
			uploadFile(data,callback);
		}
	};

	//根据参数控制附件管理的按扭
	PJ.ctrlAttachmentButton = function(toolbar,json){
		var add = json.add;
		var remove = json.remove;
		var download = json.download;
		var itemarr = new Array();
		if(add=="false"){
			itemarr.push('add');
		}
		if(remove=="false"){
			itemarr.push('remove');
		}
		if(download=="false"){
			itemarr.push('download');
		}
		PJ.toolbar_hideItems(toolbar, itemarr.join(","));
	};
	
	//帮助
	PJ.help = function(key){
		/*var iframeId = key+"helpDialog";
		var title = "功能帮助";
		var url = basePath + "/help/view/"+key;
		PJ.openTopDialog(iframeId, title, url, {
			cancle:function(item,dialog){
				dialog.close();
			},
			width:800,
			height:620,
			cancleTitle:"关闭帮助"
		});*/
		
		PJ.addTab('功能帮助', basePath + "/help/view/"+key, 'help'); 
	};
	

	//取得所有toolbar的item
	PJ.toolbar_getAllItem = function(toolbar){
		return toolbar.options.items;
	};

	//toolbar全部禁用
	PJ.toolbar_disableAll = function(toolbar){
		var items = PJ.toolbar_getAllItem(toolbar);
		for ( var i in items) {
			PJ.toolbar_disableItems(toolbar,items[i].id);
		}
	};

	//toolbar全部启用
	PJ.toolbar_enableAll = function(toolbar){
		var items = PJ.toolbar_getAllItem(toolbar);
		for ( var i in items) {
			PJ.toolbar_ebableItems(toolbar,items[i].id);
		}
	};

	//toolbar启用指定的按扭
	PJ.toolbar_ebableItems = function(toolbar,itemids){
		var itemarr = itemids.split(",");
		if(itemarr.length>0){
			for ( var i in itemarr) {
				if(!toolbar.isEnable(itemarr[i])){
					toolbar.setEnabled(itemarr[i]);
				}
			}
		}
	};

	//toolbar禁用指定的按扭
	PJ.toolbar_disableItems = function(toolbar,itemids){
		var itemarr = itemids.split(",");
		if(itemarr.length>0){
			for ( var i in itemarr) {
				if(toolbar.isEnable(itemarr[i])){
					toolbar.setDisabled(itemarr[i]);
				}
			}
		}
	};
	
	//toolbar全部显示
	PJ.toolbar_showAll = function(toolbar){
		var items = PJ.toolbar_getAllItem(toolbar);
		for ( var i in items) {
			PJ.toolbar_ebableItems(toolbar,items[i].id);
		}
	};

	//toolbar显示指定的按扭
	PJ.toolbar_showItems = function(toolbar,itemids){
		var itemarr = itemids.split(",");
		if(itemarr.length>0){
			for ( var i in itemarr) {
				var id = itemarr[i];
				if(id){
					toolbar.toolBar.find(".l-toolbar-item[toolbarid=" + id + "]").css("display","block");
				}
			}
		}
	};

	//toolbar隐藏指定的按扭
	PJ.toolbar_hideItems = function(toolbar,itemids){
		var itemarr = itemids.split(",");
		if(itemarr.length>0){
			for ( var i in itemarr) {
				var id = itemarr[i];
				if(id){
					toolbar.toolBar.find(".l-toolbar-item[toolbarid=" + id + "]").css("display","none");
				}
			}
		}
	};
	
	PJ.searcNsr = function(jsons,callback){
		PJ.ajax({
            url: basePath+"/gy/nsr/search",
            //调用子页面的数据获取方法
            dataType:'json',
            data: "json="+jsons,
            loading: "正在搜索...",
            success: function(result) {
            	return result;
            }
        });
	};
	
	
	PJ.setSelectOption = function(id,url){
		PJ.ajax({
            url: url,
            //调用子页面的数据获取方法
            dataType:'json',
            loading: "正在搜索...",
            success: function(result) {
            	for(var i =0;i<result.length;i++){
            		$("#"+id).append("<option value='"+result[i].slfsDm+"'>"+result[i].slfsMc+"</option>"); 
            	}
            }
        });
	};
	
	//选税务人员,返回税务人员和税务机关
	PJ.selectSwry = function(id,callback,options){
		options = options || {};
		var multiselect = options.multiselect || false;
		$(id).click(function(){
			var iframeId = "selectSwryDialog";
			var title = options.title || "选择税务人员";
			var url = basePath + "/xtgl/qxgl/selectSwry?multiselect="+multiselect;
			var rootswjg = options.rootswjg;
			if(rootswjg && rootswjg!=""){
				url += "&rootswjg="+rootswjg;
			}
			var width = options.width || "700";
			var height = options.height || "400";
			PJ.openTopDialog(iframeId, title, url, {
				save:function(item,dialog){
					var flag = PJ.iframeValidate(iframeId);
					if(flag){
						 var ret = PJ.iframeGetFormData(iframeId);
						 dialog.close();
						 callback(ret);
					}else{
						top.PJ.warn("请选择税务人员");
					}
				},
				cancle:function(item,dialog){
					dialog.close();
				},
				width:width,
				height:height,
				saveTitle:"选择"
			});
		});
	};
	
	//选岗位,返回岗位和税务机关
	PJ.selectGw = function(id,callback,options){
		options = options || {};
		$(id).click(function(){
			var iframeId = "selectGwDialog";
			var title = options.title || "选择岗位";
			var url = basePath + "/xtgl/qxgl/selectGw";
			var rootswjg = options.rootswjg;
			if(rootswjg && rootswjg!=""){
				url += "?rootswjg="+rootswjg;
			}
			var width = options.width || "800";
			var height = options.height || "400";
			PJ.openTopDialog(iframeId, title, url, {
				save:function(item,dialog){
					var flag = PJ.iframeValidate(iframeId);
					if(flag){
						 var ret = PJ.iframeGetFormData(iframeId);
						 dialog.close();
						 callback(ret);
					}else{
						top.PJ.warn("请选择岗位");
					}
				},
				cancle:function(item,dialog){
					dialog.close();
				},
				width:width,
				height:height,
				saveTitle:"选择"
			});
		});
	};
	
	//选税务机关,返回税务机关
	PJ.selectSwjg = function(id,callback,options){
		options = options || {};
		$(id).click(function(){
			var iframeId = "selectSwjgDialog";
			var title = options.title || "选择税务机关";
			var url = basePath + "/xtgl/qxgl/selectSwjg";
			var rootswjg = options.rootswjg;
			if(rootswjg && rootswjg!=""){
				url += "?rootswjg="+rootswjg;
			}
			var width = options.width || "350";
			var height = options.height || "450";
			PJ.openTopDialog(iframeId, title, url, {
				save:function(item,dialog){
					var flag = PJ.iframeValidate(iframeId);
					if(flag){
						 var ret = PJ.iframeGetFormData(iframeId);
						 dialog.close();
						 callback(ret);
					}else{
						top.PJ.warn("请选择税务机关");
					}
				},
				cancle:function(item,dialog){
					dialog.close();
				},
				width:width,
				height:height,
				saveTitle:"选择"
			});
		});
	}
	

	//上传的方法
	function uploadFile(data,callback){
		var id = 'uploadFileDialog';
		var title = '上传';
		var width = '400',height='175';
		var dialog = $.ligerDialog.open({
			 target: $("#uploadDiv"),
			 title:title,
			 width:width,
			 height:height,
		 	 buttons:[
		 	          { text: '关闭', onclick: function (item, dialog) {dialog.hide();}},
		 	          { text: '上传',  onclick: function (item, dialog) {
						//发起上传
						dialog.hide();
						var fjName = $("#fjName").val();
						data.fjName = fjName;
						PJ.showLoading("上传中...");
						$.ajaxFileUpload({
							url:basePath + "/fj/upload",
							secureuri:false,
							dataType:'text',
							fileElementId:"uploadFile",
							type:"post",
							data:data,
							success:function(result,status){
								 PJ.hideLoading();
								 $("#uploadDiv input").each(function(){
									 $(this).val("");
								 });
								 var json = eval("("+result+")");
								 if(callback)
									 callback(json);
						},
						error:function(data,status,e){
							PJ.hideLoading();
							dialog.show();
							PJ.error(status);
							return 'fail';
						}
					});
				}}
		 	 ]
		 });
	}
	
	//选择案件
	PJ.selectCase = function(id,callback,options){
		options = options || {};
		if(id){
			$(id).click(function(){
				selectCaseFn(callback,options);
			});
		}else{
			selectCaseFn(callback,options);
		}
	}
	
	//选择案件的方法
	function selectCaseFn(callback,options){
		var iframeId = "selectCaseDialog";
		var title = options.title || "选择案件";
		var url = options.url || basePath + "/aj/ajlist";
		var width = options.width || "800";
		var height = options.height || "450";
		PJ.openTopDialog(iframeId, title, url, {
			save:function(item,dialog){
				var flag = PJ.iframeValidate(iframeId);
				if(flag){
					 var ret = PJ.iframeGetFormData(iframeId);
					 dialog.close();
					 callback(ret);
				}else{
					top.PJ.warn("请选择记录");
				}
			},
			cancle:function(item,dialog){
				dialog.close();
			},
			width:width,
			height:height,
			saveTitle:"选择"
		});
	};
	
	//生成打开tab页的链接
	PJ.addTabLink = function(tabName,title,url,color){
		if(!color)color = "#8A8C8D";
		return "<a href=\"javascript:top.f_addTab('"+tabName+"','"+tabName+"','"+url+"');\" style='color:"+color+"'>"+title+"</a>";
	};
	
	// 校验
	PJ.iframeValidateReloadTree = function(iframeId,tree) {
		if (PJ.inIframe()) {
			return top.PJ.iframeValidateReloadTree(iframeId,tree);
		}
		return window.frames[iframeId].validate(tree);
	};
	
	//初始化下拉框
	PJ.initSelect = function(id,url,callback){
		PJ.ajax({
			url:url,
			success:function(data){
				for ( var i in data) {
					$("#" + id).append("<option value='"+data[i].value+"'>"+data[i].text+"</option>")
				}
				if(callback){
					callback();
				}
			}
		});
	};
})(jQuery);

// *************** 字符串工具 ***************
// 去字符串空格
String.prototype.trim = function() {
	return this.replace(/(^\s*)|(\s*$)/g, "");
};
// 去字符串左空格
String.prototype.ltrim = function() {
	return this.replace(/(^\s*)/g, "");
};
// 去字符串右空格
String.prototype.rtrim = function() {
	return this.replace(/(\s*$)/g, "");
};
// 判断字符串是否以指定字符结束
String.prototype.endWith = function(str) {
	if (str == null || str == "" || this.length == 0
			|| str.length > this.length)
		return false;
	if (this.substring(this.length - str.length) == str)
		return true;
	else
		return false;
	return true;
};
// 判断字符串是否以指定字符开始
String.prototype.startWith = function(str) {
	if (str == null || str == "" || this.length == 0
			|| str.length > this.length)
		return false;
	if (this.substr(0, str.length) == str)
		return true;
	else
		return false;
	return true;
};

// *************** Map ***************
function Map() {
	this.container = new Object();
}
Map.prototype.put = function(key, value) {
	this.container[key] = value;
};
Map.prototype.get = function(key) {
	return this.container[key];
};
Map.prototype.keySet = function() {
	var keyset = new Array();
	var count = 0;
	for ( var key in this.container) {
		// 跳过object的extend函数
		if (key == 'extend') {
			continue;
		}
		keyset[count] = key;
		count++;
	}
	return keyset;
};
Map.prototype.size = function() {
	var count = 0;
	for ( var key in this.container) {
		// 跳过object的extend函数
		if (key == 'extend') {
			continue;
		}
		count++;
	}
	return count;
};
Map.prototype.remove = function(key) {
	delete this.container[key];
};
Map.prototype.toString = function() {
	var str = "";
	for (var i = 0, keys = this.keySet(), len = keys.length; i < len; i++) {
		str = str + keys[i] + "=" + this.container[keys[i]] + ";\n";
	}
	return str;
};

function getRuleString(name,oper,value,date){
	var o = {eq:'=',lt:'<=',gt:'>=',cn:'like',sqlin:'in',rcn:'like'};
	if(value && value.indexOf("选择")==-1 && value.indexOf("数据加载")==-1){
		if(date){
			name = "to_char("+name+",'yyyy-mm-dd')";
		}
		if(oper=="cn"){
			value = "%"+value+"%";
		}
		if(oper=="rcn"){
			value = value+"%";
		}
		if(oper=="sqlin"){
			value = value.trim();
			var words = value.split(',');
			var v = '';
			for(var i=0;i<words.length;i++){
				v+="'"+words[i]+"',";
			}
			value = "("+v.substr(0,v.length-1)+")";
			return name+" "+o[oper]+" "+value+"";
		}
		return name+" "+o[oper]+" '"+value+"'";
	}else
		return "";
}

//检查,用于查询条件
function checkRule(elem){
	var date = elem.getAttribute("elemType"),
	oper = "",
	isDate = true;
	result = true;
	if(date){
		var lt = elem.getAttribute("lt"),
			gt = elem.getAttribute("gt");
		if(elem.value){
			var reg = /^\d{4}\-\d{1,2}\-\d{1,2}$/;
			if(!reg.test(elem.value)){
				PJ.warn("请输入正确的日期格式!(如：2010-12-12)");
				result = false;
			}else{
				var name = lt || gt,
					target = $("#fields input[name="+name+"]"),
					tValue = target.val();
				oper = lt?"gt":"lt";
				if(tValue && reg.test(tValue)){
					if(lt){
						if(Date.parse(elem.value)>Date.parse(tValue)){
							PJ.warn("开始日期不能大于结束日期!");
							result = false;
						}
					}else{
						if(Date.parse(elem.value)<Date.parse(tValue)){
							PJ.warn("结束日期不能小于开始日期!");
							result = false;
						}
					}
				}
			}
		}
	}else{
		isDate = false;
		var op = elem.getAttribute("oper");
		if(!!op){
			oper = op;
		}else{
			oper = 'eq';
		}
	}
	return [result,oper,isDate];
}

//审批状态格式化
function spztFormatter(cellvalue, options, rowObject){
	switch (cellvalue) {
	case '0': 
		return "登记";
		break;
	case '1': 
		return "审核中";
		break;
	case '2': 
		return "不通过";
		break;
	case '3': 
		return "审核通过";
		break;
	default: 
		return cellvalue;
		break; 
	}
}

function validSuccess(element){
	var elem = $(element); 
	elem.poshytip('disable'); 
	elem.poshytip('destroy'); 
}

function errorPlacement(error, element){
	var elem = $(element); 
	if (!error.is(':empty')) {
		var aX = "center"; 
		if (elem.attr("positionX") != null) { 
			aX = elem.attr("positionX"); 
		} 
		var aY = "bottom"; 
		if (elem.attr("positionY") != null) { 
			aY = elem.attr("positionY"); 
		} 
		elem.filter('.error').poshytip({
			className: 'tip-yellowsimple',
			content: error, 
			alignTo: 'target', 
			alignX: aX, 
			alignY: aY, 
			offsetX: 0, 
			offsetY: 5 
		}); 
	} else { 
		elem.poshytip('disable'); 
		elem.poshytip('destroy'); 
	} 
	
}