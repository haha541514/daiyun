<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page import="com.opensymphony.xwork2.ActionContext" %>
<%@ page import="com.daiyun.dax.WebDemand" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@taglib uri = "/project" prefix="p" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String Opname = (String)session.getAttribute("Opname");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <base href="<%=basePath%>"/>
    
 <link rel="stylesheet" type="text/css" href="<%=path%>/style/index.css"/>
<link rel="stylesheet" type="text/css" href="<%=path%>/style/total.css"/>

<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/banner.js"></script>
<title>代运物流网站</title>

	<meta http-equiv="pragma" content="no-cache"/>
	<meta http-equiv="cache-control" content="no-cache"/>
	<meta http-equiv="expires" content="0"/>    
	<meta http-equiv="keywords" content="HTML,daiyun"/>
	<meta http-equiv="description" content="This is my page"/>
	<meta http-equiv="author" content="wukq"/>
	<meta name=”renderer” content=”webkit|ie-comp|ie-stand” />
  <script type="text/javascript">
  //轨迹查询验证
function checkTrackForm() {
	var queryCode = document.getElementById("queryCode").value;
	if (checkNull(queryCode)) {
		alert("运单号不为能空，请输入运单号!");
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
	function setTab(name,cursel,n){
			for(i=1;i<=n;i++){
			var menu=document.getElementById(name+i);/* zzjs1 */
			var con=document.getElementById("con_"+name+"_"+i);/* con_zzjs_1 */
			menu.className=i==cursel?"hover":"";/*三目运算 等号优先*/
			con.style.display=i==cursel?"block":"none";
			}
		}
  //查价
		function indexCostBudget(){
		
			document.getElementById("costBudgetForm").action="${pageContext.request.contextPath}/util/indexCostBudget";
			document.getElementById("costBudgetForm").submit();
		
	}
	
	function noThing(){
	alert("功能完善中");
	}
	
	function setweight(){
	$("#weight1").val("");
	}
	function checkweight(){
	if($("#weight1").val()==""){
	 $("#weight1").val("请输入计费重(kg)");
	 }
	}
	function cleard2(){
	$("#destination_2").val("");
	}
$(function(){

	var strName = '<%=Opname%>';
	if(strName == ''|| strName == 'null'){
		$('#userlogin').show();
		
	}else{
		$('#logined').show();
	
	}

	$('#user_login').click(function(){
		//登录中



		$('#user_login').css('backgroundImage','url(${pageContext.request.contextPath}/images/login_buttoning.png)');
    		var username = $('#u_name').val();
    		var password = $('#u_pssword').val();
    		if(username.length == 0 || password.length == 0){
    		if(username.length == 0){
    			alert('用户名为空');
    		}else if(password.length == 0){
    			alert('密码为空');
    		}
    	}else{
    	$.ajax({
			url: 'indexlogin',
			timeout : 30000,
			data: $('#myform').serialize(),
			type: 'post',
			success: function(msg){
				if(msg == '1'){
					location.href = 'userinfo';
				}else if(msg == 'nouser'){
						alert('无效的用户名');
						changeLoginImage();	
				}else if(msg == 'errorPassword'){
						alert('用户名或者密码错误');
						changeLoginImage();	
				}else if(msg == 'invalidFunciton'){
						alert('无效的用户职能');	
						changeLoginImage();	
    			}else if(msg == 'checking'){
						alert('登录失败，我司正在审核');
						changeLoginImage();	
    			}
				
			},complete : function(XMLHttpRequest,status){ //请求完成后最终执行参数



　　　				if(status=='timeout'){
 　　　　　				ajaxTimeoutTest.abort();
　　　　　				alert('超时');
　　　　				}
　			},error : function(XMLHttpRequest, textStatus, errorThrown) {
					console.log(XMLHttpRequest.responseText);
					console.log(XMLHttpRequest.status);
					console.log(XMLHttpRequest.readyState);
					console.log(textStatus);
				}
			
			});	
		}
	});		
	
	$('body').keydown(function(e) {
             if (e.keyCode == '13') {//keyCode=13是回车键
             	//$("#sub").click();
             	//settimeout(function(){},1500);
             	setTimeout($('#user_login').click(),1500);//这是延迟时间
             	
             }
         });
         
   $('#destination_2').on('blur',function(){
   		var destination_value = $('#destination_2').val();
   		if(destination_value ==''){
   			 $('#CountryList').hide();
   			 $('#CountryListSelect').hide();
   			 $('#destination_2').val('请输入目的国家名');
   			 
   		}
   
   })      
	
});	

	var changeLoginImage = function(){//重置登录状态



		
		$('#user_login').css('backgroundImage','url(${pageContext.request.contextPath}/images/login_button.png)');
		$('#u_name').val('');
		$('#u_pssword').val('');
	}

</script>
<style type="text/css">
#CountryTitie{background-color:#ebebeb;height:30px; text-align: center;}
#CountryTitie a{width:18px;display:block;line-height:30px;text-align:center;float:left;font-family:Arial, Helvetica, sans-serif;}
#CountryTitie a:hover{background-color:#d2d2d2;}
#CountryListSorting td:hover{background-color:#ebebeb;}
#CountryListSorting td .ywm{color:#858585;font-family:Arial, Helvetica, sans-serif;}
#CountryListSorting td .ezdm{color:#5c5c5c;font-weight:bold;font-family:Arial, Helvetica, sans-serif;}
#CountryListSelect  td:hover{background-color:#ebebeb;}
</style>
  </head>

  <body onload="changeTopmenu(0,0)">
 	
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
  	<jsp:include page="pg/include/main_menu.jsp"></jsp:include>
        <div class="nav_last"><a href="${pageContext.request.contextPath }/userinfo"><img src="${pageContext.request.contextPath }/images/my_nav.jpg"/></a></div>
      </div>
    </div>
    <div class="banner_bg">
      <div class="banner">
        <ul class="nav_img">
          <li><a href=""><img src="images/banner.jpg" alt=""/></a></li>
          <li><a href=""><img src="images/banner.jpg" alt=""/></a></li>
          <li><a href=""><img src="images/banner.jpg" alt=""/></a></li>
        </ul>
        <ul class="nav_banner">
          <li ><a title="" href=""></a></li>
          <li><a title="" href=""></a></li>
          <li><a title="" href=""></a></li>
        </ul>
      </div>
    </div>
  </div>
  <div id="center">
  <form id="myform" method="post">
    <div class="userbg" style="display: none;" id="userlogin" >
      <div class="user">
        <div class="left">用户名

          <input name="u_name"  id="u_name" type="text" size="" />
          密码
          <input name="u_pssword" id="u_pssword" type="password" size="" />
        </div>
       	<div class="right"><span class="anniu">
          <button class="user_login" type="button" id="user_login"></button>
          </span><span><a href="${pageContext.request.contextPath}/register.jsp">立即注册</a> | <a href="${pageContext.request.contextPath }/sf/UpdatePass.jsp">忘记密码？</a></span>
         </div>
      </div>
    </div>
    
      <div class="userbg" style="display: none;" id="logined" >
      <div class="user">
        <div class="left">
        	 亲，<font color="#3AC0F5"><%=Opname%></font>,您已登录
        </div>
        <div class="right"><span class="anniu">
          </span><span><a href="${pageContext.request.contextPath}/loginout">注销</a></span></div>
      </div>
      
    </div>
 </form>   
    <div class="center">
      <div class="left"> 
        <div id="tab">
          <div class="tabList">
            <ul>
              <li class="hover" id="product1" onmousemove="setTab('product',1,3)" ><a href="" target="_blank">国际快递</a></li>
              <!-- <li id="product2" onmousemove="setTab('product',2,3)"><a href="" target="_blank">国际小包</a></li>
              <li id="product3" onmousemove="setTab('product',3,3)" style="margin:0;"><a href="" target="_blank">国际专线机</a></li> -->
            </ul>
          </div>
          <form action="" method="post" name="costBudgetForm" id="costBudgetForm" >
          <input type="hidden" value="bg" name="op" />
          <input type="hidden" value="AWPX"  name="Ctctcode" />
          <div class="tabCon">
            <div class="product_list" id="con_product_1">
              <div class="cur">
                <ul>
                  <li class="lia">
                    <input type="text" value="深圳市[Shenzhen]"  readonly="readonly"  class="input_1" name="form" id="CodeBox1"/>
                    <input type="hidden" name="OrginDtcode" value="719"/>
                  </li>
                  <li class="lia">
           <!--<input type="text"  value="请输入目的国家"  class="input_1" name="to" id="CodeBox2"/> --> 
                    <input class="input_1" type="text"  value="请输入目的国家名"  onclick="setLeft(this);"  id="destination_2" />
		            <input type="hidden" name="countryCode" id="countryCode" value=""/>
		            <input type="hidden" name="Dtdt_hubcode" id="Dtdt_hubcode" value=""/>
                  </li>
                  <li class="lia">
                    <input type="text" value="请输入计费重(kg)"  onblur="checkweight()" onclick="setweight()" class="input_2" name="Grossweight" id="weight1" onblur="setPlay();"/>
                    <span class="con_package" id="sppackage"> <em>包裹类型：</em>
                    <input type="radio" class="middle" name="rdoPackageType" value="1"  checked="checked" />
                    <label for="rdoPackageType_1">包裹</label>
                    &nbsp;
                    <input type="radio" class="middle" name="rdoPackageType" value="2" />
                    <label for="rdoPackageType_2">文件</label>
                    </span> </li>
                    
                    <li class="goods">
                    <h3>货物种类：</h3>
                    <span>
                    <input class="middle" name="" type="checkbox" style="margin-right:10px;"/>
                    普货</span> <span>
                    <input class="middle" name="" type="checkbox" style="margin-right:10px;"/>
                    纺织品</span> <span>
                    <input class="middle" name="" type="checkbox" style="margin-right:10px;"/>
                    内置电池</span> <span>
                    <input class="middle" name="" type="checkbox" style="margin-right:10px;"/>
                    配套电池</span> <span>
                    <input class="middle" name="" type="checkbox" style="margin-right:10px;"/>
                    移动电源</span> <span>
                    <input class="middle" name="" type="checkbox" style="margin-right:10px;"/>
                    手机</span> <span>
                    <input class="middle" name="" type="checkbox" style="margin-right:10px;"/>
                    电子烟</span> <span>
                    <input class="middle" name="" type="checkbox" style="margin-right:10px;"/>
                    木箱</span> </li>
                  <li class="bot"> <span class="bot_01"><a href="#">不接货物</a></span> <span class="bot_02"><a href="#">国家禁运品声明</a></span>
                    <button class="order" type="button" onclick="indexCostBudget();"></button>
                  </li>
                </ul>
                
        <div   id="CountryListSelect" style="display:none;float:center;border:1px solid #f1f1f1;z-index: 9999;position:absolute;background-color:#ffffff;top:125px;">
        </div>
        <div   id="CountryListSelect" style="display:none;float:center;border:1px solid #f1f1f1;z-index: 9999;position:absolute;background-color:#ffffff;top:125px;">    	
        </div>
        <div onmouseout="setPlay(event);" onmouseover="clearHideTask();" id="CountryList" style="display:none;float:center;border:1px solid #f1f1f1;width:550px;z-index: 9999;position:absolute;background-color:#ffffff;top:125px;">
        	<s:set var="countryValue" value="@com.daiyun.dax.CountryDemand@queryAllCountry()"/>        				
        	<input id="countryDtdt_hubcode" type="hidden" value="<s:property value='#countryValue.{Dtdt_hubcode}'/>"/>
        	<input id="countryDtdt_name" type="hidden" value="<s:property value='#countryValue.{Dtdt_name}'/>"/>
        	<input id="countryDtdt_ename" type="hidden" value="<s:property value='#countryValue.{Dtdt_ename}'/>"/>
        	
        	<table   id="CountryCityListShow" style="paddging:0px;border-collapse:collapse;cellpadding:0; cellspacing:0" align="center" width="100%">
        		<tr><td id="CountryTitie" ></td></tr>
        		<tr><td id="CountryListSorting"></td></tr>	
        	</table>
	  	</div> 
                
              </div>
            </div>
            <!--  
            <div class="product_list" id="con_product_2">
              <div class="cur">
                <ul>
                  <li class="lia">
                    <input type="text" value="深圳市[Shenzhen]"  readonly="readonly" class="input_1" name="form" id="CodeBox1"/>
                  </li>
                  <li class="lia">
                    <input type="text" value="请输入目的国家"  class="input_1" onclick="setLeft(this);" name="to" id="CodeBox2"/>
                  </li>
                  <li class="lia">
                    <input type="text" value="请输入重量(kg)"    class="input_1" name="weight" id="weight2"/>
                  </li>
                  <li class="goods">
                    <h3>货物种类：</h3>
                    <span>
                    <input class="middle" name="" type="checkbox" style="margin-right:10px;">
                    普货</span> <span>
                    <input class="middle" name="" type="checkbox" style="margin-right:10px;">
                    纺织品</span> <span>
                    <input class="middle" name="" type="checkbox" style="margin-right:10px;">
                    内置电池</span> <span>
                    <input class="middle" name="" type="checkbox" style="margin-right:10px;">
                    配套电池</span> <span>
                    <input class="middle" name="" type="checkbox" style="margin-right:10px;">
                    移动电源</span> <span>
                    <input class="middle" name="" type="checkbox" style="margin-right:10px;">
                    手机</span> <span>
                    <input class="middle" name="" type="checkbox" style="margin-right:10px;">
                    电子烟</span> <span>
                    <input class="middle" name="" type="checkbox" style="margin-right:10px;">
                    木箱</span> </li>
                  <li class="bot"> <span class="bot_01"><a href="#">不接货物</a></span> <span class="bot_02"><a href="#">国家禁运品声明</a></span>
                    <button class="order" type="button" onclick="GotoSerachPage();"></button>
                  </li>
                </ul>
              </div>
            </div>
            -->
            <div class="product_list" id="con_product_3">
              <div class="cur">
                <ul>
                  <li class="lia">
                    <input type="text" value="深圳市[Shenzhen]"  class="input_1" name="form" id="CodeBox1"/>
                  </li>
                  <li class="lia">
                    <input type="text" value="请输入目的国家"  class="input_1" name="to" id="CodeBox2"/>
                  </li>
                  <li class="lia">
                    <input type="text" value="请输入体积重，重量中的最大值"  class="input_1" name="Grossweight" id="CodeBox3"/>
                  </li>
                  <li class="bot"> <span class="bot_01"><a href="#">不接货物</a></span> <span class="bot_02"><a href="#">国家禁运品声明</a></span>
                    <button class="order" type="submit" onclick="GotoSerachPage();"></button>
                  </li>
                </ul>
              </div>
            </div>
          </div>
          </form>
        </div>
         
    
    
	  
	  
        <div class="tool">
          <div class="title">
            <h3>物流工具</h3>
          </div>
          <div class="nir">
            <ul>
              <li><a href="javaScript:void(0)" onclick="noThing();"><img src="images/tool01.png" /><span>下单流程</span></a></li>
              <li><a href="javaScript:void(0)" onclick="noThing();"><img src="images/tool02.png" /><span>送货地址</span></a></li>
              <li><a href="javaScript:void(0)" onclick="noThing();"><img src="images/tool03.png" /><span>代运取货</span></a></li>
              <li><a href="javaScript:void(0)" onclick="noThing();"><img src="images/tool04.png" /><span>模板下载</span></a></li>
              <li><a href="<%=path%>/queryCode?code=1525"s><img src="images/tool_05.png" /><span>运费计算</span></a></li>
              <li><a href="javaScript:void(0)" onclick="noThing();"><img src="images/tool06.png" /><span>帮助中心</span></a></li>
              <li><a href="javaScript:void(0)" onclick="noThing();"><img src="images/tool07.png" /><span>外贸工具</span></a></li>
              <li><a href="javaScript:void(0)" onclick="noThing();"><img src="images/tool08.png" /><span>出口报关资料</span></a></li>
              <li><a href="javaScript:void(0)" onclick="noThing();"><img src="images/tool09.png" /><span>目的国清关资料</span></a></li>
              <li><a href="<%=path%>/queryCode?code=1507"><img src="images/tool_10.png" /><span>机场三字码</span></a></li>
              <li><a href="<%=path%>/queryCode?code=1511"><img src="images/tool_12.png" /><span>港口查询</span></a></li>
              <li><a href="<%=path%>/queryCode?code=1509"><img src="images/tool_11.png" /><span>航空公司查询</span></a></li>
            </ul>
          </div>
        </div>
      </div>
     <script>
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
	var act = document.activeElement.id; 
	if(act=="destination_2"){			
		var CL=document.getElementById("CountryList");
		var obj=document.getElementById("destination_2");	
		CL.style.display="none";			
		selectCityList(obj);		
	}
}

function isNull( str ){
	if ( str == "" ) return true;
	var regu = "^[ ]+$";
	var re = new RegExp(regu);
	return re.test(str);
}

function GetLength(str) {	 
	  var len = str.length,realLength;
	  realLength=len*10;
	  return realLength;
}

function selectCityList(obj){	
	var CS=document.getElementById("CountryListSelect");
	var str=obj.value.toUpperCase();
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

	for(var i=0;i<arrayCH.length;i++){
		if(arrayCN[i].indexOf(str)==0||arrayCE[i].indexOf(str)==0){
			arrayText.push(arrayCN[i]+"("+arrayCH[i]+")"+arrayCE[i]);
		}
	}
	if(arrayText.length==0){
		CS.style.display="none";	
		return;
	}
	var width=60;
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
	CS.style.top=getElementOffset(obj).top+19;
	CS.style.left=getElementOffset(obj).left;
	CS.style.display="block";
}

function decideMouse(ev){
	//var bool=true;
	var bool=false;
	var ev= ev || window.event;	
	var mousePos = mouseCoords(ev);	
	var CT=document.getElementById("CountryCityListShow");
	var pos=getElementOffset(CT);	
	if(mousePos.x>=pos.left&&mousePos.x<=(pos.left+550)&&mousePos.y>=pos.top&&mousePos.y<=(pos.top+pos.height)){		
		//bool=false;
		bool=true;
	}	
	//return bool;
	return bool;
}

function getElementOffset(e)
{
	var t = e.offsetTop;
	var l = e.off;
	var w = e.offsetWidth;
	var h = e.offsetHeight-1;

	while(e=e.offsetParent) {
		t+=e.offsetTop;
		l+=e.offsetLeft;
	}
	return {top : t,left : l,width : w,height : h}
}

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

function setLeft(obj){
	$("#destination_2").val("");	
	clearHideTask();
	var CL=document.getElementById("CountryList");
	var CT=document.getElementById("CountryTitie");
	var list=["A","B","C","D","E","F","G","H","I","J","K","L","M","N","P","Q","R","S","T","U","V","Y","Z"];//O W X
	var str="";	
	for(var i=0;i<list.length;i++){
		str+="<a onclick='changeContent(this);'>"+list[i]+"</a>";
	}	
	selectCity("A");	
	CT.innerHTML=str;		
	CL.style.top=getElementOffset(obj).top+19;
	CL.style.left=getElementOffset(obj).left;//obj.offsetLeft;
	CL.style.display="block";
	//doHideTask();//过2秒自动隐藏
}

var hideTask = null;
function doHideTask(){
	hideTask = setTimeout(function(){hideCountry();}, 2000);
}

function clearHideTask(){
	clearTimeout(hideTask);
}

function changeContent(obj){
	selectCity(obj.innerText || obj.textContent);	
}

function setPlay(ev){
	if(decideMouse(ev)){	
		hideCountry();
	}
}

function hideCountry(){
	var CL=document.getElementById("CountryList");	
	CL.style.display="none";
}

function achieveAllCity(){
	var CS=document.getElementById("SCountryListSorting");
	var CH=document.getElementById("countryDtdt_hubcode").value;
	CH=CH.substring(1,CH.length-1).split(",")
	var CN=document.getElementById("countryDtdt_name").value;
	CN=CN.substring(1,CN.length-1).split(",")
	var CE=document.getElementById("countryDtdt_ename").value;

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
	CE=CE.replace("CHINA, PEOPLES REPUBLIC", "CHINA&#44 PEOPLES REPUBLIC");
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

function selectCity(str){
	var CLS=document.getElementById("CountryListSelect");
	var CS=document.getElementById("CountryListSorting");
	var CH=document.getElementById("countryDtdt_hubcode").value;
	CH=CH.substring(1,CH.length-1).split(",")
	var CN=document.getElementById("countryDtdt_name").value;
	CN=CN.substring(1,CN.length-1).split(",")
	var CE=document.getElementById("countryDtdt_ename").value;
	
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
	CE=CE.replace("CHINA, PEOPLES REPUBLIC", "CHINA&#44 PEOPLES REPUBLIC");
	CE=CE.substring(1,CE.length-1).split(",")
	
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
//
function Assignment(obj){
	var str=obj.innerText || obj.textContent;
	str=str.replace("VIRGIN ISLANDS (US),VIRGIN ISLANDS &#40US&#41");
	str=str.replace("SOMALILAND, REP OF (NORTH SOMALIA),SOMALILAND, REP OF &#40NORTH SOMALIA&#41");	
	str=str.replace("VIRGIN ISLANDS (BRITISH),VIRGIN ISLANDS &#40BRITISH&#41");	
	str=str.replace("IRAN (ISLAMIC REPUBLIC OF),IRAN &#40ISLAMIC REPUBLIC OF&#41");
	str=str.replace("GUYANA (BRITISH),GUYANA &#40BRITISH&#41");	
	var str1,str2;
	str1=str.substring(0,str.lastIndexOf("("));
	str2=str.substring(str.lastIndexOf("(")+1,str.lastIndexOf(")"));	
	document.getElementById("destination_2").value=str1;
	document.getElementById("countryCode").value=str2;
	document.getElementById("Dtdt_hubcode").value=str2;
	document.getElementById("CountryList").style.display="none";
	document.getElementById("CountryListSelect").style.display="none";
	costbudget();	
	
}
</script>                   
      <div class="right">
        <div class="track">
          <div class="title">
            <h3>物流工具</h3>
          </div>
          <div class="nir">
          <form name="queryTrackForm" id="queryTrackFrom" action="page/queryTrack" method="post">
            <div class="search">
              <textarea name="queryCode" id="queryCode" class="input_3" onfocus="if(value==defaultValue){value='';this.style.color='#666'}" onblur="if(!value){value=defaultValue;this.style.color='#666'}" style="color: rgb(153, 153, 153);">请在此输入您的订单号/代理单号/跟踪号，最多支持五个订单号的查询。输入多个订单号，请用“,”分隔 。</textarea>
            </div>
            <div class="check">
              <ul>
                <li>
                  <input name="validateCode" value="验证码" onfocus="if(value==defaultValue){value='';this.style.color='#666'}" onblur="if(!value){value=defaultValue;this.style.color='#666'}"  style="color: rgb(153, 153, 153);" />
                </li>
                <li class="check_letter"><img src="util/ValidateImage?d=<%= new Date().getTime() %>" onClick="changeValidateCode(this)" style="float:left;margin-left:-10px;margin-top:2.5px;width:40px;height:20px"/></li>
                <li>
                  <button class="check_but" type="submit" onclick="return checkTrackForm();"></button>
                </li>
              </ul>
            </div>
            </form>
          </div>
        </div>
        <div class="news">
          <div class="title">
            <h3>通知公告</h3>
          <s:set var="ggnum" value="@com.daiyun.dax.WebDemand@STquery('D0102')"/>
            <s:set var="newnum" value="@com.daiyun.dax.WebDemand@STquery('D0101')"/>
            <!-- <s:set var="newnum" value="@com.daiyun.web.dax.WebDemand@STquery('D0101')"/> -->
            <strong><span><a href='<%=request.getRequestURI()%>item/newCode?code=<s:property value="#newnum"/>'>更多</a></span></strong></div>
          <div class="nir">
          <s:set var ="topnews" value="@com.daiyun.dax.Bulletin@queryByBkcode('001','2')" />
            <div class="new"> <img src="images/index_01.jpg" />
              <h3><a href="item/qyByBlIdTool?gmcode=<s:property value="#ggnum"/>&pf=newsDetails&blId=<s:property value="#topnews[0].Blblid" />"><s:property value="#topnews[0].Blblheading"/></a></h3>
              <p><s:if test="#topnews[0].Blblcontent.getBytes().length>60">
               <s:set var="content1" value="@com.daiyun.util.StrUtil@stripHtml(#topnews[0].Blblcontent)"/>
               <s:set var="content2" value="@com.daiyun.util.StrUtil@splitString(#content1,'200')"/>
              ${content2}...
              </s:if><a href="item/qyByBlIdTool?gmcode=<s:property value="#ggnum"/>&pf=newsDetails&blId=<s:property value="#topnews[0].Blblid" />">[详细]</a></p>
              
            </div>
            <div class="new"> <img src="images/index_02.jpg" />
              <h3><a href="item/qyByBlIdTool?gmcode=<s:property value="#ggnum"/>&pf=newsDetails&blId=<s:property value="#topnews[1].Blblid" />"><s:property value="#topnews[1].Blblheading"/></a></h3>
              <p><s:if test="#topnews[0].Blblcontent.getBytes().length>60">
               <s:set var="content3" value="@com.daiyun.util.StrUtil@stripHtml(#topnews[1].Blblcontent)"/>
               <s:set var="content4" value="@com.daiyun.util.StrUtil@splitString(#content1,'200')"/>
              ${content4}...
              </s:if><a href="item/qyByBlIdTool?gmcode=<s:property value="#ggnum"/>&pf=newsDetails&blId=<s:property value="#topnews[1].Blblid" />">[详细]</a></p>
            </div>
            <ul>
             
              
         
           <s:iterator var="btBean" value="@com.daiyun.dax.BulletinOpr@queryByBkcode('002','5')">                 	
              <li><h3><a href='item/qyByBlIdTool?gmcode=<s:property value="#ggnum"/>&pf=newsDetails&blId=<s:property value="#btBean.Blblid" />'>
	            <s:if test="#btBean.Blblheading.getBytes().length>60">
	             <s:property value="@com.daiyun.util.StrUtil@splitString(#btBean.Blblheading,60)"/>...
              </s:if>
	             <s:else>
	              <s:property value="#btBean.Blblheading"/>
	           </s:else></a></h3><span><s:property value="#btBean.Blblvaliddate.split(' ')[0]"/></span></li>
           </s:iterator>  
            </ul>
          </div>
        </div>
      </div>
    </div>
    <div class="clear"></div>
    <div class="bottom">
      <div class="partner">
        <div class="title">
          <h3>合作伙伴</h3>
          <div class="partner_title"><a class="leftbtuuon" onmousedown="ISL_GoUp()" onmouseup="ISL_StopUp()" onmouseout="ISL_StopUp()"><img src="images/leftbutton.png" alt="合作伙伴" /></a><a class="rightbtuuon" onmousedown="ISL_GoDown()" onmouseup="ISL_StopDown()" onmouseout="ISL_StopDown()"><img src="images/rightbutton.png" alt="合作伙伴" /></a></div>
        </div>
        <div class="Cont" id="ISL_Cont">
          <div class="ScrCont">
            <ul id="List1">
             <li><a target="_blank"  href="http://www.tnt.com.cn/"><img src="images/partner01.jpg" border='0' width='100' height='50' /></a></li>
              <li><a target="_blank"  href="http://www.fedex.com/cn/"><img src="images/partner02.jpg" border='0' width='100' height='50' /></a></li>
              <li><a target="_blank"  href="http://www.aramex.com/"><img src="images/partner03.jpg" border='0' width='100' height='50' /></a></li>
              <li><a target="_blank"  href="http://www.ups.com/"><img src="images/partner04.jpg" border='0' width='100' height='50' /></a></li>
              <li><a target="_blank"  href="http://www.cn.dhl.com/"><img src="images/partner05.jpg" border='0' width='100' height='50' /></a></li>
              <li><a target="_blank"  href="http://www.cathaypacific.com"><img src="images/partner06.jpg" border='0' width='100' height='50' /></a></li>
              <li><a target="_blank"  href="http://www.airchina.com.cn/"><img src="images/partner07.jpg" border='0' width='100' height='50' /></a></li>
              <li><a target="_blank"  href="http://www.csair.com/cn"><img src="images/partner08.jpg" border='0' width='100' height='50' /></a></li>
                </ul>
            <ul id="List2">
            </ul>
          </div>
        </div>
        <div class="clear"></div>
      </div>
      <script language="javascript" type="text/javascript">
<!--//--><![CDATA[//><!--
//图片滚动列表 mengjia 070816
var Speed = 10; //速度(毫秒)
var Space = 5; //每次移动(px)
var PageWidth = 120; //翻页宽度
var fill = 0; //整体移位
var MoveLock = false;
var MoveTimeObj;
var Comp = 0;
var AutoPlayObj = null;
GetObj("List2").innerHTML = GetObj("List1").innerHTML;
GetObj('ISL_Cont').scrollLeft = fill;
GetObj("ISL_Cont").onmouseover = function(){clearInterval(AutoPlayObj);}
GetObj("ISL_Cont").onmouseout = function(){AutoPlay();}
AutoPlay();
function GetObj(objName){if(document.getElementById){return eval('document.getElementById("'+objName+'")')}else{return eval('document.all.'+objName)}}
function AutoPlay(){ //自动滚动
 clearInterval(AutoPlayObj);
 AutoPlayObj = setInterval('ISL_GoDown();ISL_StopDown();',3000); //间隔时间
}
function ISL_GoUp(){ //上翻开始




 if(MoveLock) return;
 clearInterval(AutoPlayObj);
 MoveLock = true;
 MoveTimeObj = setInterval('ISL_ScrUp();',Speed);
}
function ISL_StopUp(){ //上翻停止
 clearInterval(MoveTimeObj);
 if(GetObj('ISL_Cont').scrollLeft % PageWidth - fill != 0){
  Comp = fill - (GetObj('ISL_Cont').scrollLeft % PageWidth);
  CompScr();
 }else{
  MoveLock = false;
 }
 AutoPlay();
}
function ISL_ScrUp(){ //上翻动作
 if(GetObj('ISL_Cont').scrollLeft <= 0){GetObj('ISL_Cont').scrollLeft = GetObj('ISL_Cont').scrollLeft + GetObj('List1').offsetWidth}
 GetObj('ISL_Cont').scrollLeft -= Space ;
}
function ISL_GoDown(){ //下翻
 clearInterval(MoveTimeObj);
 if(MoveLock) return;
 clearInterval(AutoPlayObj);
 MoveLock = true;
 ISL_ScrDown();
 MoveTimeObj = setInterval('ISL_ScrDown()',Speed);
}
function ISL_StopDown(){ //下翻停止
 clearInterval(MoveTimeObj);
 if(GetObj('ISL_Cont').scrollLeft % PageWidth - fill != 0 ){
  Comp = PageWidth - GetObj('ISL_Cont').scrollLeft % PageWidth + fill;
  CompScr();
 }else{
  MoveLock = false;
 }
 AutoPlay();
}
function ISL_ScrDown(){ //下翻动作
 if(GetObj('ISL_Cont').scrollLeft >= GetObj('List1').scrollWidth){GetObj('ISL_Cont').scrollLeft = GetObj('ISL_Cont').scrollLeft - GetObj('List1').scrollWidth;}
 GetObj('ISL_Cont').scrollLeft += Space ;
}
function CompScr(){
 var num;
 if(Comp == 0){MoveLock = false;return;}
 if(Comp < 0){ //上翻
  if(Comp < -Space){
   Comp += Space;
   num = Space;
  }else{
   num = -Comp;
   Comp = 0;
  }
  GetObj('ISL_Cont').scrollLeft -= num;
  setTimeout('CompScr()',Speed);
 }else{ //下翻
  if(Comp > Space){
   Comp -= Space;
   num = Space;
  }else{
   num = Comp;
   Comp = 0;
  }
  GetObj('ISL_Cont').scrollLeft += num;
  setTimeout('CompScr()',Speed);
 }
}
//--><!]]>
</script> 
    </div>
    
  </div>
  <div id="bottom">
    <div class="copyright">
      <div class="nir">
        <div class="left"> Copyright © 2012 深圳市代运物流网络有限公司<br />
          (AT) 2008-2010 All Rights Reserved 粤ICP备0503210号 </div>
        <div class="right"><img src="images/tel2.jpg" /></div>
      </div>
    </div>
    <div class="bottom_nav"> <a href="#">首页</a>│<a href="<%=path%>/track/searchTrack">货物追踪</a>│<a href="#">提货服务</a>│<a href="#">新闻资讯</a>│<a href="#">成为供应商</a> | <a href="#">新闻中心</a> | <a href="#">联系我们</a></div>
  </div>
</div>
<span id="chat_f2"><img  src="images/consult.jpg" style="float:right;cursor:pointer;"></span>
<div id="chat_f1" style="display:block;">
<span id="close_chat"><img  src="images/close.png" style="float: right;margin-top:-7px;cursor:pointer;" > </span>
  <div id="chat_f1_main"></div>
  <div class="chat_f1_expr" style="height: 184px; display: block;"> 
    <!------------>
    <div class="list">
      <div class="name">
        <h5><a href="http://wpa.qq.com/msgrd?v=3&uin=526447239&site=qq&menu=yes" target="_blank">快速咨询</a></h5>
      </div>
    </div>
    <!------------> 
    <!------------>
    <div class="list">
      <div class="name">
        <h5><a  href="http://wpa.qq.com/msgrd?v=3&uin=469440513&site=qq&menu=yes" target="_blank">更多咨询</a></h5>
      </div>
    </div>
    <!------------> 
    <!------------>
    
    <div class="list">
      <div class="name">
        <h5><a href="http://wpa.qq.com/msgrd?v=3&uin=364366761&site=qq&menu=yes"target="_blank">离线留言</a></h5>
      </div>
    </div>
    <!------------> 
  </div>
</div>
</body>
</html>
