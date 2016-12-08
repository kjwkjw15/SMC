//获取URL中Get参数的值
function getUrlParam(name) {
	if(window.location.search.length > 0) {
		var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
		var r = window.location.search.substr(1).match(reg);  //匹配目标参数
		if(r==null)
			return null;
		else
			return r[2];	//TODO:需要unescape
	}
	else {
		return null;
	}
}

function openEasyuiWin(w_obj, w_href, w_title, w_iconCls, w_width, w_height, w_top, w_left, w_shadow, w_modal, w_minimizable, w_maximizable, w_collapsible) {
	if(!w_iconCls)
		w_iconCls = "icon-save";
	if(!w_width)
		w_width = "900px";
	if(!w_height)
		w_height = "600px";
	//不自动设置top&left，应该可以自动居中
	if(!w_shadow)
		w_shadow = true;
	if(!w_modal)
		w_modal = true;
	if(!w_minimizable)
		w_minimizable = false;
	if(!w_maximizable)
		w_maximizable = false;
	if(!w_collapsible)
		w_collapsible = false;
	
	w_obj.window({
		href: w_href,
	    title: w_title,
	    iconCls: w_iconCls,
	    width: w_width,
	    height: w_height,
	    top: w_top,
	    left: w_left,
	    shadow: w_shadow,
	    modal: w_modal,
	    minimizable: w_minimizable,
	    maximizable: w_maximizable,
	    collapsible: w_collapsible
	});

	
	w_obj.window("open");;
}


function UploadFile2JsonArray(fileObject, fileName, url, refreshDatagridID) {
	var filePostfix = fileName.substr(1+fileName.lastIndexOf('.')).toLowerCase();
	if(filePostfix != "csv") {
		alert("只能上传csv文件！");
		return;
	}
	
	var formData = new FormData();
	formData.append("file", fileObject[0].files[0]);
	formData.append("name", fileName);
	
	$.ajax({ 
		url : url, 
		type : 'POST', 
		data : formData,
		async: false,
        cache: false,
		processData : false,	// 告诉jQuery不要去处理发送的数据 
		contentType : false,	// 告诉jQuery不要去设置Content-Type请求头
		//contentType: "multipart/form-data",
		beforeSend: function(){
			console.log("正在上传文件，请稍候");
		},
		success: function(jsonObject) {
			var datagrid = $("#"+refreshDatagridID);
			datagrid.datagrid('loadData', jsonObject);
		}, 
		error: function(responseStr) { 
			console.log("错误："+responseStr);
		} 
	});

}