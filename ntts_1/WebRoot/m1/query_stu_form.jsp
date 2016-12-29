<%@ page pageEncoding="UTF-8"%>

<div class="easyui-panel" title="根据名字查询" style="width:1115px;">
	<div style="padding:10px 10px 10px 10px">
	    <form id="ff" method="post">
			<table>
	    		<tr>
	    			<th style="width:75px">
	    				<span class="form_title">姓名：</span>
	    			</th>
	    			<td style="width:350px">
	    				<input id="name" name="name" class="easyui-textbox" style="width:300px" data-options="
							prompt: '请输入姓名…'
						">
	    			</td>
	    			<td rowspan="2" style="align:center;width:300px">
				    	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()">查询</a>
				    	&nbsp;&nbsp;
				    	
	    			</td>
	    		</tr>

		    </table>
	    </form>
	</div>
</div>
<br/>
<div style="padding:10px 10px 10px 20p">
   	<table id="datagrid" class="easyui-datagrid" title="学员基本信息 <a href='javascript:refreshDatagrid();'><img src='res/jquery-easyui-1.4.2/themes/icons/reload.png'/></a>" style="width:1115px;height:325px"
		data-options="singleSelect:true,pagination:true,collapsible:false,method:'get'">
		<thead>
			<tr>
				<th data-options="field:'name',width:150,align:'right'">姓名</th>
				<th data-options="field:'idCard',width:150,align:'right'">身份证</th>
				<th data-options="field:'birthdate',width:100,align:'right'">出生年月</th>
				<th data-options="field:'age',width:120,align:'center'">年龄</th>
				<th data-options="field:'sex',width:120,align:'center'">性别</th>
				<th data-options="field:'companyName',width:100,align:'center'">单位</th>
				<th data-options="field:'phone',width:120,align:'center'">电话</th>
				<th data-options="field:'writedate',width:120,align:'center'">报名日期</th>
				<th data-options="field:'Oper1',width:66,align:'center',formatter:rowFormater">操作</th>
			</tr>
		</thead>
	</table>
   </div>
<div id="win_opener" class="easyui-window" style="width:765px;height:590px;" closed="true"></div>
<script>
	function query(){
		//var queryTxt = $("#msgpkgStatusQuery").combobox("getText");
		//var queryVal = $("#msgpkgStatusQuery").combobox("getValue");		
		//$("#datagrid").datagrid("getPanel").panel("setTitle","查询结果 ("+queryTxt+")");
		
		$("#datagrid").datagrid("options").url = "m1/query_BaseInfo_JsonArray?stamp="+new Date().getTime();
        $("#datagrid").datagrid("reload");	
		     
			}
	function rowFormater(val, row, index){  
		return '<a href="#" onclick="openWindow('+index+')">查看</a>';  
	}
	function openWindow(rowIndex) {
		$('#datagrid').datagrid('selectRow',rowIndex);
		var row = $('#datagrid').datagrid('getSelected'); 
		if (row) {
			//var type = WIN_URL_TYPE_OPER;
			//if(row.msgpkg_status != 1)
				//type = WIN_URL_TYPE_VIEW;
			
				win_href = "m2/freeze_payment_win.jsp?type=" +type+ "&tsn=" + row.msgpkg_tsn + "&tsn_refer=" + row.msgpkg_tsn_refer;
				openEasyuiWin($("#win_opener"), win_href, "详细信息");
			}
		}
		
	 	$(document).ready(function(){
		initQuery();
		setTimeout("query()", 1000);	//直接执行“query();”会导致日期控件未加载完成而出错，应该等待其加载完成再执行，但未找到对应事件故等待1秒钟后执行
	});
</script>