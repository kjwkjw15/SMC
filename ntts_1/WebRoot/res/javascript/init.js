var WIN_URL_TYPE_VIEW = "0";
var WIN_URL_TYPE_OPER = "1";
var WIN_URL_TYPE_AUDIT = "2";


function initWinBtns(type) {
	if(type == WIN_URL_TYPE_OPER) {
		$('#btnSave').show();
		$('#btnDelete').show();
		$('#btnSubmit').show();
		$('#btnAuditApprove').hide();
		$('#btnAuditReject').hide();
	}
	else if(type == WIN_URL_TYPE_AUDIT) {
		$('#btnSave').hide();
		$('#btnDelete').hide();
		$('#btnSubmit').hide();
		$('#btnAuditApprove').show();
		$('#btnAuditReject').show();
	}
	else {	//WIN_URL_TYPE_VIEW
		$('#btnSave').hide();
		$('#btnDelete').hide();
		$('#btnSubmit').hide();
		$('#btnAuditApprove').hide();
		$('#btnAuditReject').hide();
	}
}


function initQuery() {
	var d = new Date();
	$('#dateStart').val(d);
	$('#dateEnd').val(d);
}


function initWinFields(actionAndQuery, keyPrefix) {
	jQuery.ajax({  
        type: "GET",  
        url: actionAndQuery,
        dataType: "json",  
        global: false,   
        success: function(data){
        	$.each(data, function(key, value) {
        		if(typeof(value) == "object" && Object.prototype.toString.call(value).toLowerCase() == "[object object]" && !value.length) {	//判断元素本身是否为JSON（不确定是否严谨）
        			$.each(value, function(subKey, subValue) {
        				
        				initEasyuiValue(key, subKey, subValue);
        			})
        		}
        		else {
        			initEasyuiValue(keyPrefix, key, value);
        		}
        	})
        	
        	
        },
        error: function(){
		   		alert('获取数据失败！');
		}
	});
}

function initEasyuiValue(keyPrefix, key, value) {
    if(keyPrefix != null)
    	key = keyPrefix+"\\."+key;

	var frmField = $("#"+key);
	if(frmField.length > 0) {
		try {
			if(frmField.attr("class").indexOf("easyui-textbox") == 0)
				frmField.textbox('setValue', value);
			else if(frmField.attr("class").indexOf("easyui-combobox") == 0)
				frmField.combobox('setValue', value);
			else if(frmField.attr("class").indexOf("easyui-numberbox") == 0)
				frmField.numberbox('setValue', value);
			else if(frmField.attr("class").indexOf("easyui-datetimebox") == 0)
				frmField.datetimebox('setValue', value);
			else if(frmField.attr("class").indexOf("easyui-datebox") == 0)
				frmField.datebox('setValue', value);			
			//补齐其他类型 
		}
		catch (e) {
		}
	}
}