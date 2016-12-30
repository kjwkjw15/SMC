<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<body>
	<s:form id="frm_win" class="easyui-form" method="post" data-options="novalidate:true">
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
	    		 <a id="btnSave_Infor" class="easyui-linkbutton" onclick="addBaseInfo()">修改</a>
	    	</div>
	    </div>
	<!-- 报名 -->
	
	<br/>	
		 
	   	<table id="datagridTransaction" class="easyui-datagrid" title="报名情况" style="width:850px;height:125px"
			data-options="iconCls: 'icon-edit',singleSelect:true,toolbar: 'datagridTransactionToolbar',onClickRow: onClickRowTransaction,method:'get'">
			<thead>
				<tr>
					<th data-options="field:'transactionType',editor:{type:'validatebox',options:{required:false,validType:'length[0,50]'}},width:100,align:'center'">一级工种</th>
					
										
					<th data-options="field:'transactionAmount',editor:{type:'numberbox',options:{required:true,precision:2,validType:'length[1,20]'}}">二级工种</th>
					<th data-options="field:'accountBalance',editor:{type:'numberbox',options:{required:true,precision:2,validType:'length[1,20]'}}">缴费情况</th>
					<th data-options="field:'transactionTime',editor:{type:'datetimebox',options:{required:true}},width:175,align:'center'">资料是否齐全</th>
					<th data-options="field:'transactionSerial',editor:{type:'validatebox',options:{required:true,validType:'length[1,50]'}},width:125,align:'center'">入班情况</th>
			
				</tr>
			</thead>
		</table>
	<script type="text/javascript">
		var type = <%= request.getParameter("type")%>;
		var tsn = '<%= request.getParameter("tsn")%>';
		if(tsn == 'null')
				tsn = null;		
		var tsn_refer = '<%= request.getParameter("tsn_refer")%>';	
		function direct(datagridID) {
/* 		if(tsn == null || typeof(tsn)=="undefined" || tsn == "null" || tsn == "undefined") {
			tsn = $("#msgpkgUp\\.msgpkgTsn").val();
		}	 */	
			var filename ="SimulateDirectTransaction100306.csv";
			$.ajax({
				type: "post",
				url: "readFile2JsonArray?filename="+filename,
				dataType: "json",
				success: function(jsonObject) {
					var datagrid = $("#"+datagridID);
					datagrid.datagrid('loadData', jsonObject);
				}
			})
		}
		function submit2Server(btn, strConfirm, actionName) {
			if(!$("#frm_win").form("validate")) {
				alert("请根据提示输入正确的信息！");
				return;
			}			
			
			if(window.confirm(strConfirm)){
			
				if(actionName.indexOf("save")>=0 || actionName.indexOf("submit")>=0 || actionName.indexOf("auditApprove")>=0) {	//保存或提交，需要处理datagrid中的数据存储
					//明细内容检查
					var bln = validateEachRow("datagridTransaction");
					if(!bln) {
						alert("当前行数据输入不合法，请重新输入！");
						return;
					}					
					
					var rowsDataTransaction = $('#datagridTransaction').datagrid('getRows');
					var jsonTransaction =JSON.stringify(rowsDataTransaction);
					$("#hiddenDatagridTransaction").val(jsonTransaction);
					//alert($("#hiddenDatagridTransaction").val());
				}
				$("#"+btn.id).linkbutton('disable');
				$.ajax({
				   url: actionName+'?tsn='+tsn_refer,
				   type: 'POST',
				   data: $(document.frm_win).serialize(),
				   success: function(data){
				   		
						query();
				   },
				   error: function(){
				   		alert('操作失败！');
				   }
				});
				closeWin(false);
			}
		}	
		function closeWin(showAlert) {
			if(showAlert) {
				if(!window.confirm('确认关闭当前窗口吗？'))
					return;
			}
			
		 	$('#win_opener').window('close', true);
		 	//$(this).parent().window('close', true);
		}
		function showDetail(datagridID) {
			var actionName= "m3/queryMsgpkgUp100306TransactionJsonArray";
			$.ajax({
				type: "post",
				url: actionName+"?tsn="+tsn_refer,
				dataType: "json",
				success: function(jsonObject) {
					var datagrid = $("#"+datagridID);
					datagrid.datagrid('loadData', jsonObject);
				}
			})
		}

		/*************************** JQuery之ready方法无效，故直接调用 ***********************/
				
		initWinFields('queryMsgpkgDnJsonObject?tsn='+tsn+'&timestamp='+new Date().getTime());		
		if(tsn_refer != null) {

			showDetail('datagridTransaction');
		}	
		
		/*************************** easyui-datagrid之onclickrow参数固定，所以需要如下特别处理  ***********************/
		
		function onClickRowTransaction(index) {
			onClickRow('datagridTransaction', index);
		}
			
	</script>
</div>
</s:form>
</body>
