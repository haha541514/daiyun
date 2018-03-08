<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="kyle.leis.fs.authoritys.user.da.UserColumns" %>
<%@page import="kyle.common.util.jlang.DateFormatUtility"%>
<%@page import="kyle.common.util.jlang.StringUtility"%>
<%@page import="kyle.common.util.jlang.DateUtility"%>
<%@ page import="com.opensymphony.xwork2.ActionContext" %>
<%@ page import="com.daiyun.dax.WebDemand" %>
<%@taglib uri = "/project" prefix="p" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
 path = request.getContextPath();
 basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String actionName=ActionContext.getContext().getName();
if(!StringUtility.isNull(actionName)){
if(actionName.equals("qyByBlIdTool")) actionName="newCode";
List<List<String>> list=WebDemand.getId();
for(int i=0;i<list.get(0).size();i++){
	if(actionName.equals(list.get(1).get(i))){   
		session.setAttribute("actionName",actionName);
		session.setAttribute("ks",list.get(0).get(i)); 
	} 
  }
}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <script type="text/javascript" src="<%=path %>/js/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=path%>/style/total.css"/>
    <script type="text/javascript" src="<%=path %>/js/banner.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=path%>/style/news_total.css"/>
    <link rel="stylesheet" type="text/css" href="<%=path%>/style/news_page.css"/>
    <title>查询工具</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<SCRIPT type="text/javascript">
function changeHubcode(){
	var countryCode = document.getElementById("countryCode").value;
	document.getElementById("hubcode").value = countryCode;
	var hubcode = document.getElementById("hubcode").value;
	   if(!(hubcode==null || hubcode == "")){ 
		 $.ajax({
			type: "post",
			url:  "getCountryCodeByHubCode",
			data: {hubcode:hubcode},
			success: function (data) {
				$("#country").val(data);
			}
		});
	  }	
}

function loadHubCode(){
	var country = document.getElementById("country").value;
	   if(!(country==null || country == "")){ 
		 $.ajax({
			type: "post",
			url:  "getHubCodeByCountryName",
			data: {country:country},
			success: function (data) {
				$("#hubcode").val(data);
				changeCountry();
			}
		});
	  }	
}

//键盘监听
document.onkeyup = function (e){
	var code;
	if (!e){
		var e = window.event;
	} 
	if (e.keyCode){
		code = e.keyCode; //IE
	}else if (e.which){
		code = e.which; //FF
	} 
	var act = document.activeElement.id;  //获得焦点的ID	
	if(act=="destination_2"){		
		var CL=document.getElementById("CountryList");
		var obj=document.getElementById("destination_2");	
		CL.style.display="none";		
		selectCityList(obj);		
	}
}
//判断字符串是否为空
function isNull( str ){
	if ( str == "" ) return true;
	var regu = "^[ ]+$";
	var re = new RegExp(regu);
	return re.test(str);
}
//获取字段长度
function GetLength(str) {	 
	  var len = str.length,realLength;
	  realLength=len*10;
	  return realLength;
}
//匹配下拉框
function selectCityList(obj){	
	var CS=document.getElementById("CountryListSelect");
	var str=obj.value;
	var strContent="<table width='100%'  cellpadding='0' cellspacing='0'>";
	var array=achieveAllCity();//arrayCH:CH,arrayCN:CN,arrayCE:CE
	var arrayCH=array.arrayCH;
	var arrayCN=array.arrayCN;
	var arrayCE=array.arrayCE;
	var arrayText=new Array();	
	if(isNull(str)){
		CS.style.display="none";
		return;
	}
	/*包含某个字符串
	for(var i=0;i<arrayCH.length;i++){
		if(arrayCN[i].search(str)!=-1||arrayCE[i].search(str)!=-1){
			arrayText.push(arrayCN[i]+"("+arrayCH[i]+")"+arrayCE[i]);
		}
	}
	*/
	for(var i=0;i<arrayCH.length;i++){
		if(arrayCN[i].indexOf(str)==0||arrayCE[i].indexOf(str)==0){
			arrayText.push(arrayCN[i]+"("+arrayCH[i]+")"+arrayCE[i]);
		}
	}
	if(arrayText.length==0){
		CS.style.display="none";	
		return;
	}
	var width=150;
	var strLength;
	for(var i=0;i<arrayText.length;i++){
		strContent+="<tr height='20px'><td  onclick='Assignment(this);' style='padding-left:8px'>"+arrayText[i]+"</td></tr>";
		strLength=GetLength(arrayText[i]);		
		if(strLength>width){
			width=strLength;
		}
	}
	strContent+="</table>";	
	CS.style.height=arrayText.length*20;
	CS.style.width=width;	
	CS.innerHTML=strContent;
	CS.style.top=getElementOffset(obj).top+23;
	CS.style.left=getElementOffset(obj).left;
	CS.style.display="block";
}
//判断鼠标位置
function decideMouse(){
	var bool=true;
	var ev= ev || window.event;	
	var mousePos = mouseCoords(ev);	
	var CT=document.getElementById("CountryCityListShow");
	var pos=getElementOffset(CT);	
	if(mousePos.x>=pos.left&&mousePos.x<=(pos.left+550)&&mousePos.y>=pos.top&&mousePos.y<=(pos.top+pos.height)){		
		bool=false;
	}	
	return bool;
}
//获取元素坐标
function getElementOffset(e)
{
	var t = e.offsetTop;
	var l = e.offsetLeft;
	var w = e.offsetWidth;
	var h = e.offsetHeight-1;

	while(e=e.offsetParent) {
		t+=e.offsetTop;
		l+=e.offsetLeft;
	}
	return {top : t,left : l,width : w,height : h}
}
//获取鼠标坐标
function mouseCoords(ev) 
{ 
	if(ev.pageX || ev.pageY){		 
		return {x:ev.pageX, y:ev.pageY}; 
	}	
	if(document.body.scrollTop!=0||document.body.scrollLeft!=0||document.body.clientLeft!=0||document.body.clientTop!=0){
		return { 
			x:ev.clientX + document.body.scrollLeft - document.body.clientLeft, 
			y:ev.clientY + document.body.scrollTop - document.body.clientTop 
			};
	}

	if(document.documentElement.scrollTop!=0||document.documentElement.scrollLeft!=0||document.documentElement.clientLeft!=0||document.documentElement.clientTop!=0){
		return { 
			x:ev.clientX + document.documentElement.scrollLeft - document.documentElement.clientLeft, 
			y:ev.clientY + document.documentElement.scrollTop - document.documentElement.clientTop 
			}; 
	}
	return{
		x:ev.clientX, 
		y:ev.clientY 
	}		
	
	
} 
//选择框初始化
function setLeft(obj){	
	var CL=document.getElementById("CountryList");
	var CT=document.getElementById("CountryTitie");	
	var list=["A","B","C","D","E","F","G","H","I","J","K","L","M","N","P","Q","R","S","T","U","V","Y","Z"];//O W X没有对应国家
	var str="";	
	for(var i=0;i<list.length;i++){
		str+="<a onclick='changeContent(this);'>"+list[i]+"</a>&nbsp;&nbsp;&nbsp;&nbsp;";
	}	
	selectCity("A");	
	CT.innerHTML=str;		
	CL.style.top=getElementOffset(obj).top+23;	
	CL.style.left=getElementOffset(obj).left-430;//obj.offsetLeft;
	CL.style.display="block";	
}
//更改div内容
function changeContent(obj){
	selectCity(obj.innerText);	
}
//隐藏div模块
function setPlay(){
	var CL=document.getElementById("CountryList");	
	if(decideMouse()){	
		CL.style.display="none";
	}
}
//获取数据信息
function achieveAllCity(){
	var CS=document.getElementById("CountryListSorting");
	var CH=document.getElementById("countryDtdt_hubcode").value;
	CH=CH.substring(1,CH.length-1).split(",")
	var CN=document.getElementById("countryDtdt_name").value;
	CN=CN.substring(1,CN.length-1).split(",")
	var CE=document.getElementById("countryDtdt_ename").value;
	//转义
	CE=CE.replace("NAURU, REPUBLIC OF","NAURU&#44 REPUBLIC OF");
	CE=CE.replace("MICRONESIA, FEDERATED STATES OF","MICRONESIA&#44 FEDERATED STATES OF");
	CE=CE.replace("MACEDONIA, REPUBLIC OF","MACEDONIA&#44 REPUBLIC OF");
	CE=CE.replace("PHILIPPINES, THE","PHILIPPINES&#44 THE");
	CE=CE.replace("SOMALILAND, REP OF (NORTH SOMALIA)","SOMALILAND&#44 REP OF (NORTH SOMALIA)");
	CE=CE.replace("RUSSIAN FEDERATION, THE","RUSSIAN FEDERATION&#44 THE");
	CE=CE.replace("YEMEN, REPUBLIC OF","YEMEN&#44 REPUBLIC OF");
	CE=CE.replace("CONGO, THE DEMOCRATIC REPUBLIC OF","CONGO&#44 THE DEMOCRATIC REPUBLIC OF");
	CE=CE.replace("IRELAND, REPUBLIC OF","IRELAND&#44 REPUBLIC OF");
	CE=CE.replace("KOREA, THE D.P.R OF","KOREA&#44 THE D.P.R OF");
	CE=CE.replace("NETHERLANDS, THE","NETHERLANDS&#44 THE");
	CE=CE.replace("REUNION, ISLAND OF","REUNION&#44 ISLAND OF");
	CE=CE.replace("SERBIA, REPUBLIC OF","SERBIA&#44 REPUBLIC OF");
	CE=CE.replace("CZECH REPUBLIC, THE","CZECH REPUBLIC&#44 THE");
	CE=CE.replace("CANARY ISLANDS, THE","CANARY ISLANDS&#44 THE");
	CE=CE.replace("KOREA, REPUBLIC OF","KOREA&#44 REPUBLIC OF");
	CE=CE.replace("MOLDOVA, REPUBLIC OF","MOLDOVA&#44 REPUBLIC OF");
	CE=CE.replace("MONTENEGRO, REPUBLIC OF","MONTENEGRO&#44 REPUBLIC OF");
	CE=CE.substring(1,CE.length-1).split(",")

	for(var i=0;i<CH.length;i++){			
		while(CH[i].indexOf(" ")==0){
			CH[i]=CH[i].substring(1,CH[i].length);
		}
		while(CN[i].indexOf(" ")==0){
			CN[i]=CN[i].substring(1,CN[i].length);
		}		
		while(CE[i].indexOf(" ")==0){
			CE[i]=CE[i].substring(1,CE[i].length);			
		}			
	}
	return {arrayCH:CH,arrayCN:CN,arrayCE:CE};	
}
//查找匹配国家
function selectCity(str){
	var CLS=document.getElementById("CountryListSelect");
	var CS=document.getElementById("CountryListSorting");
	
	var CH=document.getElementById("countryDtdt_hubcode").value;	
	CH=CH.substring(1,CH.length-1).split(",")
	
	var CN=document.getElementById("countryDtdt_name").value;	
	CN=CN.substring(1,CN.length-1).split(",")
	
	var CE=document.getElementById("countryDtdt_ename").value;
	//转义
	CE=CE.replace("NAURU, REPUBLIC OF","NAURU&#44 REPUBLIC OF");
	CE=CE.replace("MICRONESIA, FEDERATED STATES OF","MICRONESIA&#44 FEDERATED STATES OF");
	CE=CE.replace("MACEDONIA, REPUBLIC OF","MACEDONIA&#44 REPUBLIC OF");
	CE=CE.replace("PHILIPPINES, THE","PHILIPPINES&#44 THE");
	CE=CE.replace("SOMALILAND, REP OF (NORTH SOMALIA)","SOMALILAND&#44 REP OF (NORTH SOMALIA)");
	CE=CE.replace("RUSSIAN FEDERATION, THE","RUSSIAN FEDERATION&#44 THE");
	CE=CE.replace("YEMEN, REPUBLIC OF","YEMEN&#44 REPUBLIC OF");
	CE=CE.replace("CONGO, THE DEMOCRATIC REPUBLIC OF","CONGO&#44 THE DEMOCRATIC REPUBLIC OF");
	CE=CE.replace("IRELAND, REPUBLIC OF","IRELAND&#44 REPUBLIC OF");
	CE=CE.replace("KOREA, THE D.P.R OF","KOREA&#44 THE D.P.R OF");
	CE=CE.replace("NETHERLANDS, THE","NETHERLANDS&#44 THE");
	CE=CE.replace("REUNION, ISLAND OF","REUNION&#44 ISLAND OF");
	CE=CE.replace("SERBIA, REPUBLIC OF","SERBIA&#44 REPUBLIC OF");
	CE=CE.replace("CZECH REPUBLIC, THE","CZECH REPUBLIC&#44 THE");
	CE=CE.replace("CANARY ISLANDS, THE","CANARY ISLANDS&#44 THE");
	CE=CE.replace("KOREA, REPUBLIC OF","KOREA&#44 REPUBLIC OF");
	CE=CE.replace("MOLDOVA, REPUBLIC OF","MOLDOVA&#44 REPUBLIC OF");
	CE=CE.replace("MONTENEGRO, REPUBLIC OF","MONTENEGRO&#44 REPUBLIC OF");	
	
	CE=CE.substring(1,CE.length-1).split(",");
	
	var CTL=document.getElementById("CountryList");
		
	var counStr="";
	CLS.style.display="none";
	
	for(var i=0;i<CH.length;i++){			
		while(CH[i].indexOf(" ")==0){
			CH[i]=CH[i].substring(1,CH[i].length);
		}
		while(CN[i].indexOf(" ")==0){
			CN[i]=CN[i].substring(1,CN[i].length);
		}		
		while(CE[i].indexOf(" ")==0){
			CE[i]=CE[i].substring(1,CE[i].length);			
		}			
	}
	var arrayCH = new Array();
	var arrayCN = new Array();
	var arrayCE = new Array();
	for(var i=0;i<CH.length;i++){					
		if(str==CE[i].charAt(0)){
			arrayCH.push(CH[i]);
			arrayCN.push(CN[i]);
			arrayCE.push(CE[i]);
		}
	}
	counStr="<table width='100%'cellpadding='0' cellspacing='0' >";	
	for(var i=0;i<arrayCH.length;i++){						
			if((i+1)%2==0){
				counStr+="<td><span onclick='Assignment(this);' style='padding-left:5px'>"+arrayCN[i]+"<span class='ezdm'>("+arrayCH[i]+")</span><span class='ywm'>"+arrayCE[i]+"</span></span></td></tr>";
			}else if(arrayCH.length%2==1&&(i+1)==arrayCH.length){
				counStr+="<tr height='25px'><td><span onclick='Assignment(this);' style='padding-left:5px'>"+arrayCN[i]+"<span class='ezdm'>("+arrayCH[i]+")</span><span class='ywm'>"+arrayCE[i]+"</span></span></td><td></td></tr>";
			}else{
				counStr+="<tr height='25px'><td weidth='50%'><span onclick='Assignment(this);' style='padding-left:5px'>"+arrayCN[i]+"<span class='ezdm'>("+arrayCH[i]+")</span><span class='ywm'>"+arrayCE[i]+"</span></span></td>";
			}			
	}
	counStr+="</table>";	
	if(arrayCH.length%2==0){
		CTL.style.height=arrayCH.length*25/2+30;
	}else{
		CTL.style.height=arrayCH.length*25/2+25+30;
	}
	
	CS.innerHTML=counStr;	
}
//选定国家赋值
function Assignment(obj){
	var str=obj.innerText;
	str=str.replace("VIRGIN ISLANDS (US),VIRGIN ISLANDS &#40US&#41");
	str=str.replace("SOMALILAND, REP OF (NORTH SOMALIA),SOMALILAND, REP OF &#40NORTH SOMALIA&#41");	
	str=str.replace("VIRGIN ISLANDS (BRITISH),VIRGIN ISLANDS &#40BRITISH&#41");	
	str=str.replace("IRAN (ISLAMIC REPUBLIC OF),IRAN &#40ISLAMIC REPUBLIC OF&#41");
	str=str.replace("GUYANA (BRITISH),GUYANA &#40BRITISH&#41");	

	var str1,str2;
	str1=str.substring(str.lastIndexOf(")")+1,str.length);
	str2=str.substring(str.lastIndexOf("(")+1,str.lastIndexOf(")"));	
	document.getElementById("destination_2").value=str1;
	document.getElementById("countryCode").value=str2;
	document.getElementById("hubcode").value=str2;
	document.getElementById("CountryList").style.display="none";
	document.getElementById("CountryListSelect").style.display="none";	
	
}     

function changeCountry(){
	var Dtdt_hubcode = document.getElementById("hubcode").value;
	document.getElementById("countryCode").value = Dtdt_hubcode.toUpperCase();
	changeHubcode();
}
function checkNull(check_var) {
		if (check_var == null || check_var.length == 0 ||check_var == "请在此输入您的订单号/代理单号/跟踪号，最多支持五个订单号的查询。输入多个订单号，请用“,”分隔 。")
			return true;
		else
			return false;
	}


//轨迹查询验证
function checkTrackForm() {
	var queryCode = document.getElementById("queryCode").value;
	if (checkNull(queryCode)) {
		alert("运单号不为能空，请输入运单号!");
		return false;
	}
	if(!checkVlidateCode()){
	document.getElementById("error_msg").innerHTML="验证码错误 ,请重新输入!"
	return false;
	}
	
	document.queryTrackForm.submit();
}

function changeValidateCode(obj) 
		{
	    //获取当前的时间作为参数，无具体意义




	    var timenow = new Date().getTime();
	    //每次请求需要一个不同的参数，否则可能会返回同样的验证码
	    //可能和浏览器的缓存机制有关系
	    obj.src="util/ValidateImage?d="+timenow;
   	 	}
   	 	function clearInfo()
    	{
	    document.getElementById("userName").value = "";
	    document.getElementById("password").value = "";
	    document.getElementById("validateCode").value = "";	    
		}


function toTrack(){
$("#div_remote").hide();
$("#div_airport").hide();
$("#div_track").show();
}
function toAirport(){
$("#div_track").hide();
$("#div_remote").hide();
$("#div_airport").show();
}
function toRemote(){
$("#div_track").hide();
$("#div_airport").hide();
$("#div_remote").show();
}
function checkVlidateCode(){
var bool = true;
 $.ajax({     
            type: "Post",     
            url: "ajaxCheckValiteCode",  
            async: false,
            data:{validateCode:$("#validateCode").val()},     
            success: function(data) {    
                if(data=='N'){
                     bool = false;
              }
          }    
         });
         return bool;
       }

</SCRIPT>
 </head>
 <style>

a{color:#333333;text-decoration:none;}
.pageNav { text-align:right; margin-top:10px; height:26px; padding:3px 0px;color: #000000;}
.pageNav a { display:inline; border:1px solid #ccc; height:20px; line-height:20px; margin-left:5px; padding:2px 7px;}
.pageNav a:hover { border:1px solid #3a739d; text-decoration:none; color:#3a739d; background:#f6fbff;}

 /*------运费测算------*/
.freight{ width:860px; padding-top:10px;}
.freight .nir{ width:818px; border:1px solid #dedede; background:#f8f8f8; padding:20px 20px 5px;}
.freight table tr td{ padding-bottom:15px;}
.long_result{width: 860px; height: 335px; margin-top:10px;}
.long_result table{ border-collapse:collapse; }
.long_result table tr td{ padding:5px 0; border:1px solid #ddd; text-align:center;}
.r_title{ width:725px; height:35px; line-height:35px; background:url(<%=path%>/images/r_title.jpg); padding-left:15px; color:#FFF; font-size:14px; font-weight:bold;}
.buttonbg{ color:#FFF; width:69px; height:27px; line-height:27px; background:url(<%=path%>/images/button_bg.png); border:none; }
 </style>
 		<script type="text/javascript">
		function changeHubcode(){
			var countryCode = document.getElementById("countryCode"). value;
			document.getElementById("hubcode").value = countryCode;
		}
		function insertTr(count){
			var a="${listPieces[i].cpcplength}";
			var tab="<div class='r_title' id='r_title'>货件信息</div>"+
			"<table width='725' id='tablecode'>"+
				"<thead><tr style='background:#edf8fd;'>"+
						"<td width='105px'>序号</td>"+
						"<td width='105px'>长度(cm)</td>"+
						"<td width='105px'>宽度(cm)</td>"+
						"<td width='105px'>高度(cm)</td>"+
						"<td width='105px'>操作</td></tr></thead>";
				
			var txt1="";
			for(var i=0;i<count;i++){			 
				txt1=txt1+"<tr>"+
				"<td align='center'>"+(i+1)+"</td>"+
				"<td align='center'><input  type='text' onkeyup='clearNoNum(this)' style='border:0px;width:170px;text-align:center;' name='"+"length"+(i+1)+"'></td>"+
				"<td align='center'><input  type='text' onkeyup='clearNoNum(this)' style='border:0px;width:170px;text-align:center;' name='"+"width"+(i+1)+"'></td>"+
				"<td align='center'><input  type='text' onkeyup='clearNoNum(this)' style='border:0px;width:170px;text-align:center;' name='"+"height"+(i+1)+"'></td>"+
				"<td align='left'><input  type='button' onclick='deleteTr(this);' value='删除'; style='background:#edf8fd;width:30px;'></td>"+
				"</tr>";
			}
			txt1="<tbody>"+txt1+"</tbody>"
			var table1=tab+txt1+"</table>"
			document.getElementById("goods").innerHTML=table1;
		}
		function deleteTr(obj){
			var tr=obj.parentNode.parentNode;//得到按钮[obj]的父元素[td]的父元素[tr]
 			tr.parentNode.removeChild(tr);//从tr的父元素[tbody]移除tr
		}
		
		
		/*小数的js验证 */
		function clearNoNum(obj){
			//先把非数字的都替换掉，除了数字和.
			obj.value = obj.value.replace(/[^\d.]/g,"");
			//必须保证第一个为数字而不是.
			obj.value = obj.value.replace(/^\./g,"");
			//保证只有出现一个.而没有多个.
			obj.value = obj.value.replace(/\.{2,}/g,".");
			//保证.只出现一次，而不能出现两次以上



			obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
			if(obj.id=="num"){
				insertTr(obj.value);
			}
		}
		function check(){
			var countryCode=document.getElementById("countryCode").value;
			var Grossweight=document.getElementById("Grossweight").value;
			var num=document.getElementById("num").value;
			if(countryCode==""){
				alert("请选择目的国家");
				return false;
			}
			if(Grossweight==""){
				alert("请填写货物重量");
				return false;
			}
			if(num==""){
				alert("请填写货物件数");
				return false;
			}
			return true;
		}
		function costBudget(){
			if(check()){
				document.getElementById("myform").action="${pageContext.request.contextPath}/costBudgetIndex";
				document.getElementById("myform").submit();
			}
		}
		//刷新
		function doReset(){
			document.getElementById("myform").action="${pageContext.request.contextPath}/costBudgetIndex?op=budget";
			document.getElementById("myform").submit();
		}
		function changeCountry(){
			var Dtdt_hubcode = document.getElementById("hubcode").value;
			document.getElementById("countryCode").value = Dtdt_hubcode.toUpperCase();
			changeHubcode();
		}
	</script>
  
<body onload="changeTopmenu(1,650)">
<div id="main">
  <div id="top">
    <div class="top">
      <div class="window">
        <div class="left"></div>
       <div class="right"><span><a href="<%=path%>/login.jsp">登录</a></span> | <span><a href="<%=path%>/register.jsp">注册</a></span> | <span><a href="${pageContext.request.contextPath }/op/recharge.jsp">充值</a></span> | <span><a href="#">English</a></span></div>
      </div>
      <div class="logo">
        <div class="left"><img src="images/logo.jpg" /></div>
        <div class="right"><img src="images/tel.jpg" /></div>
      </div>
      <div class="nav">
      <jsp:include page="../include/main_menu.jsp"></jsp:include>
        <div class="nav_last"><a href="${pageContext.request.contextPath }/userinfo"><img src="${pageContext.request.contextPath }/images/my_nav.jpg"></a></div>
      </div>
    </div>
    <div class="banner_bg">
      <div class="banner">
        <ul class="nav_img">
          <li><a href=""><img src="images/banner.jpg" alt=""></a></li>
          <li><a href=""><img src="images/banner.jpg" alt=""></a></li>
          <li><a href=""><img src="images/banner.jpg" alt=""></a></li>
        </ul>
        <ul class="nav_banner">
          <li ><a title="" href=""></a></li>
          <li><a title="" href=""></a></li>
          <li><a title="" href=""></a></li>
        </ul>
      </div>
    </div>
  </div>
  <div id="page">
    <div class="left">
      <div class="directory"> <span class="tit01"></span>
        <div class="nir">
          <ul id="left_menu">
           <s:iterator var="bean" value="@com.daiyun.dax.WebDemand@SMquery(#session.ks)"> 
            <li><a id="<s:property value="#bean.Gmgm_code"/>" href="<s:property value="#session.actionName"/>?code=<s:property value="#bean.Gmgm_code"/>"><s:property value="#bean.Gmgm_name"/></a></li>
          	</s:iterator>
          </ul>       
        </div>
      </div>
      <div class="contact"> <span class="tit"></span>
        <div class="nir"> <img src="images/contact01.jpg" />
          <p> 总  机：（86-755）88888888<br />
            &nbsp;&nbsp;&nbsp; （86-755）88888888<br />
            传  真： 0752-88888888<br />
            地  址：*************************<br />
            &nbsp;&nbsp;&nbsp;&nbsp;**************<br />
          </p>
        </div>
      </div>
    </div>
    <s:set var="key" value="#request.gmcode"/>
    <s:set var="action" value="@com.daiyun.dax.WebDemand@getAction()"/>
    <form  id="myform" method="post" action="<s:property value="#action[#key]"/>">
    <s:if test="#request.gmcode == @com.daiyun.dax.WebDemand@STquery('J0101')">
   <div class="right" id="div_track">
      <div class="track">
        <div class="tit">轨迹查询</div>
        <input name="gmcode" type="hidden" value="ts">
        <div class="nir">
        <input type="hidden" name="gmcode1" value="${gmcode}" />   
          <div class="track_left">
            <textarea name="queryCode" id="queryCode" class="input_3" onfocus="if(value==defaultValue){value='';this.style.color='#666'}" onblur="if(!value){value=defaultValue;this.style.color='#666'}" style="color: rgb(153, 153, 153);">请在此输入您的订单号/代理单号/跟踪号，最多支持五个订单号的查询。输入多个订单号，请用“,”分隔 。</textarea>
            <input id="validateCode" name="validateCode" value="验证码" onfocus="if(value==defaultValue){value='';this.style.color='#666'}" onblur="if(!value){value=defaultValue;this.style.color='#666'}"  style="color: rgb(153, 153, 153);" />
            <span><img src="util/ValidateImage?d=<%= new Date().getTime() %>" onClick="changeValidateCode(this)" style="float:left;margin-left:-10px;margin-top:2.5px;width:40px;height:20px" /></span><span id="error_msg" style="float:right;margin-top:-24px;margin-left:-20px;font-size:13px;width:200px"></span>
            <button class="check_but"  type="submit" onclick="return checkTrackForm();"></button>
          </div>
          <div class="track_center">最近查询记录</div>
          <div class="track_right" id="clearlist">清空列表</div>
        </div>
      </div>
      <div class="result">
      <div class="tit">追踪结果</div>
      <div class="nir"></div>
      </div>
      <div class="result">
      <div class="tit">实时状态</div>
      <div class="nir"></div>
      </div>
    </div>
    </s:if>
   <s:if test="#request.gmcode == @com.daiyun.dax.WebDemand@STquery('J0102')">
   <s:set var="action" value="@com.daiyun.dax.WebDemand@getAction()"/>
    <div class="right" id="div_airport">  
      <div class="tit01">机场三字码查询</div>
      <div class="nir">
        <div class="airport_td">
        <input type="hidden" name="gmcode1" value="${gmcode}" /> 
          <table width="100%" cellspacing="0" cellpadding="10" border="0">
            <tbody>
              <tr>
                <td><table width="100%" cellspacing="0" cellpadding="5" border="0">
                    <tbody>
                      <tr>
                        <td align="right"> 三字代码 :&nbsp; </td>
                        <td>
                          <input name="ddHubCode" id="txtCountry" class="td_input ac_input" autocomplete="off" type="text">
                          <input name="gmcode" type="hidden" value="as">
                        </td>
                        <td align="right"> 机场英文名： </td>
                        <td>
                          <input name="ddCityName" id="txtAirportCode3" class="td_input" style="width: 80px;" type="text">
                          </td>
                        <td align="right"> 机场中文名: </td>
                        <td>
                          <input name="ddCityCName" id="txtAirportNameCh" class="td_input" style="width: 100px;" type="text">
                          </td>
                        <td><input name="btnSearch" value="查询" id="btnSearch" class="airport_but" type="submit"></td>
                      </tr>
                    </tbody>
                  </table>
                  </td>
              </tr>
            </tbody>
          </table>
     
          <s:if test="#request.districtList!=null && #request.districtList.size()!=0">
          <table width="100%" cellspacing="1" cellpadding="5" border="0" bgcolor="#e5e5e5" style="margin-top:20px;">
            <tbody>
              <tr>
                <td width="15%" bgcolor="39bdf1" align="center" style="color:#FFF; font-weight:bold;"> 三字代码 </td>
                <td width="15%" bgcolor="#39bdf1" align="center" style="color:#FFF; font-weight:bold;"> 机场中文名称 </td>
                <td width="20%" bgcolor="#39bdf1" align="center" style="color:#FFF; font-weight:bold;"> 机场英文名称 </td>
                <!--<td width="15%" bgcolor="#39bdf1" align="center" style="color:#FFF; font-weight:bold;"> 所属城市 </td> --> 
                <td width="15%" bgcolor="#39bdf1" align="center" style="color:#FFF; font-weight:bold;"> 所属国家 </td>
              <!--    <td bgcolor="#39bdf1" align="center" style="color:#FFF; font-weight:bold;"> 备注 </td>-->
              </tr>
               <s:iterator value="#request.districtList" var="bean">
              <tr>
                <td bgcolor="#FFFFFF" align="center"> <s:property value="#bean.apap_hubcode"></s:property> </td>
                <td bgcolor="#FFFFFF" align="center"><s:property value="#bean.apap_cname"></s:property> </td>
                <td bgcolor="#FFFFFF" align="center"> <s:property value="#bean.apap_ename"></s:property> </td>
                <!--<td bgcolor="#FFFFFF" align="center"> <s:property value="#bean.dtdt_ename"></s:property> </td>-->
                <td bgcolor="#FFFFFF" align="center"><s:property value="#bean.dtdt_name"></s:property> </td>
               <!--  <td bgcolor="#FFFFFF" align="center"></td>-->
              </tr>
                  </s:iterator>
            </tbody>
          </table>
          <div class="pageNav">
             <p:pager url="cityAccesspossTool" />
	 <s:set var="Page" value="#request.objPageConfig"></s:set>
          
        </div>
          </s:if>
          <s:elseif test="#request.districtList!=null && #request.districtList.size()==0"><font color="red" size="2">查询无结果</font></s:elseif>
        </div>
      </div>
    
    </div>   
    </s:if>
    <s:if test="#request.gmcode == @com.daiyun.dax.WebDemand@STquery('J0103')">
    <div class="right" id="div_remote">
      <div class="tit01">偏远查询</div>
      <div class="nir">
        <div class="airport_td">
        <input type="hidden" name="gmcode1" value="${gmcode}" /> 
          <table width="100%" cellspacing="0" cellpadding="10" border="0">
            <tbody>
              <tr>
                <td><table width="100%" cellspacing="0" cellpadding="5" border="0">
                    <tbody>
                      <tr>
                        <td align="right"> 国家 :&nbsp; </td>
                        <td>
                          <input name="country" id="country" class="td_input  " autocomplete="off" type="text" onblur="loadHubCode()" value="<s:property value='#request.country'/>"/> 
                        </td>
                        <td align="right" > 二字代码 ： </td>
                        <td>
                          <input name="Dtdt_hubcode" id="hubcode" onchange="changeCountry()" class="td_input" style="width: 80px;" type="text" value="<s:property value='#request.hubcode'/>">
                          <input name="gmcode" type="hidden" value="dt">
                          </td>
                        <td align="right"   > 国家(英文名)： </td>
                       
                        <td>
                          <input name="ddCityCName" onclick="setLeft(this);" onblur="setPlay();" value="<s:property value="@com.daiyun.dax.CountryDemand@getDtcodeByHubcode(#request.hubcode)"/>" id="destination_2" class="td_input" style="width: 100px;" type="text">
                         <input type="hidden" name="Dtdt_name" id="countryCode" value="" > 
                          </td>
                           </tr><tr>
                           <td align="right"> 城市： </td>
                        <td>
                          <input name="strCityname" id="strCityname" class="td_input ac_input"  type="text" value="${strCityname}">
                          </td>
                           <td align="right"> 邮编：</td>
                        <td>
                          <input name="strPostcode" id="strPostcode" class="td_input" style="width: 80px;" type="text" value="${strPostcode}">
                          </td>
                        <td><input name="btnSearch" value="查询" id="btnSearch" class="airport_but" type="submit"></td>
                      </tr>
                    </tbody>
                  </table>
                  <s:if test="#request.gmcode == null"></s:if>
		 <s:elseif test="#request.listAction.size()==0">查询结果:<font color="red" size="2">该地区不是偏远地区</font></s:elseif>		
		<s:elseif test="#request.listAction != null && #request.listAction.size()!= 0">		  
		<table style="width: 700px;">
			<tr>	 
 				<td style="width: 30%;"><strong>国家</strong></td>					
				<td style="width: 35%;"><strong>城市</strong></td>
				<td style="width: 35%;"><strong>邮编</strong></td>
			</tr>
		<tbody id="info">
			<s:iterator var="bean" value="#request.listAction">
				<tr>
					<td><s:property value="#request.country" /></td>
					<td><s:property value="#bean.drddrd_cityname" /></td>	
					<td><s:property value="#bean.drddrd_postcode" /></td>					
				</tr>
			</s:iterator>
		</tbody>
		</table>     	  	  	  
    	</s:elseif>
                </td>
              </tr>
            </tbody>
          </table>
          <div   id="CountryListSelect" style="display:none;float:center;border:1px solid #f1f1f1;z-index: 9999;position:absolute;background-color:#ffffff;">
        	
           </div>
        <div onmouseout="setPlay()"  id="CountryList" style="display:none;float:center;border:1px solid #f1f1f1;width:550px;z-index: 9999;position:absolute;background-color:#ffffff;">
        	<s:set var="countryValue" value="@kyle.leis.fs.dictionary.district.dax.DistrictDemand@queryCountry('DHL')"/>        				
        	<input id="countryDtdt_hubcode" type="hidden" value="<s:property value='#countryValue.{Dtdt_hubcode}'/>"/>
        	<input id="countryDtdt_name" type="hidden" value="<s:property value='#countryValue.{Dtdt_name}'/>"/>
        	<input id="countryDtdt_ename" type="hidden" value="<s:property value='#countryValue.{Dtdt_ename}'/>"/>
        	
        	<table   id="CountryCityListShow" style="paddging:0px;border-collapse:collapse;cellpadding:0; cellspacing:0" align="center" width="100%">
        		<tr>
        			<td id="CountryTitie" >
        				
        			</td>
        		</tr>
        		<tr>
        			<td id="CountryListSorting">     				
        				     				
        			</td>
        		</tr>
        		
        	</table>
	  </div>    
         
     </div>
        </div>
      </div>
      </s:if>
      <s:if test="#request.gmcode == @com.daiyun.dax.WebDemand@STquery('J0105')">
    <div class="right" id="div_golbeairport">
      <div class="tit01">全球航空公司查询</div>
      <div class="nir">
        <div class="airport_td">
        <input type="hidden" name="gmcode1" value="${gmcode}" /> 
          <table width="100%" cellspacing="0" cellpadding="10" border="0">
            <tbody>
              <tr>
                <td><table width="100%" cellspacing="0" cellpadding="5" border="0">
                    <tbody>
                      <tr>
                        <td align="right"> 航空公司二字代码 :&nbsp; </td>
                        <td>
                          <input name="Achubcode" id="Achubcode" class="td_input ac_input" autocomplete="off" type="text">
                          <input name="gmcode" type="hidden" value="as">
                        </td>
                        <td align="right"> 航空公司三字代码： </td>
                        <td>
                          <input name="Acthreehubcode" id="Acthreehubcode" class="td_input ac_input"  type="text">
                          </td>
                      </tr>
                      <tr>
                      <td align="right"> 机场中文名 :&nbsp; </td>
                        <td>
                          <input name="Accname" id="Accname" class="td_input ac_input"  type="text">
                          </td>
                          <td align="right"> 机场英文名:&nbsp;  </td>
                        <td>
                          <input name="Acename" id="Acename" class="td_input ac_input"  type="text">
                          </td>
                      
                      
                      </tr>
                      <tr> <td><input name="btnSearch" value="查询" id="btnSearch" class="airport_but" type="submit"></td></tr>
                    </tbody>
                  </table>
                  </td>
              </tr>
            </tbody>
          </table>
        
          <s:if test="#request.districtList!=null && #request.districtList.size()!=0">
          <table width="100%" cellspacing="1" cellpadding="5" border="0" bgcolor="#e5e5e5" style="margin-top:20px;">
            <tbody>
              <tr>
                <td width="15%" bgcolor="39bdf1" align="center" style="color:#FFF; font-weight:bold;"> 中文名称 </td>
                <td width="15%" bgcolor="#39bdf1" align="center" style="color:#FFF; font-weight:bold;"> 2位码 </td>
                <td width="20%" bgcolor="#39bdf1" align="center" style="color:#FFF; font-weight:bold;"> 3位码 </td>
                <!--<td width="15%" bgcolor="#39bdf1" align="center" style="color:#FFF; font-weight:bold;"> 所属城市 </td> --> 
                <td width="15%" bgcolor="#39bdf1" align="center" style="color:#FFF; font-weight:bold;"> 英文名称 </td>
              <!--    <td bgcolor="#39bdf1" align="center" style="color:#FFF; font-weight:bold;"> 备注 </td>-->
              </tr>
               <s:iterator var="bean" value="#request.listAction">
              <tr>
                <td bgcolor="#FFFFFF" align="center"> <s:property value="#bean.acac_cname"></s:property> </td>
                <td bgcolor="#FFFFFF" align="center"><s:property value="#bean.acac_hubcode"></s:property> </td>
                <td bgcolor="#FFFFFF" align="center"> <s:property value="#bean.acac_threehubcode"></s:property> </td>
                <!--<td bgcolor="#FFFFFF" align="center"> <s:property value="#bean.dtdt_ename"></s:property> </td>-->
                <td bgcolor="#FFFFFF" align="center"><s:property value="#bean.acac_ename"></s:property> </td>
               <!--  <td bgcolor="#FFFFFF" align="center"></td>-->
              </tr>
                  </s:iterator>
            </tbody>
          </table>
          <div class="pageNav">
             <p:pager url="airwayCompanyTool" />
	 <s:set var="Page" value="#request.objPageConfig"></s:set>    
        </div>
          </s:if>
          <s:elseif test="#request.districtList!=null && #request.districtList.size()==0"><font color="red" size="2">查询无结果</font></s:elseif>
        </div>
      </div>
    
    </div>   
    </s:if>
    
         <s:if test="#request.gmcode == @com.daiyun.dax.WebDemand@STquery('J0106')">
    <div class="right" id="div_golbeairport">
      <div class="tit01">燃油附加费查询</div>
      <div class="nir">
         <s:set var="content" value="#bulbean.Blblcontent"></s:set>
          <div class="article">
          ${content} 
            </div>
      </div>
    
    </div>   
    </s:if>
    
      <s:if test="#request.gmcode == @com.daiyun.dax.WebDemand@STquery('J0107')">
    <div class="right" id="div_golbeairport">
      <div class="tit01">港口查询</div>
      <div class="nir">
        <div class="airport_td">
        <input type="hidden" name="gmcode1" value="${gmcode}" /> 
          <table width="100%" cellspacing="0" cellpadding="10" border="0">
            <tbody>
              <tr>
                <td><table width="100%" cellspacing="0" cellpadding="5" border="0">
                    <tbody>
                      <tr>
                        <td align="right"> 港口英文名 :&nbsp; </td>
                        <td>
                          <input name="ddPortEName" id="ddPortEName" class="td_input ac_input" autocomplete="off" type="text">
                          <input name="gmcode" type="hidden" value="as">
                        </td>
                        <td align="right"> 港口中文名： </td>
                        <td>
                          <input name="ddPortCName" id="ddPortCName" class="td_input ac_input"  type="text">
                          </td>
                      </tr>
                      <tr> <td><input name="btnSearch" value="查询" id="btnSearch" class="airport_but" type="submit"></td></tr>
                    </tbody>
                  </table>
                  </td>
              </tr>
            </tbody>
          </table>
          <s:if test="#request.listAction != null && #request.listAction.size() != 0">
          <table width="100%" cellspacing="1" cellpadding="5" border="0" bgcolor="#e5e5e5" style="margin-top:20px;">
            <tbody>
              <tr>
                <td width="15%" bgcolor="39bdf1" align="center" style="color:#FFF; font-weight:bold;">港口英文名 </td>
                <td width="15%" bgcolor="#39bdf1" align="center" style="color:#FFF; font-weight:bold;">港口中文名 </td>
              </tr>
               <s:iterator var="bean" value="#request.listAction">
              <tr>
                <td bgcolor="#FFFFFF" align="center"> <s:property value="#bean.ppt_ename"></s:property> </td>
                <td bgcolor="#FFFFFF" align="center"><s:property value="#bean.ppt_cname"></s:property> </td>
              </tr>
                  </s:iterator>
            </tbody>
          </table>
          <div class="pageNav"> 
             <p:pager url="gangkouQueryTool" />
	 <s:set var="Page" value="#request.objPageConfig"></s:set>    
        </div>
          </s:if>
          <s:elseif test="#request.districtList!=null && #request.districtList.size()==0"><font color="red" size="2">查询无结果</font></s:elseif>
        </div>
      </div>
      
    </div>      
    </s:if>   
     <s:if test="#request.gmcode == @com.daiyun.dax.WebDemand@STquery('J0108')">
    <div class="right" id="div_golbeairport">
      <div class="tit01">运费试算</div>
      <input type="hidden" value="bg" name="op" />
               <div class="freight">
        <div class="nir">
          <table width="818" border="0" id="basic_information">
            <tr>
              <td>物流渠道：

                <select name="Pkcode" id="Pkcode" style="width:300px; height:26px";>
                  	<option value="" selected="selected">--请选择物流渠道--（不选时默认查所有渠道）</option>
									<s:iterator var="pkbean" value="@com.daiyun.dax.ProductkindDemand@getAllProduct()" status="pkindex">
									<s:if test="#request.Pkcode.equals(#pkbean.Pkcode)">								
										<option value="<s:property value='#pkbean.Pkcode'/>"><s:property value="#pkbean.Pkname"/></option>
									</s:if>	
									<s:else>										
										<option value="<s:property value='#pkbean.Pkcode'/>"><s:property value="#pkbean.Pkname"/></option>																		
									</s:else>
									</s:iterator>
									
                </select></td>
             <td style="padding-left:0px;">货物类型： 
				<input  name="Ctctcode" id="Ctctcode1" value="AWPX" checked="checked" type="radio">
                <label for="Ctctcode1" style="padding-right:30px;">包裹</label>
                <input  name="Ctctcode" id="Ctctcode2" value="ADOX" type="radio" />
                <label for="Ctctcode2">文件</label>
                 
			  </td>
          			  </tr>
            <tr>
               <td>目的国家：

               
               <s:if test='#request.dthubcode==null||#request.dthubcode==""'>
									<input  type="text" onClick="setLeft(this);" style="width:100px;height:26px;text-transform:uppercase;margin-right:33px"" id="destination_2" />										
									<input type="hidden" name="Dtdt_hubcode" id="countryCode" value=""/>
							</s:if>
							<s:else>
									<s:iterator var="country" value="@com.daiyun.dax.CountryDemand@queryAllCountry()">
									<s:if test="#request.dthubcode.equals(#country.Dtdt_hubcode)">
										<input type="text" onClick="setLeft(this);" style="width:100px;text-transform:uppercase;margin-right:33px"" id="destination_2" value="<s:property value="#country.Dtdt_name"/>"/>	
										<input type="hidden" name="Dtdt_hubcode" id="countryCode" value="<s:property value="#request.dthubcode"/>"/>									
									</s:if>									
									</s:iterator>							
							</s:else>	 					
 
							<div  id="CountryListSelect" style="display:none;float:center;border:1px solid #f1f1f1;z-index: 9999;position:absolute;background-color:#ffffff;"></div>
						<div onMouseOut="setPlay()"  id="CountryList" style="display:none;float:center;border:1px solid #f1f1f1;width:550px;z-index: 9999;position:absolute;background-color:#ffffff;">
        						<s:set var="countryValue" value="@com.daiyun.dax.CountryDemand@queryAllCountry()"/>        				
        						<input id="countryDtdt_hubcode" type="hidden" value="<s:property value='#countryValue.{Dtdt_hubcode}'/>"/>
        						<input id="countryDtdt_name" type="hidden" value="<s:property value='#countryValue.{Dtdt_name}'/>"/>
        						<input id="countryDtdt_ename" type="hidden" value="<s:property value='#countryValue.{Dtdt_ename}'/>"/>
        	
        					<table   id="CountryCityListShow" style="paddging:0px;border-collapse:collapse;cellpadding:0; cellspacing:0" align="center" width="100%">
        						<tr>
        							<td id="CountryTitie" >
        				
        							</td>
        						</tr>
        						<tr>
        							<td id="CountryListSorting">     				
        				     				
        							</td>
        						</tr>
        		
        					</table>
	  						</div>   
								二字代码：<input type="text" id="hubcode" onClick="setLeft(this);" name="Dtdt_hubcode" style="width:100px;height:26px;text-transform:uppercase" value="<s:property value='#request.dthubcode'/>"/>
								<font color="red">*</font><br/>
        					
        				</td>
              <td style="padding-left:0px;">起运城市：

                <select style="width:100px;height: 26px;margin-right:28px" name="OrginDtcode" >
						<s:if test="#request.OrginDtcode.equals('719')">
						<option value="719" selected="selected">SZX</option>
						</s:if>
						<s:else>
						<option value="719">SZX</option>
						</s:else>
						<s:if test="#request.OrginDtcode.equals('HQB')">
						<option value="HQB" selected="selected">HQB</option>
						</s:if>
						<s:else>
						<option value="HQB">HQB</option>
						</s:else>
				</select>
				<label style="width:200px;height:26px;"></label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <!--    付费方式： <select style="width:100px;height:26px;" name="Pmpmcode" id="Pmpmcode">
						<option value="APP" selected="selected">预付</option>
						<option value="ACC" >到付</option>
						<option value="AFR" >免费</option>
					</select> -->
					</td>
            </tr>
            <tr>
              <td><span style="padding-right:30px;">货物重量：

                <input id="Grossweight" name="Grossweight" type="text"  onkeyup="clearNoNum(this)" style="width:100px;height:26px;margin-right:10px" value="<s:property value='#request.Grossweight'/>" />KG
                 </span> 件数：

                <input type="text" id="num"   name="num" onkeyup="clearNoNum(this)" value="1" style="width:100px;height:26px;margin-right:5px;margin-left: -4px"/></td>
             <!--   <td style="padding-left:33px;">收货网点：<span style="padding-left:8px; color:#d42c96;">根据所填写的发货城市自动计算</span></td>-->
            </tr>
          </table>
        </div>
            </div>
            <div class="goods" id="goods">
        <div class="r_title" id="r_title">货件信息</div>
        <table width="725" id="tablecode">
          <tr style="background:#edf8fd;">
            <td align="center" width="105px">序号</td>
            <td align="center" width="105px">长度(cm)</td>
            <td align="center" width="105px">宽度(cm)</td>
            <td align="center" width="105px">高度(cm)</td>
            <td align="center" width="105px">操作</td>
          </tr>  
          <tr>
			<td align='center'>1</td>
				<td align="center"><input  type="text" onkeyup="clearNoNum(this)" style="border:0px;width:170px;text-align:center;" name="length1"></td>
				<td align="center"><input  type="text" onkeyup="clearNoNum(this)" style="border:0px;width:170px;text-align:center;" name="width1"></td>
				<td align="center"><input  type="text" onkeyup="clearNoNum(this)" style="border:0px;width:170px;text-align:center;" name="height1"></td>
				<td align="center"><input  type="button" onclick="deleteTr(this)" value="删除"; style="background:#edf8fd;width:30px;"></td>
				</tr>
        </table>
      </div>
       <div class="button">
      <button class="buttonbg" value="" type="button" onclick="costBudget();" style="margin:0 292px;font-size:13px;">测算费用</button>
      <button class="buttonbg" value="" type="reset"   style="margin:0 -276px;font-size:13px;">刷新</button>
 
      </div>
      <div class="long_result">
        <table id="attributeval" class="manage_form" style="margin: 0px;table-layout:fixed;" cellspacing="1" cellpadding="0" border="0">
          <thead>
            <tr style="background:#edf8fd;">
              <td width="150">收货产品名称</td>  
              <td width="140">总额</td>
              <td width="200">运费值</td>
              <td width="140">杂费值</td>
              <td width="140">附加费</td>
              <td width="118">货物重量</td>
              <td width="118">实重</td>
              <td width="100">体积重</td>
              <td width="150">体积重系数</td> 
              <td width="140">产品备注</td>
            </tr>
          </thead>
         	<tbody>
				<s:if test="#request.bud.equals('bud')">
					<s:if test="#request.objSaleTrialCalculateResult.size()==0">
						<tr>
							<td colspan="11"><font color="red">请准确填写试算条件信息</font></td>
						</tr>
					</s:if>
				</s:if>
				<s:else>					
					<tr>
						<td colspan="11"><font color="red">显示试算费用结果</font></td>
					</tr>
				</s:else>
				<s:iterator var="salebean" value="#request.objSaleTrialCalculateResult">
				<tr>
					<td><s:property value="#salebean.Pkname"/></td>	
					<td><s:property value="@java.lang.String@format('%.2f',@java.lang.Double@parseDouble(#salebean.Freightvalue)+@java.lang.Double@parseDouble(#salebean.Incidentalvalue)+@java.lang.Double@parseDouble(#salebean.Surchargevalue))"/></td>
					<td><s:property value="#salebean.Freightvalue"/></td>
					<td><s:property value="#salebean.Incidentalvalue"/></td>
					<td><s:property value="#salebean.Surchargevalue"/></td>	
					<td><s:property value="#salebean.Chargeweight"/></td>
					<td><s:property value="#salebean.Grossweight"/></td>
					<td><s:property value="#salebean.Volumeweight"/></td>
					<td><s:property value="#salebean.Volumerate"/></td>			
					<td><s:property value="#salebean.Pkremark"/></td>
				</tr>				
				</s:iterator>				
				</tbody>
        </table>
      </div>
      <!--  <div class="nir">
        <div class="airport_td">
        <input type="hidden" name="gmcode1" value="${gmcode}" /> 
          <table width="100%" cellspacing="0" cellpadding="10" border="0">
            <tbody>
              <tr>
                <td><table width="100%" cellspacing="0" cellpadding="5" border="0">
                    <tbody>
                      <tr>
                        <td align="right"> 起运地 :&nbsp; </td>
                        <td>
                          <input name="ddPortEName" id="ddPortEName" class="td_input ac_input" autocomplete="off" type="text">
                          <input name="gmcode" type="hidden" value="as">
                        </td>
                        <td align="right"> 目的国家： </td>
                        <td>
                          <input name="ddPortCName" id="ddPortCName" class="td_input ac_input"  type="text">
                          </td>
                      </tr>
                       <tr>
                        <td align="right"> 重量 :&nbsp; </td>
                        <td>
                          <input name="ddPortEName" id="ddPortEName" class="td_input ac_input" autocomplete="off" type="text">
                          <input name="gmcode" type="hidden" value="as">
                        </td>
                        <td align="right"> 包裹类型： </td>
                        <td>
                          <input name="ddPortCName" id="ddPortCName" class="td_input ac_input"  type="text">
                          </td>
                      </tr>
                      <tr> <td><input name="btnSearch" value="试算" id="btnSearch" class="airport_but" type="submit"></td></tr>
                    </tbody>
                  </table>
                  </td>
              </tr>
            </tbody>
          </table>
          <s:if test="#request.listAction != null && #request.listAction.size() != 0">
          <table width="100%" cellspacing="1" cellpadding="5" border="0" bgcolor="#e5e5e5" style="margin-top:20px;">
            <tbody>
              <tr>
                <td width="15%" bgcolor="39bdf1" align="center" style="color:#FFF; font-weight:bold;">港口英文名 </td>
                <td width="15%" bgcolor="#39bdf1" align="center" style="color:#FFF; font-weight:bold;">港口中文名 </td>
              </tr>
               <s:iterator var="bean" value="#request.listAction">
              <tr>
                <td bgcolor="#FFFFFF" align="center"> <s:property value="#bean.ppt_ename"></s:property> </td>
                <td bgcolor="#FFFFFF" align="center"><s:property value="#bean.ppt_cname"></s:property> </td>
              </tr>
                  </s:iterator>
            </tbody>
          </table>
          <div class="pagelist">
          <ul>
             <li><p:pager url="gangkouQueryTool" />
	 <s:set var="Page" value="#request.objPageConfig"></s:set></li>
          </ul>
        </div>
          </s:if>
          <s:elseif test="#request.districtList!=null && #request.districtList.size()==0"><font color="red" size="2">查询无结果</font></s:elseif>
        </div>
      </div>-->
      
    </div>      
    </s:if>   
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
    <div class="bottom_nav"> <a href="#">首页</a>│<a href="#">货物追踪</a>│<a href="#">提货服务</a>│<a href="#">新闻资讯</a>│<a href="#">成为供应商</a> | <a href="#">新闻中心</a> | <a href="#">联系我们</a></div>
  </div>


</body>
</html>
