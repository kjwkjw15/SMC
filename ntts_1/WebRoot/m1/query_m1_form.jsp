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
				    	<a href="#" class="easyui-linkbutton" onclick="add_student()">添加</a>
	    			</td>
	    		</tr>

		    </table>
	    </form>
	</div>
</div>
<br/>
<div style="padding:10px 10px 10px 20p">
   	<table id="datagrid" class="easyui-datagrid" title="学员基本信息 <a href='javascript:refreshDatagrid();'><img src='res/jquery-easyui-1.4.2/themes/icons/reload.png'/></a>" style="width:1115px;height:325px"
		data-options="singleSelect:true,pagination:true,collapsible:false,url:'m5/check_account_before.json',method:'get'">
		<thead>
			<tr>
				<th data-options="field:'name',width:150,align:'right'">姓名</th>
				<th data-options="field:'accountNumber',width:150,align:'right'">身份证</th>
				<th data-options="field:'accountName',width:100,align:'right'">出生年月</th>
				<th data-options="field:'checkDate',width:120,align:'center'">年龄</th>
				<th data-options="field:'auditDate',width:120,align:'center'">性别</th>
				<th data-options="field:'responseResult',width:100,align:'center'">单位</th>
				<th data-options="field:'responseDesc',width:120,align:'center'">电话</th>

			</tr>
		</thead>
	</table>
   </div>
<div id="win_opener" class="easyui-window" style="width:765px;height:590px;" closed="true"></div>
   		<script>
			function add_student(){
				win_href="m1/add_student_win.jsp";
				openEasyuiWin($("#win_opener"), win_href, " ");	
			}

		</script>