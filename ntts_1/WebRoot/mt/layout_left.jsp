<%@ page pageEncoding="UTF-8"%>

<div class="easyui-panel" style="padding:5px">
	<ul class="easyui-tree">
		<li>
			<span>学员管理</span>
			<ul>
				<li>
					<a href="loginSuccess.jsp?menuID=100101">学员录入</a>
				</li>
				<li>
					<a href="loginSuccess.jsp?menuID=100102">查看学员</a>
				</li>
				<li>
					<a href="loginSuccess.jsp?menuID=100103">管理学员</a>
				</li>
			</ul>
		</li>
		<li>
			<span>班级管理</span>
			<ul>
				<li>
					<a href="index.jsp?menuID=100201">组班</a>
				</li>
				<li>
					<a href="index.jsp?menuID=100202">查询班级</a>
				</li>
				<li>
					<a href="index.jsp?menuID=100203">管理班级</a>
				</li>
			</ul>
		</li>
		<li>
			<span>成绩管理</span>
			<ul>
				<li>
					<a href="index.jsp?menuID=100301">成绩录入</a>
				</li>
				<li>
					<a href="index.jsp?menuID=100302">查看成绩</a>
				</li>
				<li>
					<a href="index.jsp?menuID=100303">管理成绩</a>
				</li>
			</ul>
		</li>
		<li>
			<span>证书管理</span>
			<ul>
				<li>
					<a href="index.jsp?menuID=100401">查看证书</a>
				</li>
			</ul>
		</li>	
		<li>	<!-- 		<li data-options="state:'closed'"> -->
			<span>系统管理</span>
			<ul>
				<li>
					<a href="index.jsp?menuID=300001">用户管理</a>
				</li>
				<li>
					<a href="index.jsp?menuID=300003">日志查看</a>
				</li>
			</ul>
		</li>
	</ul>
</div>