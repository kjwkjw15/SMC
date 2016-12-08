<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>电信网络防诈骗系统</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<link rel="stylesheet" type="text/css" href="../res/jquery-easyui-1.4.2/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="../res/jquery-easyui-1.4.2/themes/icon.css">
	<script type="text/javascript" src="../res/jquery-easyui-1.4.2/jquery.min.js"></script>
	<script type="text/javascript" src="../res/jquery-easyui-1.4.2/jquery.easyui.min.js"></script>
  </head>
  
  <body>
    <div style="margin:5px 0;"></div>
	<div class="easyui-layout" style="width:1350px;height:630px;">
		<div data-options="region:'north'" style="height:75px">
			<jsp:include page="../mt/layout_top.jsp" />
		</div>
		<div data-options="region:'south'" style="height:50px;">
			<jsp:include page="../mt/layout_bottom.jsp" />
		</div>
		<div data-options="region:'west',title:'系统菜单'" style="width:200px;">
			<jsp:include page="../mt/layout_left.jsp" />
		</div>
		<div data-options="region:'center',title:'账户涉案/可疑名单验证'">
			<!-- 考虑此处通过Get方式变量传入每个页面真实的jsp，则可以实现一个框架页调用各个jsp，但暂未处理，而各个jsp当中实现当前框架代码 -->
		</div>
	</div>
  </body>
</html>
