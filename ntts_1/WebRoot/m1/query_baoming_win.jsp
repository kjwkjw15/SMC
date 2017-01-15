<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<body>
	<s:form id="frm_win" class="easyui-form" method="post" data-options="novalidate:true">
	<div style="padding:10px 10px 10px 10px">  
			<table class="easyui-panel" title="学员基本信息修改 " >		
				<tr>
	    			<td style="width:130px"><span class="form_title" >姓名:</span></td>
	    			<td style="width:350px"><input id="baseInfo.name" name="baseInfo.name" class="easyui-textbox" style="width:200px" readonly="readonly"></td>
	    			<td style="width:130px"><span class="form_title" >身份证:</span></td>
	    			<td style="width:350px"><input id="baseInfo.idCard" name="baseInfo.idCard" class="easyui-textbox" style="width:200px" readonly="readonly"></td>
	    		</tr>
	    		<tr>
	    			<td style="width:130px"><span class="form_title" >年月:</span></td>
	    			<td style="width:350px"><input id="baseInfo.birthdate" name="baseInfo.birthdate" class="easyui-textbox" readonly="readonly" style="width:200px"></td>
	    			<td style="width:130px"><span class="form_title" >年龄:</span></td>
	    			<td style="width:350px"><input id="baseInfo.age" name="baseInfo.age" readonly="readonly" class="easyui-textbox" style="width:200px" data-options=""></td>
	    		</tr>
	    		<tr>
	    			<td style="width:130px"><span class="form_title" >性别:</span>	</td>
	    			<td style="width:350px"> <select class="easyui-combobox" id="baseInfo.sex" name="baseInfo.sex" style="width:200px" readonly="readonly" >
	    										<option value="1">男</option>
	    										<option value="0">女</option>
	    									</select>
                							
	    			<td style="width:130px"><span class="form_title" >单位:</span></td>
	    			<td style="width:350px"><input id="baseInfo.companyName" name="baseInfo.companyName" class="easyui-textbox" style="width:200px" data-options="">
	    			<span style="color:red">*</span>
	    			</td>
	    		</tr>
	    		<tr>
	    			<td style="width:130px"><span class="form_title" >电话:</span>	</td>
	    			<td style="width:350px"><input id="baseInfo.phone" name="baseInfo.phone"  class="easyui-textbox" style="width:200px" data-options="prompt:'输入手机号',validType:'number'">
	    			<span style="color:red">*</span>
	    			</td>
	    		</tr>
	    	</table>
	    	
	    	<div style="text-align:center">
	    		 <a id="btnUpdate_Infor" class="easyui-linkbutton" onclick="submit2Server(this, '确认修改吗？','m1/updateBaseInfo')">修改</a>
	    	</div>
	    </div>
	<!-- 报名 -->
	
	<br/>	
		 
	   	<table id="datagridBaoming" class="easyui-datagrid" title="报名情况修改" style="width:850px;height:125px"
			data-options="iconCls: 'icon-edit',singleSelect:true,toolbar: 'datagridTransactionToolbar',onClickRow: onClickRowTransaction,method:'get'">
			<thead>
				<tr>
					<th data-options="field:'firstKind',editor:{type:'validatebox',options:{required:false,validType:'length[0,50]'}},width:100,align:'center'">一级工种</th>															
					<th data-options="field:'secondKind',editor:{type:'validatebox',options:{required:true,precision:2,validType:'length[1,20]'}}">二级工种</th>
					<th data-options="field:'whetherPay',editor:{type:'validatebox',options:{required:true,precision:2,validType:'length[1,20]'}}">缴费情况</th>
					<th data-options="field:'whetherInformation',editor:{type:'validatebox',options:{required:true}},width:175,align:'center'">资料是否齐全</th>
					<th data-options="field:'classInfo',editor:{type:'validatebox',options:{required:true,validType:'length[1,50]'}},width:125,align:'center'">入班情况</th>
			
				</tr>
			</thead>
		</table>
	<script type="text/javascript">
		var idCard = '<%= request.getParameter("idCard")%>';	
		function submit2Server(btn, strConfirm, actionName) {
			if(!$("#frm_win").form("validate")) {
				alert("请根据提示输入正确的信息！");
				return;
			}			
			
			if(window.confirm(strConfirm)){
			
				if(actionName.indexOf("save")>=0 || actionName.indexOf("submit")>=0 || actionName.indexOf("auditApprove")>=0) {	//保存或提交，需要处理datagrid中的数据存储
					//明细内容检查
// 					var bln = validateEachRow("datagridTransaction");
// 					if(!bln) {
// 						alert("当前行数据输入不合法，请重新输入！");
// 						return;
// 					}					
					
// 					var rowsDataTransaction = $('#datagridTransaction').datagrid('getRows');
// 					var jsonTransaction =JSON.stringify(rowsDataTransaction);
// 					$("#hiddenDatagridTransaction").val(jsonTransaction);
					//alert($("#hiddenDatagridTransaction").val());
				}
				//$("#"+btn.id).linkbutton('disable');
				$.ajax({
				   url: actionName+'?idCard='+idCard,
				   type: 'POST',
				   data: $(document.frm_win).serialize(),
				   success: function(data){
				   		alert('修改成功！');
						//query();
				   },
				   error: function(){
				   		alert('操作失败！');
				   }
				});
			}
		}	
		function showDetail(datagridID) {
			var actionName= "m1/queryBaomingJsonArray";
			$.ajax({
				type: "post",
				url: actionName+"?idCard="+idCard,
				dataType: "json",
				success: function(jsonObject) {
					var datagrid = $("#"+datagridID);
					datagrid.datagrid('loadData', jsonObject);
				}
			})
		}

		/*************************** JQuery之ready方法无效，故直接调用 ***********************/
				
		initWinFields('m1/queryBaseInfoJsonObject?idCard='+idCard+'&timestamp='+new Date().getTime(), 'baseInfo');		
// 		if(tsn_refer != null) {

 			showDetail('datagridBaoming');
// 		}	
		
		/*************************** easyui-datagrid之onclickrow参数固定，所以需要如下特别处理  ***********************/
		
		function onClickRowTransaction(index) {
			onClickRow('datagridBaoming', index);
		}
			
	</script>

</s:form>
</body>
