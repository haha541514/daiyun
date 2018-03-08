<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>代运物流</title>
		<style type="text/css">
		<!--
		.STYLE1 {
			color: #1C445B;
			font-size: 13px;
			font-weight: bold;
			margin-right:330px;			
		}
		-->
		</style>
		<script type="text/javascript">
			function goToIndex(){
				window.location.href ="${pageContext.request.contextPath}/index.jsp"; 
			}
		</script>
	</head>

	<body leftmargin="0" topmargin="0">
		<s:set var="message" value="#session.MESSAGEBEAN"></s:set>
		<TABLE cellSpacing=0 cellPadding=0 width=405 height="201" align=center border=0
			background="../images/msgBox.jpg" style="margin-top:80px;">
			<TBODY>
				<TR>
					<TD vAlign=middle>
						<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0 height="100%">
							<TBODY>
								<TR>
									<TD valign="top" align="right" width="62%" style="padding-top:5px;padding-right:12px;">
										<span class="STYLE1">提示</span>
										<span><a style="text-decoration: none;" href="javascript:history.back(-1);">&nbsp;&nbsp;</a></span>
									</TD>
								</TR>
								<tr>
									<td height="100" align="center">
										<table width="100%" border=0>
											<tr><td>&nbsp;</td></tr>
											<tr>
												<td>&nbsp;&nbsp;&nbsp;&nbsp;
													<font color="#3284BE">错误提示：</font>
													<font color="#FF0000"><s:property
															value="#message.strTitle" /> </font>
												</td>
											</tr>
											<tr><td>&nbsp;</td></tr>
											<tr>
												<td>&nbsp;&nbsp;&nbsp;&nbsp;
													<font color="#3284BE">错误信息：</font>
													<font color="#FF0000"><s:property
															value="#message.strMessage" /> </font>
												</td>
											</tr>
											<tr><td>&nbsp;</td></tr>
											<tr>
												<td align="center">
													<input type="button" value="关闭"
														onClick="javascript:window.close();">
													&nbsp;&nbsp;
													<input type="submit" value="返回"
														onClick="javascript:history.back(-1)">
												</td>
											</tr>
											<tr><td>&nbsp;</td></tr>
											
										</table>
									</td>
								</tr>
							</TBODY>
						</TABLE>
					</TD>
				</TR>
			</TBODY>
		</TABLE>
		<%
			session.removeAttribute("MESSAGEBEAN");
		%>
	</body>
</html>
