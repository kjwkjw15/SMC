<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<body>
	<s:form id="frm_win" action="addBaseInfo">
	<div style="padding:10px 10px 10px 10px">  
			<table class="easyui-panel" title="请添加学员基本信息 " >		
				<tr>
	    			<td style="width:130px"><span class="form_title" >姓名:</span></td>
	    			<td style="width:350px"><input id="name" name="baseInfo.name" class="easyui-textbox" style="width:200px" data-options="prompt:'输入姓名',required:true"></td>
	    			<td style="width:130px"><span class="form_title" >身份证:</span></td>
	    			<td style="width:350px"><input id="iCard" name="baseInfo.iCard" onchange="fuck()" class="easyui-validatebox textbox" style="width:200px" data-options="validType:'',prompt:'输入身份证号',required:true" style="width:200px"></td>
	    		</tr>
	    		<tr>
	    			<td style="width:130px"><span class="form_title" >年月:</span></td>
	    			<td style="width:350px"><input id="birthdate" name="baseInfo.birthdate" class="easyui-textbox" readonly="readonly" style="width:200px"></td>
	    			<td style="width:130px"><span class="form_title" >年龄:</span></td>
	    			<td style="width:350px"><input id="age" name="baseInfo.age" readonly="readonly" class="easyui-textbox" style="width:200px" data-options=""></td>
	    		</tr>
	    		<tr>
	    			<td style="width:130px"><span class="form_title" >性别:</span>	</td>
	    			<td style="width:350px"> <input type="radio" id="sex1" name="baseInfo.sex" value="0" checked>男
                							 <input type="radio" id="sex2" name="baseInfo.sex" value="1">女</td>
	    			<td style="width:130px"><span class="form_title" >单位:</span></td>
	    			<td style="width:350px"><input id="companyName" name="baseInfo.companyName" class="easyui-textbox" style="width:200px" data-options=""></td>
	    		</tr>
	    		<tr>
	    			<td style="width:130px"><span class="form_title" >电话:</span>	</td>
	    			<td style="width:350px"><input id="phone" name="baseInfo.phone" class="easyui-textbox" style="width:200px" data-options="prompt:'输入手机号',validType:'number'">
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
							<option value="">是</option>
							<option value="">否</option>
					</select>
					</td>
						<td ><span class="form_title" >资料是否齐全:</span></td>
					<td>
	    			<select style="width:150px"  class="easyui-combobox"  >
							<option value="">是</option>
							<option value="">否</option>
					</select>
					</td>
	    		</tr>
	    		<tr>
	    			<td style="width:130px"><span class="form_title" >入班情况:</span></td>
	    			<td style="width:350px"><input id="" value="" class="easyui-textbox" data-options="multiline:true" style="width:200px;height:100px"></td>
	    		</tr>
	    	</table>

<script>
/* $.extend($.fn.validatebox.defaults.rules, {
            idcard: {// 验证身份证
                validator: function (value) {
                    return /^\d{15}(\d{2}[A-Za-z0-9])?$/i.test(value);
                    
                    
                },
                message: '身份证号码格式不正确'
 }
})       */
</script>

</div>
</s:form>
<script type="text/javascript">
	function addBaseInfo(){
		$.ajax({
			url:'addBaseInfo',
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
