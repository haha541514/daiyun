<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head></head>
<body>
<div style="width: 800px;">
	<div class="admin_table" style="OVERFLOW-y: auto; OVERFLOW-x: auto; WIDTH: 760px; HEIGHT: 250px;">
		<table id="selectBulletinTable" width="900px" border="0" cellpadding="0" cellspacing="1"  bgcolor="#d5d5d5" class="manage_form"  >
			
				<tr class="manage_form_bk4">
					<td width="8%"  style="text-align:center;">选择</td>
					<td width="25%" align="center">公告标题</td>
					<td width="10%" align="center">公告ID</td>
					<td width="15%" align="center">公告类型</td>
					<td width="20%" align="center">发布时间</td>
					<td width="15%" align="center">创建者</td>
					<td width="15%" align="center">公告级别</td>
				</tr>
			<%int i = 0; %>
			<s:iterator var="bulletinBean" value="#request.bulletinList">
			
			<% i++;if(i%2==0){%>
				<tr  class="manage_form_bk">
				<%}else{%>
				<tr class="manage_form_bk2">
				<%}%>
					<td height="16px" style="text-align:center;">
						<input type="radio" name="blId" value="<s:property  value="#bulletinBean.Blblid"/>" />
					</td>
					<td align="left">
						<s:property  value="#bulletinBean.Blblheading"/>
					</td>
					<td align="left">
						<s:property value="#bulletinBean.Blblid"/>
					</td>
					<td align="left">
						<s:property value="#bulletinBean.Bkbkname"/>
					</td>
					<td align="left"><s:property  value="#bulletinBean.Blblcreatedate"/></td>
					<td align="left">
						<s:if test="#bulletinBean.Copopid.equals('0')">
							XS000
						</s:if>
						<s:else>
							other
						</s:else>
					</td>
					<td align="left">
						<s:property value="#bulletinBean.Bllblname"/>
					</td>
				</tr>
				</s:iterator>
				<s:set var="beans" value="#request.bulletinList" />
					<s:if test="#beans==null">	
						<tr class="manage_form_bk">
							<td colspan="7" align="left"><h3>对不起,没有查询到对应条件的记录!</h3></td>
						</tr>
					</s:if>
					<s:else>
						<s:if test="#beans.size()==0">
						<tr class="manage_form_bk">
							<td colspan="7" align="left"><h3>对不起,没有查询到对应条件的记录!</h3></td>
						</tr>
						</s:if>
					</s:else>	
		</table>
     </div>
</div>
</body>
</html>
