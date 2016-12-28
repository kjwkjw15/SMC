<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<body>
	<s:form id="frm_win" action="addBaseInfo">
	<div style="padding:10px 10px 10px 10px">  
			<table class="easyui-panel" title="请添加学员基本信息 " >		
				<tr>
	    			<td style="width:130px"><span class="form_title" >姓名:</span></td>
	    			<td style="width:350px"><input id="baseInfo.name" name="baseInfo.name" class="easyui-textbox" style="width:200px" data-options="prompt:'输入姓名',required:true"></td>
	    			<td style="width:130px"><span class="form_title" >身份证:</span></td>
	    			<td style="width:350px"><input id="baseInfo.idCard" name="baseInfo.idCard" class="easyui-validatebox" style="width:200px" data-options="validType:'idcard',prompt:'输入身份证号',required:true" style="width:200px"></td>
	    		</tr>
	    		<tr>
	    			<td style="width:130px"><span class="form_title" >年月:</span></td>
	    			<td style="width:350px"><input id="baseInfo.birthdate" name="baseInfo.birthdate" class="easyui-textbox" readonly="readonly" style="width:200px"></td>
	    			<td style="width:130px"><span class="form_title" >年龄:</span></td>
	    			<td style="width:350px"><input id="baseInfo.age" name="baseInfo.age" readonly="readonly" class="easyui-textbox" style="width:200px" data-options=""></td>
	    		</tr>
	    		<tr>
	    			<td style="width:130px"><span class="form_title" >性别:</span>	</td>
	    			<td style="width:350px"> <input type="radio" id="baseInfo.sex1" name="baseInfo.sex" value="1" >男
                							 <input type="radio" id="baseInfo.sex2" name="baseInfo.sex" value="0" >女</td>
	    			<td style="width:130px"><span class="form_title" >单位:</span></td>
	    			<td style="width:350px"><input id="baseInfo.companyName" name="baseInfo.companyName" class="easyui-textbox" style="width:200px" data-options=""></td>
	    		</tr>
	    		<tr>
	    			<td style="width:130px"><span class="form_title" >电话:</span>	</td>
	    			<td style="width:350px"><input id="baseInfo.phone" name="baseInfo.phone" class="easyui-textbox" style="width:200px" data-options="prompt:'输入手机号',validType:'number'">
	    			</td>
	    		</tr>
	    	</table>
	    	
	    	<div style="text-align:center">
	    		 <a id="btnSave_Infor" class="easyui-linkbutton" onclick="addBaseInfo()">提交</a>
	    	</div>
	    </div>
	</s:form>

	<s:form>
		<div>
	    	<table class="easyui-panel" title="请添加学员报名信息 " style="height:314px">		
				<tr>
					<td style="width:130px"><span class="form_title" >一级工种:</span></td>
					<td>
	    			<select style="width:150px" class="easyui-combobox"  >
							<option value="100309">电工</option>
							<option value="100310">焊工</option>
					</select>
					</td>
					<td style="width:130px"><span class="form_title" >二级工种:</span></td>
					<td>
	    			<select style="width:150px" class="easyui-combobox"  >
							<option value="100310">复训</option>
							<option value="100312">初训</option>
					</select>
					</td>
	    		</tr>
	    		<tr>
					<td ><span class="form_title" >缴费情况:</span></td>
					<td>
	    			<select style="width:150px"  class="easyui-combobox"  >
							<option value="1">是</option>
							<option value="0">否</option>
					</select>
					</td>
						<td ><span class="form_title" >资料是否齐全:</span></td>
					<td>
	    			<select style="width:150px"  class="easyui-combobox"  >
							<option value="1">是</option>
							<option value="0">否</option>
					</select>
					</td>
	    		</tr>
	    		<tr>
	    			<td style="width:130px"><span class="form_title" >入班情况:</span></td>
	    			<td style="width:350px"><input id="" value="" class="easyui-textbox" data-options="multiline:true" style="width:200px;height:100px"></td>
	    		</tr>
	    	</table>


</div>
</s:form>
<script>
	$('#baseInfo\\.idCard').change(function(){
			var idcard=$("#baseInfo\\.idCard").val();
		 	if (idcard.length==18){
		 		sex=idcard.substring(16,17)%2;//1:male 0:female

		 		if(sex!=0){
		 			$("#baseInfo\\.sex1").prop("checked",true);		 			
		 		}
		 		else if(sex==0){
		 			$("#baseInfo\\.sex2").prop("checked",true);
		 		}
		 		
				var birthdate=idcard.substring(6,14);
			 	var age=new Date().getFullYear() - birthdate.substring(0,4);
			 	$('#baseInfo\\.birthdate').textbox('setValue',birthdate);
			 	$('#baseInfo\\.age').textbox('setValue',age);
			 	
		 	}else if(idcard.length==15){
		 		sex=idcard.substring(13,14)%2;//1:male 0:female
		 		
		 		if(sex!=0){
		 			$("#baseInfo\\.sex1").prop("checked",true);		 			
		 		}
		 		else{
		 			$("#baseInfo\\.sex2").prop("checked",true);
		 		}
				var birthdate="19".concat(idcard.substring(6,12));
			 	var age=new Date().getFullYear() - birthdate.substring(0,4);
			 	$('#baseInfo\\.birthdate').textbox('setValue',birthdate);
			 	$('#baseInfo\\.age').textbox('setValue',age);
		 	}
	})
	$.extend($.fn.validatebox.defaults.rules, {
	    idcard: {
			validator: function(value){
				return /^\d{15}(\d{2}[A-Za-z0-9])?$/i.test(value);
			},
			message: 'Wrong idCard'
    }
	});

	function addBaseInfo(){
		if(!$("#frm_win").form("validate")) {
				alert("请根据提示输入正确的信息！");
				return;
			}	
		$.ajax({
			url:'m1/addBaseInfo',
			type: 'POST',
			data: $(document.frm_win).serialize(),
			 success: function(data){
				   		alert('操作成功！');
				   },
				   error: function(){
				   		alert('操作失败！');
				   }
		})
	}
</script>
</body>
