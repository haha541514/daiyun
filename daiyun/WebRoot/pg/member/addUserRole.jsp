<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <script type="text/javascript" src="${pageContext.request.contextPath}/component/Ext3/js/ext-base.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/component/Ext3/js/ext-all.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/component/Ext3/css/ext-all.css"/>
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="<%=path%>/js/PCASClass.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=path%>/style/Forwarding_total.css"/>
    <link rel="stylesheet" type="text/css" href="<%=path%>/style/Forwarding_page.css"/>    
 <title>权限分配</title>
 <style type="text/css">
.menuTree{ margin-left:0px;width:300px;float:left;}
.menuTree div{ padding-left:10px;}
.menuTree div ul{ overflow:hidden; display:none; height:auto; margin:0;}
.menuTree span{ display:block; height:10px;width:100px;line-height:25px; padding-left:5px; margin:1px 0; cursor:pointer; border-bottom:1px solid #CCC;}
.menuTree span:hover{ background-color:#e6e6e6; color:#cf0404;}
.menuTree a{ color:#333; text-decoration:none;}
.menuTree a:hover{ color:#06F;}
.menuTree span{height: 20px;}

.GNTree{ margin-left:0px;width:192px;float:left;}
.GNTree div{ padding-left:10px;}
.GNTree div ul{ overflow:hidden; display:block; height:auto; margin:0;}
.GNTree span{ display:block; height:10px;width:100px;line-height:25px; padding-left:5px; margin:1px 0; cursor:pointer; border-bottom:1px solid #CCC;}
.GNTree span:hover{ background-color:#e6e6e6; color:#cf0404;}
.GNTree a{ color:#333; text-decoration:none;}
.GNTree a:hover{ color:#06F;}
.GNTree span{height: 20px;}

</style>

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
 
 <script type="text/javascript">
 function addRole(){
 var code=$("#rlcode").val();
 var value=$("#userName").val();
 var t=true;
 $("#listvalue option").each(function(){
 if($(this).val()==code){
 alert("请勿重复添加");
 t=false;
 return ;
 }
 });
 if(t){
 $("#listvalue").append("<option value='"+code+"'>"+value+"</option>");
 }
 }
 
 function delRole(){
 if(confirm("确认移除？")){
 var code=$("#listvalue").find("option:selected").remove();
 }
 }

 </script>
  
 <script type="text/javascript">
 
 function saveUserRole(){
 if(confirm("确认保存？")){
 var rlcode="";
 $("#listvalue option").each(function(){
 rlcode+=","+$(this).val(); 
 });
 var ur_usercode=$("#ur_usercode").val();
 var iskiskcode=$("#striskcode").val();
 $.ajax({
 type:'post',
 url:'<%=path%>/saveUserRole',
 data:{rlcode:rlcode,ur_usercode:ur_usercode,iskiskcode:iskiskcode},
 success:function(data){
 if(data=="OK"){
 alert("保存成功");
 }else{
 alert("保存失败");
 }
 }
 })
 }
 }
 </script>
  
</head>

<body onload="innit();">
<div id="main">
  <div id="top">
    <div class="top">
      <div class="window">
       <div class="left">亲，<span><%=session.getAttribute("Opname")%></span>  您好！欢迎登录我的代运！</div>
       <div class="right"><span><a href="${pageContext.request.contextPath}/order/loginout">退出</a></span> | <span><a href="${pageContext.request.contextPath}/op/recharge.jsp" target="_blank">充值</a>| <span><a href="#">English</a></span></span>
      </div>
       </div>
      <div class="logo">
        <div class="left"><img src="images/logo.jpg" /></div>
        <div class="right"><img src="images/tel.jpg" /></div>
      </div>
      <div class="nav">
         <jsp:include page="../include/main_menu.jsp"></jsp:include>
        <div class="nav_last"></div>
      </div>
    </div>
  </div>
  <div class="forwarding">
     <jsp:include page="../../op/tree.jsp"></jsp:include>	
     <input type="hidden" value="LEWFDIS" id="iskCode" name="iskCode" />
    <div class="right">
      <div class="home">
      <h3><a href="#">我的代运</a> > 我的信息 > <span>角色管理</span></h3>
      </div>
      <form action="" id="userForm" method="post">
      <div class="profile">
        <div id="menuTree" class="menuTree"></div>   
        
        
    <table>
    <s:set var="usercode" value="#request.usercode"></s:set>  
    <tr><td>员工编号:<input id="ur_usercode" name="ur_usercode" value="<s:property value="usercode"/>"/></td></tr>
    <tr><td><span>角色信息:</span></td></tr>
    <tr><td><span>角色名称</span> <input readonly="readonly" id="userName" type="text"></td>　<td>　<span>系统名称</span> <input readonly="readonly" style="background-color: #f1f1f1;" id="sysname" name="sysname" type="text"></td> <td> <input id="striskcode" type="hidden" name="striskcode" readonly="readonly" style="background-color: #f1f1f1;" type="text"></td>
    </tr>
    <tr><td><span>角色代码</span> <input readonly="readonly" style="background-color: #f1f1f1;"  id="rlcode" type="text"></td>　<td>　<span>层次代码</span> <input readonly="readonly" style="background-color: #f1f1f1;" id="strucode" type="text"></td>
    </tr>
    <tr>
    <td>　　　　　<input type="button" onclick="addRole();" style="width:54px;margin-left: -6px;" value="添加"/>　　<input type="button" style="width:60px" onclick="delRole();" value="移除"/></td> 
    <td>　　　　　<input type="button" onclick="saveUserRole();" style="width:60px;margin-left:-14px;" value="保存信息"/>　</td> 
 <!--    <td>　　　　　<input type="button" onclick="saveUserRole();" style="width:60px;margin-left:-14px;" value="添加角色"/>　</td>    -->
    </tr>
    <tr>
    <td >     
     <div id="GNTree" class="GNTree"></div>  
     </td>
    <td align="left"><span>添加角色　</span>
    <select id="listvalue" multiple style="height:400px;width:122px;margin-left:-6px;">
    <s:iterator var="role" value="#request.RoleList">
     <option  value="<s:property value="#role.Rlcode"/>"> <s:property value="#role.Rlname"/> </option>
     </s:iterator>
    </select>
    </td>  
    
     </tr> 
     <tr>
     </tr>   
    <tr><td></td><td></td></tr>   
</table>
      </div>
      </form>
    </div>
  </div>

  <div class="clear"></div>
  <div id="bottom">
    <div class="copyright">
      <div class="nir">
        <div class="left"> Copyright © 2012 深圳市代运物流网络有限公司<br />
          (AT) 2008-2010 All Rights Reserved 粤ICP备0503210号 </div>
        <div class="right"><img src="images/tel2.jpg" /></div>
      </div>
    </div>
    <div class="bottom_nav"> <a href="javaScript:void(0);" onclick="buildTree();">首页</a>│<a href="#">货物追踪</a>│<a href="#">提货服务</a>│<a href="#">新闻资讯</a>│<a href="#">成为供应商</a> | <a href="#">新闻中心</a> | <a href="#">联系我们</a></div>
  </div>
</div>
</body>
<script type="text/javascript">

function queryRoleAjax(rlcode){
Ext.Ajax.request({
type:'post',
url:'<%=path%>/queryRoleAjax',
params:{rlcode:rlcode},
success:function(request){
var data = Ext.util.JSON.decode(request.responseText);
	$("#userName").val(data.rlrlname);
	$("#sysname").val(data.iskiskname);
	$("#striskcode").val(data.iskiskcode);
	$("#rlcode").val(data.rlrlcode);
	$("#strucode").val(data.rlrlstructurecode);
	$("#listvalue2").val(data.rlrlname);
  }			
});
}

function queryMenu(rlcode){
queryRoleAjax(rlcode);
}	

//初始功能树和角色树

function innit(){
buildTree();
}


//生成角色树

function buildTree(){
var json="";
Ext.Ajax.request({
type:'post',
async: false,
url:'<%=path%>/buildTree',
success:function(request){
document.getElementById("menuTree").innerHTML="";
json = Ext.util.JSON.decode(request.responseText);
document.getElementById("menuTree").innerHTML=forTree(json);
str="";
/*树形菜单*/
	var menuTree = function(){
	 //给有子对象的元素加

		 $("#menuTree ul").each(function(index, element) {
	 		var ulContent = $(element).html();
	 		var spanContent = $(element).siblings("span").html();
	 		if(ulContent){
				 $(element).siblings("span").html(spanContent) 
	 		}
		 });
		 $("#menuTree").find("div span").click(function(){
		 	 var ul = $(this).siblings("ul");
			 var spanStr = $(this).html();
		 	 var spanContent = spanStr.substr(3,spanStr.length);
			 if(ul.find("div").html() != null){
				 if(ul.css("display") == "none"){
					 ul.show(300);
		 			 // $(this).html("[-]" + spanContent);
		 		 }else{
		 			ul.hide(300);
		 			// $(this).html("[+] " + spanContent);
		 		 }
		 	}
		 })
	}()
	/*树形列表展开*/
	$("#btn_open").ready(function(){
		$("#menuTree ul").show(300);
	 	curzt("-");
	})

	/*收缩*/
	$("#btn_close").click(function(){
	 	$("#menuTree ul").hide(300);
	 	curzt("+");
	})
 }			
});
}
/*递归实现获取无级树数据并生成DOM结构*/
var str = "";
	var forTree = function(o){
	 	for(var i=0;i<o.length;i++){
	   		 var urlstr = "";
			 try{
	 				if(typeof o[i]["url"] == "undefined"){
			   	   		urlstr = "<div><span>"+o[i]["userLevel"]+ o[i]["name"] +"</span><ul>";
	 				}else{
	 					urlstr = "<div><span>"+o[i]["userLevel"]+"<a "+"onclick='"+"queryMenu("+o[i]["code"]+")'"+" href="+ o[i]["url"] +">"+ o[i]["name"] +"</a></span><ul>"; 
	 				}
	 			str += urlstr;
	 			if(o[i]["list"] != null){
	 				forTree(o[i]["list"]);
	 			}
	   		 str += "</ul></div>";
	 		}catch(e){}
	 }
	 return str;
	}
    /*添加无级树
	function curzt(v){
	 $("#menuTree span").each(function(index, element) {
		 var ul = $(this).siblings("ul");
		 var spanStr = $(this).html();
		 var spanContent = spanStr.substr(3,spanStr.length);
		 if(ul.find("div").html() != null){
	 		$(this).html("["+ v +"] " + spanContent);
	 	 }
	 }); 
	}*/
</script>	
</html>

