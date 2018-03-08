<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib uri = "/project" prefix="p" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>实名认证</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/component/Ext3/js/ext-base.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/component/Ext3/js/ext-all.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/component/Ext3/css/ext-all.css"/>
<link href="<%=path%>/style/page_master.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="<%=path%>/js/jquery.min.js"></script>
<script type="text/javascript">
function save(){
        var strGmcode="";
         //获取菜单对应的gmcode
        $("#listvalue option").each(function(){
        strGmcode+=","+$(this).val();
        });    
        var userName = $("#userName").val();
        var useEname=$("#useEname").val();
        var iskCode=$("#iskCode").val();
        var strucode=$("#strucode").val(); 
        $.ajax({
        type:'post',
        url:'<%=path%>/saveRoleMenu',
        data:{userName:userName,useEname:useEname,iskCode:iskCode,strGmcode:strGmcode,strucode:strucode},
        success:function(data){
        alert("1");
        if(data=="1"){
        alert("保存成功");
        }
        else{
        alert("保存失败");
        }
        }
        });
	}
	
function initfirstMenu(){
var striskCode = $("#iskCode").val();
if(striskCode=="")
return;
Ext.Ajax.request({
type:'post',
url:'<%=path%>/queryFirstMenu',
params:{iskCode:striskCode},
success:function(request){
var data = Ext.util.JSON.decode(request.responseText);
$("#firstMenu").empty();
document.getElementById("firstMenu").options[0] = new Option("选择一级菜单栏","");
$("#secMenu").empty();
document.getElementById("secMenu").options[0] = new Option("选择二级菜单栏","");
for(var i=0;i<data.length;i++){
		var opt=new Option(data[i].gmgm_name,data[i].gmgm_structurecode); 
		document.getElementById("firstMenu").options[i+1] = opt;
	}	
  }			
});
}

function initsecMenu(){
var struCode = $("#firstMenu").val();
if(struCode=="")
return;
Ext.Ajax.request({
type:'post',
url:'<%=path%>/querySecMenu',
params:{strcCode:struCode},
success:function(request){
var data = Ext.util.JSON.decode(request.responseText);
$("#secMenu").empty();
document.getElementById("secMenu").options[0] = new Option("选择二级菜单栏","");
for(var i=0;i<data.length;i++){
		var opt=new Option(data[i].gmgm_name,data[i].gmgm_code); 
		document.getElementById("secMenu").options[i+1] = opt;
	}	
  }			
});
}

function add(){
 var value=$("#secMenu").val();
 var code=$("#secMenu").find("option:selected").text();
 var bool=true;
 if($("#iskCode").val()==""){
 alert("请选择系统类型");
 return ;
 }
 if($("#firstMenu").val()==""){
 alert("请选择一级菜单");
 return ;
 }
 if($("#secMenu").val()==""){
 alert("请选择二级菜单");
 return ;
 }
 
 $("#listvalue option").each(function(){
 if($(this).val()==value){
 alert("请勿重复添加");
 bool=false;
 return ;
 }
 });
 if(bool){
 $("#listvalue").append("<option value='"+value+"'>"+code+"</option>");
 }
}

function del(){
if(confirm("确认移除？")){
 var code=$("#listvalue").find("option:selected").remove();
 }
}

</script>
<script type="text/javascript">
 $(function(){
 	$("#img1").click(function() {
 		var img_src = $(this).attr('src');
 		var body_height = $('body').outerHeight();
 		$('#show_img').attr('src',img_src) ;
 		var img_h = $('#show_img').height();
 		var img_w = $('#show_img').width();
 		var mg_left = -img_w/2;
 		var mg_top = -img_h/2;
 		$('#show_img').css({'margin-top':mg_top,'margin-left':mg_left,'display':'block'});
 		$('#img_bg').css('height',body_height).show();
 		return false;
 	});

 	$('#show_img,#img_bg').click(function() {
 		$('#show_img,#img_bg').hide();
 	});
 })
 
 $(function(){
 	$("#img2").click(function() {
 		var img_src = $(this).attr('src');
 		var body_height = $('body').outerHeight();
 		$('#show_img').attr('src',img_src) ;
 		var img_h = $('#show_img').height();
 		var img_w = $('#show_img').width();
 		var mg_left = -img_w/2;
 		var mg_top = -img_h/2;
 		$('#show_img').css({'margin-top':mg_top,'margin-left':mg_left,'display':'block'});
 		$('#img_bg').css('height',body_height).show();
 		return false;
 	});

 	$('#show_img,#img_bg').click(function() {
 		$('#show_img,#img_bg').hide();
 	});
 })
 </script>

</head>
<style>
a{color:#333333;text-decoration:none;}
.pageNav { text-align:center; margin-top:10px; height:26px; padding:3px 0px;color: #000000;}
.pageNav a { display:inline; border:1px solid #ccc; height:20px; line-height:20px; margin-left:5px; padding:2px 7px;}
.pageNav a:hover { border:1px solid #3a739d; text-decoration:none; color:#3a739d; background:#f6fbff;}
</style>
<body>
<img src="" style='z-index:1002;position:fixed; top:50%;left:50%; display:none' id="show_img"/>
<div id='img_bg' style="width:100%; height:100%; opacity:0.6; background:#000000; z-index:1001; position:absolute;top:0;left:0;right:0; display:none"></div>
<form action=""`
	method="post" name="listform" id="listform" >
<div id="admin">
  <div id="top"><img src="<%=path%>/m_images/logo.jpg" /> <span>首您现在的位置：<a href="<%=path%>/daiyun.jsp">首页</a>---会员中心---角色配置</span> </div>
  <div class="master">  
  <s:set var="rbean" value="#request.objRoleColumns"></s:set>
    <jsp:include page="../bulletin/tree.jsp"></jsp:include>
    <div class="right">
      <div class="admin_rit_ads">
         <div class="admin_ads_head">
          <div class="admin_ads_head_lft"></div>
          <div class="admin_piece_rit">
            <input type="button" value="保存角色" style="width:82px;margin-left:222px;height:28px; background:url(<%=path %>/m_images/add.jpg); border:0px;" onclick="save();"/>   
            &nbsp;&nbsp;&nbsp;
            <input type="button" value="新增角色" style="width:82px; height:28px; background:url(<%=path %>/m_images/add.png); border:0px;" onclick="Pass();"/>
            &nbsp;&nbsp;&nbsp;
            <input type="button" value="删除角色" style="width:82px; height:28px; color:#FFF; background:url(<%=path %>/m_images/delete.png); border:0px;" onclick="NoPass();"/>
          </div>
        </div>
         <div class="admin_ads_check" align="center">   
                     <table width="765" border="0" id="review_table">
  <tr>
    <td><span>角色名称：</span>
              <input  name="userName" id="userName" value="<s:property value="#rbean.rlrlname"/>" type="text" style="width:110px;" /></td>
    <td><span>角色英文名：</span>
              <input name="useEname" id="useEname" value="<s:property value="#rbean.rlrlename"/>" type="text" style="width:110px;" />
             </td>
              <td>系统类型: <select name="iskCode" id="iskCode" onchange="initfirstMenu()">
              <option value="" selected="selected">选择系统类型</option>
              <option value="LEWFDIS" >网站页面前台系统</option>
              <option value="LEDPIS">速递桌面预报系统</option>
              <option value="LEWIS">速递网上系统</option>
              <option value="LEDIS">速递桌面系统</option>
              </select></td>
  </tr>  
  <tr>
    <td><span>一级菜单：</span>
               <select name="firstMenu" id="firstMenu" onchange="initsecMenu();" >
               <option value="" selected="selected">选择系统类型</option>
               </select>
               </td>
    <td><span>二级菜单：</span>
            <select name="secMenu" id="secMenu" >
            <option value="" selected="selected">选择一级菜单</option>
               </select> 
            </td>
            <td><input type="button" onclick="add();" value="添加功能"/>　　<input type="button" onclick="del();" value="移除功能"/></td>
            
  </tr>   
  <tr>
    <td><span>排序号：</span>
              <input  name="strucode" id="strucode" value="<s:property value="#ubean.opopname"/>" type="text" style="width:110px;" /></td>
  </tr>
  <tr>
  <td><span>角色功能：</span>
<select id="listvalue" multiple style="height:200px;width:105px;">
<s:iterator var="mbean" value="#request.listRolemenusColumns">
<option value="<s:property value="#mbean.gmcode"/>"><s:property value="#mbean.Gmname"/></option>
</s:iterator>
</select>
  
  </td>
  
  </tr>
</table>
<div>
</div>
        </div>
        </div>
      </div>
    </div>
  </div>
</form>


</body>


</html>
