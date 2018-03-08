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
<script type="text/javascript" src="<%=path %>/fckeditor/fckeditor.js"></script>
<link href="<%=path%>/style/master.css" type="text/css" rel="stylesheet" />
<link href="<%=path%>/style/page_master.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="<%=path%>/fckeditor/fckeditor.js"></script>		
<script type="text/javascript" src="${pageContext.request.contextPath}/component/My97DatePicker/WdatePicker.js"></script>
		
</head>
<script language=JavaScript>

//判断是桌面系统还是网站前台



function JudgmentS(jdS){   
	      document.getElementById("boolSystem").value="LEWFDIS";;
	      document.getElementById("myform").action="queryFirstItem";
	      document.getElementById("myform").submit();

	}
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
 window.onload = function() {
		var oFCKeditor = new FCKeditor('content');
		oFCKeditor.BasePath = "<%=path %>/fckeditor/";
		oFCKeditor.Width = "100%";
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
<input type="hidden" id="boolSystem" name="boolSystem"/>
	<!-- 设置定制块的单条记录 -->
	<s:set var="cmbcustom" value="#session.querycusByID" />
	
	<!-- 设置定制项的单条记录 -->
	<s:set var="cmbcustomItem" value="#request.queryByItemID" />
	
	<!-- 定制块的id -->
	<input type="hidden" name="cmbCode" id="cmbCode" value="<s:property value="#cmbcustom.Cmbcmbcode" />" />
	
	<!-- 定制项的ID -->
	<input type="hidden" name="cbiItemCode" id="cbiItemCode" value="<s:property value="#cmbcustomItem.Cbicbicode" />" />
    
 <div id="admin">    
	<div id="top"><img src="<%=path%>/m_images/logo.jpg" /> <span> 您现在的位置--<a href="<%=path%>/daiyun.jsp">首页---</a>会员中心--<a href="javascript:void(0)" onclick="JudgmentS('LEWFDIS');">网站前台</a>--多级功能</span>
	</div>
		<div class="master">
    <jsp:include page="tree.jsp"></jsp:include>
    <div class="right">
	    <div class="admin_box">
			<div class="admin_rit_ads">
			    <div class="admin_ads_head">
				    <div class="admin_ads_head_lft"></div>	
				    <div class="admin_piece_rit">
								<!--<input type="button" value="网站前台" 
								style="width:82px; height:28px; margin-left: 20px; background:url(<%=path %>/m_images/add.jpg); border:0px; " onclick="JudgmentS('LEWFDIS');" />
							--><input type="button" value="保 存"
								style="width:82px; height:28px; margin-left: 140px; background:url(<%=path %>/m_images/add.jpg); border:0px; " onclick="myAdd()" />
							<input type="button" value="新增" 
								style="width:82px; height:28px; margin-left: 40px; background:url(<%=path %>/m_images/add.jpg); border:0px;" onclick='javascript:location.href="querySubmenu?gmcode=<s:property value='#session.fagmcode' />"' />
							<input type="button" value="删 除"
								style="width:82px; height:28px; margin-left: 40px; background:url(<%=path %>/m_images/delete.jpg); border:0px;" onclick="deleteGmenu()" />
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
						<table  border="0" width="761" cellpadding="0" cellspacing="1" bgcolor="#d5d5d5" id="manage_form" class="manage_form">
							<tr class="manage_form_bk4">
								<td width="100" style="text-align: center;">
									全选



									<input type="checkbox" name="selectAllCheckBox" id="selectAllCheckBox" style="width: 20px" onclick="changeCheckBox();" />
								</td>
						<td width="130">菜单名称</td>
                            <td width="170">菜单链接</td>
                            <td width="60">结构代码</td>
                            <td width="60">菜单参数</td>
                            <td width="100">菜单内容 </td>
								
							</tr >		
							 <s:iterator var="bean" value="#request.submenulist">                       
	                        <tr class="manage_form_bk">
	                            <td width="60px" style=" text-align:center;">
	                            	<input type="checkbox" name="gmcode" id='gmcode' value="<s:property value='#bean.Gmgm_code' />" style="width:20px"  />
	                            </td>
	                            <td><a  href="querySubByGmCode?gmcode=<s:property value='#bean.Gmgm_code' />&sc=<s:property value='#request.sc' />"><s:property value="#bean.Gmgm_name" /></a></td>
	                            <td><s:property value="#bean.Gmgm_link" /></td>	                      
	                            <td><s:property value="#bean.Gmgm_structurecode" /></td>
	                            <td><s:property value="#bean.Gmgm_parameter" /></td>
	                            <td>
	                            <s:if test="#bean.Gmigmi_content.getBytes().length>30">
		                    	 <s:property value="@com.daiyun.pgweb.util.StrUtil@splitString(#bean.Gmigmi_content,30)"/>...
		                    	 </s:if>
		                    	 <s:else>
		                    	 <s:property value="@com.daiyun.pgweb.util.StrUtil@splitString(#bean.Gmigmi_content,30)"/>
		                    	 </s:else>
	                            </td>
	                        </tr>                            
                        </s:iterator>          						
						</table>
					</div>
				</div>
			</div>
		</div>
		</div>
	
		 <textarea rows="10" cols="125" name="content"  id="content" ><s:property value="#gmenusbean.Gmigmi_content" /></textarea>
		 </div>
</form>
</body>
</html>
