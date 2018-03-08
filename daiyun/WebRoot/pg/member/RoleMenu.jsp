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
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/component/Ext3/js/ext-base.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/component/Ext3/js/ext-all.js"></script>
		<link rel="stylesheet" type="text/css"
			href="${pageContext.request.contextPath}/component/Ext3/css/ext-all.css" />
		<script type="text/javascript" src="js/jquery.min.js"></script>
		<script type="text/javascript" src="<%=path%>/js/PCASClass.js"></script>
		<link rel="stylesheet" type="text/css"
			href="<%=path%>/style/Forwarding_total.css" />
		<link rel="stylesheet" type="text/css"
			href="<%=path%>/style/Forwarding_page.css" />
		<title>角色配置</title>
		<style type="text/css">
.menuTree {
	margin-left: 0px;
	width: 300px;
	float: left;
}

.menuTree div {
	padding-left: 10px;
}

.menuTree div ul {
	overflow: hidden;
	display: none;
	height: auto;
	margin: 0;
}

.menuTree span {
	display: block;
	height: 10px;
	width: 100px;
	line-height: 25px;
	padding-left: 5px;
	margin: 1px 0;
	cursor: pointer;
	border-bottom: 1px solid #CCC;
}

.menuTree span:hover {
	background-color: #e6e6e6;
	color: #cf0404;
}

.menuTree a {
	color: #333;
	text-decoration: none;
}

.menuTree a:hover {
	color: #06F;
}

.menuTree span {
	height: 20px;
}

.GNTree {
	margin-left: 0px;
	width: 192px;
	float: left;
}

.GNTree div {
	padding-left: 10px;
}

.GNTree div ul {
	overflow: hidden;
	display: block;
	height: auto;
	margin: 0;
}

.GNTree span {
	display: block;
	height: 10px;
	width: 100px;
	line-height: 25px;
	padding-left: 5px;
	margin: 1px 0;
	cursor: pointer;
	border-bottom: 1px solid #CCC;
}

.GNTree span:hover {
	background-color: #e6e6e6;
	color: #cf0404;
}

.GNTree a {
	color: #333;
	text-decoration: none;
}

.GNTree a:hover {
	color: #06F;
}

.GNTree span {
	height: 20px;
}
</style>

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
        var rlcode=$("#rlcode").val();
        $.ajax({
        type:'post',
        url:'<%=path%>/saveRoleMenu',
        data:{userName:userName,useEname:useEname,iskCode:iskCode,strGmcode:strGmcode,strucode:strucode,rlcode:rlcode},
        success:function(data){
        if(data=="XXX"){
        alert("保存成功");
        }
        else{
        alert("保存失败");
        }
        }
        });
	}

function addSameLevelRole(){
var strcode = $("#strucode").val();
$("#userName").val("");
$("#strucode").val("");
$("#gmcode").val("");
$("#rlcode").val("");
$("#listvalue option").remove();
$.ajax({
type:'post',
url:'<%=path%>/buildStrucode',
data:{strcode,strcode},
success:function(data){
$("#strucode").val(data);
}
});
}
//删除t_fs_role 中的角色
function DeleteRole(){
if(confirm("确认删除？")){
var rlcode=$("#rlcode").val();
        $.ajax({
        type:'post',
        url:'<%=path%>/DeleteRole',
        data:{rlcode:rlcode},
        success:function(data){
        if(data=="OK"){
        alert("删除成功");
        }
        else{
        alert("删除失败");
        }
        }
        });

}
}
function saveSameLevelRole(){
save();
buildTree();
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


function addGN(code,value){
 var bool=true;
 $("#listvalue option").each(function(){
 if($(this).val()==code){
 alert("请勿重复添加");
 bool=false;
 return ;
 }
 });
 if(bool){
 $("#listvalue").append("<option value='"+code+"'>"+value+"</option>");
 }
 queryGmenuByCode(code,value);
}

//删除
function del(){
if(confirm("确认移除？")){
 var code=$("#listvalue").find("option:selected").remove();
 }
}  
//查询功能信息
function queryGmenuByCode(code,value){
Ext.Ajax.request({
type:'post',
url:'<%=path%>/queryGmenuByCode',
params:{code:code,value:value},
success:function(request){
var data = Ext.util.JSON.decode(request.responseText);
	$("#gmgmname").val(data.gmgmname);
	$("#iskiskcode").val(data.iskiskcode);
	$("#gmcode").val(data.gmgmcode);
	$("#gmstrucode").val(data.gmgmstructurecode);
	$("#gmgmlevel").val(data.gmgmlevel);
	$("#gosgoscode").val(data.gosgoscode);
    $("#gmgmlink").val(data.gmgmlink);
   $("#gmgmgroupcode").val(data.gmgmgroupcode);
   
    $("#gmparameter").val(data.gmgmparameter);
    $("#gmmaxusecount").val(data.gmgmmaxusecount);
   $("#gmshowtoolbar").val(data.gmgmshowtoolbar);
  }			
});
}

//生成功能排序号gmstrucode
function addGuimenu(){ 
var gmstrucode = $("#gmstrucode").val();
$("#gmgmname").val("");
	$("#gmcode").val("");
$.ajax({
type:'post',
url:'<%=path%>/buildGmstrucode',
data:{gmstrucode,gmstrucode},
success:function(data){
$("#gmstrucode").val(data);
}
});
}

//保存新功能

function saveGuimenu(){
var gmname=$("#gmgmname").val();//重新填写
var iskiskcode=$("#iskiskcode").val();
var gmcode=$("#gmcode").val();
var gmstrucode=$("#gmstrucode").val();
var gmgmlevel=$("#gmgmlevel").val();
var gosgoscode=$("#gosgoscode").val();
var gmgmlink=$("#gmgmlink").val();
var gmgmgroupcode=$("#gmgmgroupcode").val();
var gmparameter=$("#gmparameter").val();
var gmmaxusecount=$("#gmmaxusecount").val();
var gmshowtoolbar=$("#gmshowtoolbar").val();
 $.ajax({
        type:'post',
        url:'<%=path%>/saveNewMenu',
        data:{gmname:gmname,iskiskcode:iskiskcode,gmcode:gmcode,gmstrucode:gmstrucode,gmgmlevel:gmgmlevel,gosgoscode:gosgoscode,gmgmlink:gmgmlink,gmgmgroupcode:gmgmgroupcode,gmparameter:gmparameter,gmmaxusecount:gmmaxusecount,gmshowtoolbar:gmshowtoolbar},
        success:function(data){
        if(data=="OK"){
        alert("保存成功");
        }
        else{
        alert("保存失败");
        }
        }
        });
}
//删除功能(删除t_fs_guimenu中的功能，而不是角色下的功能)
function deleteGuimenu(){
if(confirm("确认删除？")){
var gmcodes="";
         //获取菜单对应的gmcode
        $("#listvalue option").each(function(){
        gmcodes+=","+$(this).val();
        });  
$.ajax({
        type:'post',
        url:'<%=path%>/deleteGuimenu',
        data:{gmcodes:gmcodes},
        success:function(data){
        if(data=="OK"){
        alert("保存成功");
        }
        else{
        alert("保存失败");
        }
        }
        });
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

	<body onload="innit();">
		<div id="main">
			<div id="top">
				<div class="top">
					<div class="window">
						<div class="left">
							亲，
							<span><%=session.getAttribute("Opname")%></span> 您好！欢迎登录我的代运！
						</div>
						<div class="right">
							<span><a
								href="${pageContext.request.contextPath}/order/loginout">退出</a>
							</span> |
							<span><a
								href="${pageContext.request.contextPath}/op/recharge.jsp"
								target="_blank">充值</a>| <span><a href="#">English</a> </span> </span>
						</div>
					</div>
					<div class="logo">
						<div class="left">
							<img src="images/logo.jpg" />
						</div>
						<div class="right">
							<img src="images/tel.jpg" />
						</div>
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
						<h3>
							<a href="#">我的代运</a> > 我的信息 >
							<span>角色管理</span>
						</h3>
					</div>
					<form action="" id="userForm" method="post">
						<div class="profile">
							<div id="menuTree" class="menuTree"></div>


							<table>
								<tr>
									<td>
										<span>角色名称</span>
										<input id="userName" type="text">
									</td>
									<td>
										<span>系统名称</span>
										<input readonly="readonly" style="background-color: #f1f1f1;"
											id="sysname" type="text">
									</td>
								</tr>
								<tr>
									<td>
										<span>角色代码</span>
										<input readonly="readonly" style="background-color: #f1f1f1;"
											id="rlcode" type="text">
									</td>
									<td>
										<span>层次代码</span>
										<input readonly="readonly" style="background-color: #f1f1f1;"
											id="strucode" type="text">
									</td>
								</tr>
								<!--   <tr><td> <span>系统类型</span><select name="iskCode" id="iskCode" style="margin-left:6px;width:137px;" onchange="initfirstMenu()">
              <option value="" selected="selected">选择系统类型</option>
              <option value="LEWFDIS" >网站页面前台系统</option>
              </select></td>　        
              <td>　<span>功能类型</span><select name="firstMenu" id="firstMenu" onchange="initsecMenu();" style="margin-left:6px;width:137px" >
              <option value="" selected="selected">选择系统类型</option>
              </select></td>  </tr>              
              <tr><td> <span>功能详情</span><select name="secMenu" id="secMenu" style="margin-left:6px;width:137px;" >
              <option value="" selected="selected">选择系统类型</option>
              </select></td>　 
              </tr> 
              -->
								<tr>
									<td>
										<input type="button" onclick="add();"
											style="width: 54px; margin-left: -6px;" value="添加" />
										<input type="button" style="width: 60px" onclick="del();"
											value="移除" />
									</td>
									<td>
										<input type="button" onclick="saveSameLevelRole();"
											style="width: 60px; margin-left: -14px;" value="保存信息" />
											&nbsp;&nbsp;
										<input type="button" onclick="addSameLevelRole();"
											style="width: 86px; margin-left: -26px;" value="添加同级角色" />
											&nbsp;&nbsp;
										<input type="button" onclick="DeleteRole();"
											style="width: 86px; margin-left: -26px;" value="删除角色" />
									</td>
								</tr>



								<tr>
									<td>
										<div id="GNTree" class="GNTree"></div>
									</td>
									<td align="left">
										<span>角色功能 </span>
										<select id="listvalue" multiple
											style="height: 400px; width: 122px; margin-left: -6px;">
										</select>
									</td>

								</tr>

								<!--添加，删除，保存新功能
								<tr>
									<td>
										<span>新功能名称</span>
										<input id="gmgmname" name="gmgmname" type="text" />
									</td>
									<td>
										<span>层次代码</span>
										<input readonly="readonly" style="background-color: #f1f1f1;"
											id="gmstrucode" type="text" />
										<input readonly="readonly" style="background-color: #f1f1f1;"
											id="iskiskcode" type="hidden">
									</td>
								</tr>
								<tr>
									<td>
										<input style="background-color: #f1f1f1;" id="gmcode"
											type="hidden" />
									</td>
									<td>
										<input readonly="readonly" style="background-color: #f1f1f1;"
											id="gmgmlevel" type="hidden" />
										<input readonly="readonly" style="background-color: #f1f1f1;"
											id="gosgoscode" type="hidden" />
										<input readonly="readonly" style="background-color: #f1f1f1;"
											id="gmgmlink" type="hidden" />
										<input readonly="readonly" style="background-color: #f1f1f1;"
											id="gmgmgroupcode" type="hidden" />
										<input readonly="readonly" style="background-color: #f1f1f1;"
											id="gmparameter" type="hidden" />
										<input readonly="readonly" style="background-color: #f1f1f1;"
											id="gmmaxusecount" type="hidden" />
										<input readonly="readonly" style="background-color: #f1f1f1;"
											id="gmshowtoolbar" type="hidden" />
									</td>
								</tr>
								<tr>
									<td>
										<input type="button" onclick="addGuimenu();"
											style="width: 86px; margin-left: -26px;" value="添加同级功能" />
											&nbsp;&nbsp;
										<input type="button" onclick="saveGuimenu();"
											style="width: 60px; margin-left: -14px;" value="保存功能" />
											&nbsp;&nbsp;
										<input type="button" onclick="deleteGuimenu();"
											style="width: 60px; margin-left: -14px;" value="删除功能" />
									</td>
								</tr>


								--><tr>
								</tr>
								<tr>
									<td></td>
									<td></td>
								</tr>
							</table>
						</div>
					</form>
				</div>
			</div>

			<div class="clear"></div>
			<div id="bottom">
				<div class="copyright">
					<div class="nir">
						<div class="left">
							Copyright © 2012 深圳市代运物流网络有限公司

							<br />
							(AT) 2008-2010 All Rights Reserved 粤ICP备0503210号

						</div>
						<div class="right">
							<img src="images/tel2.jpg" />
						</div>
					</div>
				</div>
				<div class="bottom_nav">
					<a href="javaScript:void(0);" onclick="buildTree();">首页</a>│

					<a href="#">货物追踪</a>│

					<a href="#">提货服务</a>│

					<a href="#">新闻资讯</a>│

					<a href="#">成为供应商</a> |
					<a href="#">新闻中心</a> |
					<a href="#">联系我们</a>
				</div>
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
	$("#rlcode").val(data.rlrlcode);
	$("#strucode").val(data.rlrlstructurecode);
  }			
});
}

function queryMenuAjax(rlcode){
Ext.Ajax.request({
type:'post',
url:'<%=path%>/queryMenuAjax',
params:{rlcode:rlcode},
success:function(request){
var data = Ext.util.JSON.decode(request.responseText);
$("#listvalue").empty();
for(var i=0;i<data.length;i++){
		var opt=new Option(data[i].gmname,data[i].gmcode); 
		document.getElementById("listvalue").options[i] = opt;
	}	
  }			
});
}

function queryMenu(rlcode){//角色树下面的onclick事件
queryRoleAjax(rlcode);//通过rlcode显示改角色相关信息

queryMenuAjax(rlcode);//遍历出该角色下面所拥有的所有功能

}	

//初始功能树和角色树


function innit(){
buildGNTree();
buildTree();
}


//生成功能树


function buildGNTree(){
var json="";
Ext.Ajax.request({
type:'post',
async: false,
url:'<%=path%>/buildGNTree',
success:function(request){
document.getElementById("GNTree").innerHTML="";
json = Ext.util.JSON.decode(request.responseText);
document.getElementById("GNTree").innerHTML=forGNTree(json);
 str="";
/*树形菜单*/
	var menuTree = function(){
	 //给有子对象的元素加


		 $("#GNTree ul").each(function(index, element) {
	 		var ulContent = $(element).html();
	 		var spanContent = $(element).siblings("span").html();
	 		if(ulContent){
				 $(element).siblings("span").html(spanContent) 
	 		}
		 });
		 $("#GNTree").find("div span").click(function(){
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
	$("#btn_open").click(function(){
		$("#GNTree ul").show(300);
	 	curzt("-");
	})

	/*收缩*/
	$("#btn_close").click(function(){
	 	$("#GNTree ul").hide(300);
	 	curzt("+");
	})
 }			
});
}

/*递归实现获取无级树数据并生成DOM结构*/
//功能树


var str = "";
	var forGNTree = function(o){
	 	for(var i=0;i<o.length;i++){
	   		 var urlstr = "";
			 try{
	 				if(typeof o[i]["url"] == "undefined"){
			   	   		urlstr = "<div><span>"+o[i]["userLevel"]+ o[i]["name"] +"</span><ul>";
	 				}else{
	 					urlstr = "<div><span>"+o[i]["userLevel"]+"<a "+"onclick='"+"addGN("+o[i]["code"]+","+'"'+o[i]["name"]+'"'+")'"+" href="+ o[i]["url"] +">"+ o[i]["name"] +"</a></span><ul>"; 
	 				}
	 			str += urlstr;
	 			if(o[i]["list"] != null){
	 				forGNTree(o[i]["list"]);
	 			}
	   		 str += "</ul></div>";
	 		}catch(e){}
	 }
	 return str;
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
    /*添加无级树*/
	/*function curzt(v){
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

