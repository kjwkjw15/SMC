<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
	<s:form id="frm_win" >
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
	    			<td style="width:350px" colspan="3"><input id="baseInfo.phone" name="baseInfo.phone" class="easyui-textbox" style="width:200px" data-options="prompt:'输入手机号',validType:'number'">
	    			</td>
	    		</tr>
	    	</table>
	    	
	    </div>
	    
	    <!-- 报名信息 -->
		<div>
	    	<table class="easyui-panel" title="请添加学员报名信息 " style="height:280px">		
				<tr>
					<td style="width:130px"><span class="form_title" >一级工种:</span></td>
					<td>
	    			<select style="width:150px" id="baomingInfo.firstKind" name="baomingInfo.firstKind" class="easyui-combobox" data-options="editable:false" >
							<option value="100309">电工</option>
							<option value="100310">焊工</option>
					</select>
					</td>
					<td style="width:130px"><span class="form_title" >二级工种:</span></td>
					<td>
	    			<select style="width:150px" id="baomingInfo.secondKind" name="baomingInfo.secondKind" class="easyui-combobox" data-options="editable:false" >
							<option value="100310">初训</option>
							<option value="100312">复训</option>
					</select>
					</td>
	    		</tr>
	    		<tr>
					<td ><span class="form_title" >缴费情况:</span></td>
					<td>
	    			<select style="width:150px" id="baomingInfo.whetherPay" name="baomingInfo.whetherPay"  class="easyui-combobox" data-options="editable:false" >
							<option value="1">是</option>
							<option value="0">否</option>
					</select>
					</td>
						<td ><span class="form_title" >资料是否齐全:</span></td>
					<td>
	    			<select style="width:150px" id="baomingInfo.whetherInformation" name="baomingInfo.whetherInformation"  class="easyui-combobox"  data-options="editable:false">
							<option value="1">是</option>
							<option value="0">否</option>
					</select>
					</td>
	    		</tr>
	    		<tr>
	    			<td style="width:130px"><span class="form_title" >入班情况:</span></td>
	    			<td style="width:350px" colspan="3"><input id="baomingInfo.remarkInfo" name="baomingInfo.remarkInfo" class="easyui-textbox" data-options="multiline:true" style="width:200px;height:100px"></td>
	    		</tr>
	    	</table>
		</div>
	    <div style="text-align:center">
	   	    	<a href="#" id="btnSubmit" class="easyui-linkbutton" onclick="submit2Server(this, '确认提交吗？','m1/submitBaseInfo')" style="color:blue">提交</a>
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
	function submit2Server(btn, strConfirm, actionName) {		 
			if(!$("#frm_win").form("validate")) {
				alert("请根据提示输入正确的信息！");
				return;
			}	
			if(window.confirm(strConfirm)){			
				if(actionName.indexOf("submit")>=0 ) {	//保存或提交，需要处理datagrid中的数据存储 目前没有
					
				}
				//$("#"+btn.id).linkbutton('disable');
				var idCard=$("#baseInfo\\.idCard").val();
				$.ajax({
				   url: actionName+'?idCard='+idCard,
				   type: 'POST',
				   data: $(document.frm_win).serialize(),
				   success: function(data){
				   		alert('操作成功！');
				   		$("#frm_win")[0].reset();
				   },
				   error: function(){
				   		alert('操作失败！');
				   }
				});
				
			}
		}	

</script>
