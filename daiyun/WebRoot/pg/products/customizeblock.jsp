<%@page language="java" pageEncoding="UTF-8"%>
<%@page import="kyle.common.util.jlang.DateFormatUtility"%>
<%@page import="kyle.common.util.jlang.StringUtility"%>
<%@page import="kyle.common.util.jlang.DateUtility"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib uri = "/project" prefix="p" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>界面定制块</title>
   <link href="<%=path%>/style/page_master.css" type="text/css" rel="stylesheet" />
	</head>

<script language=JavaScript>
//checkBox的级联操作


	//全选

	var flag=false;
  	function changeCheckBox(){		
  		var cboxes=document.myform.elements;
		var cbox=document.getElementById("selectAllCheckBox");
		for(i=0;i<cboxes.length;i++){
			if(cboxes[i].Type="checkbox"){
				if(cbox.checked==true){
					cboxes[i].checked=true;
					cbox.checked=true;
					flag=true;
				}else{
					cboxes[i].checked=false;
					cbox.checked=false;
					flag=false;
				}
			}
		}
	}
	  
	//检查删除的时候，是否选中
	function checkDel(){
		var cboxes=document.myform.elements;
		var k = 0 ;
	 	for(i=0;i<cboxes.length;i++){
	 		if(cboxes[i].Type="checkbox"){
				if(cboxes[i].checked == true){
					k++;
 				}
	 		}
	 	}
	 	if(k<=0){
	 		alert("请选择您要删除的菜单");
			return false;
		}
		return true;
	}
	
	function goSubmenu(){
		var gmcode="";
		var cboxes=document.myform.elements;
		var k = 0 ;
	 	for(i=0;i<cboxes.length;i++){
	 		if(cboxes[i].Type="checkbox"){
				if(cboxes[i].checked == true){
					gmcode=cboxes[i].value;
					break;
 				}
	 		}
	 	}
		document.getElementById("myform").action="querySubmenu?gmcode="+gmcode;
		document.getElementById("myform").submit();
	}
	//判断不能为空
	function checkNONull(){
		var gmname = document.getElementById("gmname").value;
		var gmstructuercode = document.getElementById("gmstructuercode").value;
		var gmlink = document.getElementById("gmlink").value;
		if(gmname == "" || gmname.length == 0){
			alert("菜单名称不能为空");
			return false;
		}
		if(gmstructuercode == "" || gmstructuercode.length == 0){
			alert("结构代码不能为空");
			return false;
		}
		if(gmlink == "" || gmlink.length == 0){
			alert("结构代码不能为空");
			return false;
		}
		return true;
	}
	
	//保存
	function addAndUpdateGmenu(){
		if(checkNONull()){
		alert("222");
			document.getElementById("myform").action="AddAndUpdateGm?level=1";
			document.getElementById("myform").submit();
		}
	}
	//删除
	function deleteGmenu(){
		if(checkDel()){
			if(confirm("确认删除菜单？")){
				var gmcodes="";
				var cboxes=document.myform.elements;
				var k = 0 ;
			 	for(i=0;i<cboxes.length;i++){
			 		if(cboxes[i].Type="checkbox"){
						if(cboxes[i].checked == true){
							gmcodes=cboxes[i].value+","+gmcodes;
		 				}
			 		}
			 	}
			 	document.getElementById("myform").action="DeleteGm?gmcodes="+gmcodes;
				document.getElementById("myform").submit();
			}
		}
	}
	//判断是桌面系统还是网站前台

	function JudgmentS(jdS){
	   if(jdS=="LEDIS"){
	      document.getElementById("boolSystem").value="LEDIS";
	      document.getElementById("myform").action="queryFirstItem";
	      document.getElementById("myform").submit();
	   }else{
	      document.getElementById("boolSystem").value="LEWFDIS";;
	      document.getElementById("myform").action="queryFirstItem";
	      document.getElementById("myform").submit();
	   }
	}
</script>
<body>
	<form action="" method="post" name="myform" id="myform">
	<input type="hidden" id="boolSystem" name="boolSystem"/>
    <div id="admin">    
	<div id="top"><img src="<%=path%>/m_images/logo.jpg" /> <span> 您现在的位置--<a href="<%=path%>/daiyun.jsp">首页---</a><a href="#">会员中心---</a><a href="${pageContext.request.contextPath }/page/fsupport/listArticle.jsp">页面定制</a></span>
	</div>
		<div class="master">
    <jsp:include page="../bulletin/tree.jsp"></jsp:include>
    <div class="right">
	    <div class="admin_box">
			<div class="admin_rit_ads">
			    <div class="admin_ads_head">
				    <div class="admin_ads_head_lft"></div>	
				    <div class="admin_piece_rit">
						<input type="button" value="桌面系统"
								style="width:82px; height:28px; margin-left: 40px; background:url(<%=path %>/m_images/add.jpg); border:0px;" onclick="JudgmentS('LEDIS');" />
								<input type="button" value="网站前台" 
								style="width:82px; height:28px; margin-left: 20px; background:url(<%=path %>/m_images/add.jpg); border:0px; " onclick="JudgmentS('LEWFDIS');" />
							<input type="button" value="保 存"
								style="width:82px; height:28px; margin-left: 40px; background:url(<%=path %>/m_images/add.jpg); border:0px; " onclick="addAndUpdateGmenu()" />
							<input type="button" value="新增" 
								style="width:82px; height:28px; margin-left: 20px; background:url(<%=path %>/m_images/add.jpg); border:0px;" onclick="javascript:location.href='queryFirstItem'" />
							<input type="button" value="删 除"
								style="width:82px; height:28px; margin-left: 20px; background:url(<%=path %>/m_images/delete.jpg); border:0px;" onclick="deleteGmenu()" />
							<input onclick="goSubmenu();" type="button" id="submitCustom"
								value="子菜单" style="width:82px; height:28px; margin-left: 50px; background:url(<%=path %>/m_images/add.jpg); border:0px;" />
						</div>

					</div>
					
					<div class="admin_ads_check" align="center">
						<p>
							<s:set var="gmenusbean" value="#request.gmenusitem"/>
							<input type="hidden" value='<s:property value="#gmenusbean.Gmgm_code"/>' name="gmcode" />
							<table width="600" border="0" cellpadding="0" cellspacing="1">
								<tr>
									<td width="70">
										菜单名称：

									</td>
									<td width="230">
										<input type="text" value="<s:property value='#gmenusbean.Gmgm_name' />" id="gmname" name="gmname" style="width:220px;"/>
									</td>
									<td width="70">
										结构代码：

									</td>	
									<td width="230">
										<input type="text" value="<s:property value='#gmenusbean.Gmgm_structurecode' />" name="gmstructuercode" id="gmstructuercode" style="width:220px;"	/>
									</td>								
								</tr>
							</table>
						</p>							

						<p>
							<table width="600" border="0" cellpadding="0" cellspacing="1">							
								<tr>									
									<td width="70">
										菜单链接：

									</td>
									<td width="530">
										<input name="gmlink" value="<s:property value='#gmenusbean.Gmgm_link' />" type="text" id="gmlink" style="width: 520px" value="" />
									</td>
								</tr>
							</table>
						</p>
					</div>

					<div class="admin_table" style="height: 280px;">
						<table  border="0" width="761" cellpadding="0" cellspacing="1" bgcolor="#d5d5d5" class="manage_form">
							<tr class="manage_form_bk4">
								<td width="100" style="text-align: center;">
									全选

									<input type="checkbox" name="selectAllCheckBox" id="selectAllCheckBox" style="width: 20px" onclick="changeCheckBox();" />
								</td>
								<td width="190">
									菜单名称
								</td>
								<td width="350">
									菜单链接
								</td>
								<td width="110">
									结构代码
								</td>
								
							</tr >		
							<s:iterator var="bean" value="#request.fistItemList" status="menuSta">						
							<tr class="manage_form_bk2">							
							<td style="text-align: center;"><input value="<s:property value="#bean.Gmgm_code" />" type="checkbox" name="gmcode" id='gmcode' /></td>
							<td><a href="queryByGmCode?gmcode=<s:property value='#bean.Gmgm_code' />"><s:property value="#bean.Gmgm_name" /></a></td>
							<td><s:property value="#bean.Gmgm_link" /></td>
							<td><s:property value="#bean.Gmgm_structurecode" /></td>									
							</tr>
							</s:iterator>							
						</table>
					</div>
				</div>
			</div>
			<div style="clear: both"></div>
		</div>
		</div>
		</div>
	</form>
</body>
</html>
