<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="kyle.common.util.jlang.DateFormatUtility"%>
<%@page import="kyle.common.util.jlang.StringUtility"%>
<%@page import="kyle.common.util.jlang.DateUtility"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>添加定制项</title>
<link href="../st/master.css" type="text/css" rel="stylesheet" />
 <link href="<%=path%>/style/page_master.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="<%=path %>/fckeditor/fckeditor.js"></script>	
<script type="text/javascript" src="${pageContext.request.contextPath}/component/My97DatePicker/WdatePicker.js"></script>
		
</head>
<script language=JavaScript>
//checkBox
function changeCheckBox(){
 	var cboxes=document.myform.elements;
	var cbox=document.getElementById("selectAllCheckBox");
 	for(i=0;i<cboxes.length;i++){
 		if(cboxes[i].Type="checkbox"){
 			if(cbox.checked==true){
 				cboxes[i].checked = true;
 			}else{
				cboxes[i].checked = false;
				cbox.checked = false;
			}
 		}
 	}
 }
 //word
 window.onload = function() {
		var oFCKeditor = new FCKeditor('content');
		oFCKeditor.BasePath = "../fckeditor/";
		oFCKeditor.Width = "762";
		oFCKeditor.Height = "400";
		oFCKeditor.ReplaceTextarea();
	}
	function FCKeditor_OnComplete(oFCKeditor) {
		var editorInstance = oFCKeditor;
		editorInstance.Events.AttachEvent('OnBlur', onEditorBlur);
	}
	function onEditorBlur() {
		try {
			//从当前页获得fckeditor实例       
			var oEditor = FCKeditorAPI.GetInstance("content");
			//检查 FCK 编辑器内容是否发生变化




			if (!oEditor.IsDirty())
				return;
			var newDiv = document.createElement('div');
			newDiv.innerHTML = oEditor.GetXHTML(true);
			//获取整个输入域文本，包含标签
			//alert(newDiv.innerHTML);
			//取得纯文字文本




			//alert(oEditor.EditorDocument.body.innerText);
			var srcs = [];
			for ( var i = 0; i < imgs.length; i++) {
				var src = imgs[i].src;
				//srcs[srcs.length] = src.replace(getDomainName(), '');
				srcs[srcs.length] = src;
				//alert(srcs);
			}
			//alert(imgs.value);
			addImageURL(srcs);
			return srcs;
		} catch (e) {
		}
	}
	 //删除按钮提交from
	 function deleteSumit(){
		 if(checkDel()){
		 	document.getElementById("myform").action="${pageContext.request.contextPath }/page/customize/deleteCustomizeditem ";
		 	document.getElementById("myform").submit();
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
	 		alert("请选择您要删除的子菜单!");
			return false;
		}else{
			return true;
		}
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
			alert("菜单链接不能为空");
			return false;
		}
		return true;
	}
	 //增加按钮单击事件
	 function myAdd(){
		 if(checkNONull()){
			document.getElementById("myform").action="AddAndUpdateGmItem?level=2";
			document.getElementById("myform").submit();
		 }
	}
		
	//删除
		function deleteGmenu(){
			if(checkDel()){
				if(confirm("确认删除子菜单？")){
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
				 	document.getElementById("myform").action="DeleteGmItem?gmcodes="+gmcodes;
					document.getElementById("myform").submit();
				}
			}
		}
</script>
<body>
<form action="" method="post" name="myform" id="myform">
	
	<!-- 设置定制块的单条记录 -->
	<s:set var="cmbcustom" value="#session.querycusByID" />
	
	<!-- 设置定制项的单条记录 -->
	<s:set var="cmbcustomItem" value="#request.queryByItemID" />
	
	<!-- 定制块的id -->
	<input type="hidden" name="cmbCode" id="cmbCode" value="<s:property value="#cmbcustom.Cmbcmbcode" />" />
	
	<!-- 定制项的ID -->
	<input type="hidden" name="cbiItemCode" id="cbiItemCode" value="<s:property value="#cmbcustomItem.Cbicbicode" />" />
    
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
								style="width:82px; height:28px; margin-left: 40px; background:url(<%=path %>/m_images/add.jpg); border:0px; " onclick="myAdd()" />
							<input type="button" value="新增" 
								style="width:82px; height:28px; margin-left: 20px; background:url(<%=path %>/m_images/add.jpg); border:0px;" onclick='javascript:location.href="querySubmenu?gmcode=<s:property value='#session.fagmcode' />"' />
							<input type="button" value="删 除"
								style="width:82px; height:28px; margin-left: 20px; background:url(<%=path %>/m_images/delete.jpg); border:0px;" onclick="deleteGmenu()" />
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
						<div class="admin_table" style="OVERFLOW-y: auto; OVERFLOW-x: auto; WIDTH: 785px; HEIGHT: 335px; background:#FFF;">
            <table width="900px" border="0" cellpadding="0" cellspacing="0"  bgcolor="#d5d5d5" class="manage_form"  >
							 <tr>
								<td colspan="4">
									<textarea rows="20" cols="200" name="bulletincontent" id="bulletincontent" >
										<s:property value="#gmenusbean.Gmigmi_content" />
									</textarea>
								</td>
							</tr>
						</table>	
					</div>	
				</div>
			</div>
			
		</div>
		</div>
		</div>
</form>
</body>
</html>
