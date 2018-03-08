<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page import="com.opensymphony.xwork2.ActionContext"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<script type="text/javascript" src="<%=path%>/js/jquery.min.js"></script>
		<script type="text/javascript" src="<%=path%>/js/banner.js"></script>
		<title>代运物流后台管理系统</title>
		<link rel="stylesheet" type="text/css" href="<%=path%>/style/login.css" />
	</head>
	<body>
		<form action="LoginManageAction" method="post">

			<div id="login_system">
				<div class="login_box">
					<div class="login">
						<ul>
							<s:fielderror fieldName="password" style="color:red" theme="" />
							<s:fielderror fieldName="username" style="color:red" theme="" />
							<li>

								<span>账&nbsp;&nbsp;号：</span>

								<input name="username" type="text" />
								<span id="msg"></span>
								<br />
							</li>
							<li>
								<span>密&nbsp;&nbsp;码：</span>
								<input name="password" type="password" />
							</li>
						</ul>
						<button class="login_button" type="submit"
							onclick=
	GotoSerachPage();
></button>
					</div>
				</div>
			</div>
		</form>
	</body>
</html>