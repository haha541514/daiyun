<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@taglib uri = "/project" prefix="p" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>运费测算</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/Calendar.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/Forwarding_total.css"/>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/Forwarding_page.css"/>
 	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.4.2.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/component/Ext3/js/ext-base.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/component/Ext3/js/ext-all.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/component/My97DatePicker/WdatePicker.js"></script>
	<script language="javascript"  src="${pageContext.request.contextPath}/js/index.js"></script>
	<script language="javascript"  src="${pageContext.request.contextPath}/js/Menus.js"></script>
  </head>
	<style>
#CountryTitie{background-color:#ebebeb;height:30px; text-align: center;}
#CountryTitie a{width:18px;display:block;line-height:30px;text-align:center;float:left;font-family:Arial, Helvetica, sans-serif;}
#CountryTitie a:hover{background-color:#d2d2d2;}

#CountryListSorting td:hover{background-color:#ebebeb;}
#CountryListSorting td .ywm{color:#858585;font-family:Arial, Helvetica, sans-serif;}
#CountryListSorting td .ezdm{color:#5c5c5c;font-weight:bold;font-family:Arial, Helvetica, sans-serif;}

#CountryListSelect  td:hover{background-color:#ebebeb;}

</style>
		<script type="text/javascript">
		function changeHubcode(){
			var countryCode = document.getElementById("countryCode"). value;
			document.getElementById("hubcode").value = countryCode;
		}
		function insertTr(count){
			var a="${listPieces[i].cpcplength}";
			var tab="<div class='r_title' id='r_title'>货件信息</div>"+
			"<table width='860' id='tablecode'>"+
				"<thead><tr style='background:#edf8fd;'>"+
						"<td width='10%'>序号</td>"+
						"<td width='15%'>重量(kg)</td>"+
						"<td width='15%'>长度(cm)</td>"+
						"<td width='15%'>宽度(cm)</td>"+
						"<td width='15%'>高度(cm)</td>"+
						"<td '>操作</td></tr></thead>";
				
			var txt1="";
			for(var i=0;i<count;i++){			 
				txt1=txt1+"<tr>"+
				"<td align='center'>"+(i+1)+"</td>"+
				"<td align='center'><input  type='text' onkeyup='clearNoNum(this)' style='border:0px;width:170px;text-align:center;' name='"+"weight"+(i+1)+"'></td>"+
				"<td align='center'><input  type='text' onkeyup='clearNoNum(this)' style='border:0px;width:170px;text-align:center;' name='"+"length"+(i+1)+"'></td>"+
				"<td align='center'><input  type='text' onkeyup='clearNoNum(this)' style='border:0px;width:170px;text-align:center;' name='"+"width"+(i+1)+"'></td>"+
				"<td align='center'><input  type='text' onkeyup='clearNoNum(this)' style='border:0px;width:170px;text-align:center;' name='"+"height"+(i+1)+"'></td>"+
				"<td align='center'><input  type='button' onclick='deleteTr(this);' value='删除'; style='background:#edf8fd;width:30px;'></td>"+
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
				document.getElementById("myform").action="${pageContext.request.contextPath}/costBudget";
				document.getElementById("myform").submit();
			}
		}
		//刷新
		function doReset(){
			document.getElementById("myform").action="${pageContext.request.contextPath}/costBudget?op=budget";
			document.getElementById("myform").submit();
		}
		function changeCountry(){
			var Dtdt_hubcode = document.getElementById("hubcode").value;
			document.getElementById("countryCode").value = Dtdt_hubcode.toUpperCase();
			changeHubcode();
		}
	</script>
	<script type="text/javascript">
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
		str+="<a onclick='changeContent(this);'>"+list[i]+"</a>";
	}	
	selectCity("A");	
	CT.innerHTML=str;		
	CL.style.top=getElementOffset(obj).top+19;
	CL.style.left=getElementOffset(obj).left;//obj.offsetLeft;
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
//选定国家赋值


function Assignment(obj){
	var str=obj.innerText;
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
	document.getElementById("hubcode").value=str2;
	document.getElementById("CountryList").style.display="none";
	document.getElementById("CountryListSelect").style.display="none";		
}

</script>
 
<body>
<form action="" method="post" name="myform" id="myform">
	<input type="hidden" value="bg" name="op" />
<div id="main">
  <div id="top">
    <div class="top">
      <div class="window">
        <div class="left">亲，<span><%=session.getAttribute("Opname")%></span> 您好！欢迎登录我的代运！</div>
        <div class="right"><span><a href="${pageContext.request.contextPath}/order/loginout">退出</a></span> | <span><a href="${pageContext.request.contextPath}/op/recharge.jsp" target="_blank">充值</a></span> | <span><a href="#">English</a></span></div>
      </div>
      <div class="logo">
        <div class="left"><img src="images/logo.jpg" /></div>
        <div class="right"><img src="images/tel.jpg" /></div>
      </div>
     <div class="nav">
  	<jsp:include page="../pg/include/main_menu.jsp"></jsp:include>
        <div class="nav_last"></div>
      </div>
    </div>
  </div>
 
   <div class="forwarding">
	  <jsp:include page="../op/tree.jsp" />
    <div class="right">
     	<div class="home">
        <h3>我的代运  > 订单辅助 > <span>运费测算</span></h3>
        </div>
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
             <td style="padding-left:33px;">货物类型： 
				<input  name="Ctctcode" id="Ctctcode1" value="AWPX" checked="checked" type="radio">
                <label for="Ctctcode1" style="padding-right:30px;">包裹</label>
                <input  name="Ctctcode" id="Ctctcode2" value="ADOX" type="radio" />
                <label for="Ctctcode2">文件</label>
                 
			  </td>
          			  </tr>
            <tr>
               <td>目的国家：


               
               <s:if test='#request.dthubcode==null||#request.dthubcode==""'>
									<input  type="text" onClick="setLeft(this);" style="width:100px;text-transform:uppercase;margin-right:33px"" id="destination_2"  name="destination_2"/>										
									<input type="hidden" name="Dtdt_hubcode" id="countryCode" value=""/>
							</s:if>
							<s:else>
									<s:iterator var="country" value="@com.daiyun.dax.CountryDemand@queryAllCountry()">
									<s:if test="#request.dthubcode.equals(#country.Dtdt_hubcode)">
										<input type="text" onClick="setLeft(this);" style="width:100px;text-transform:uppercase;margin-right:33px"" id="destination_2"  name="destination_2" value="<s:property value="#country.Dtdt_name"/>"/>	
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
								二字代码：<input type="text" id="hubcode" onClick="setLeft(this);" name="Dtdt_hubcode" style="width:100px;text-transform:uppercase" value="<s:property value='#request.dthubcode'/>"/>
								<font color="red">*</font><br/>
        					
        				</td>
              <td style="padding-left:33px;">起运城市：


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
                付费方式： <select style="width:100px;height:26px;" name="Pmpmcode" id="Pmpmcode">
						<option value="APP" selected="selected">预付</option>
						<option value="ACC" >到付</option>
						<option value="AFR" >免费</option>
					</select>  
					</td>
            </tr>
            <tr>
              <td><span style="padding-right:30px;">货物重量：


                <input id="Grossweight" name="Grossweight" type="text"  onkeyup="clearNoNum(this)" style="width:100px;height:26px;margin-right:10px" value="<s:property value='#request.Grossweight'/>" />KG
                 </span> 件数：


                <input type="text" id="num"   name="num" onkeyup="clearNoNum(this)" value="<s:property value='#request.num'/>" style="width:100px;height:26px;margin-right:5px"/></td>
              <td style="padding-left:33px;">收货网点：<span style="padding-left:8px; color:#d42c96;">根据所填写的发货城市自动计算</span></td>
            </tr>
          </table>
        </div>
            </div>
     <div class="goods" id="goods">
        <div class="r_title" id="r_title">货件信息</div>
        <table width="860" id="tablecode">
          <tr style="background:#edf8fd;">
            <td width="10%">序号</td>
            <td width="15%">重量(kg)</td>
            <td width="15%">长度(cm)</td>
            <td width="15%">宽度(cm)</td>
            <td width="15%">高度(cm)</td>
            <td >操作</td>
          </tr>  
          <s:if test="#request.listPieces != null">
          	<s:iterator var="beans" value="#request.listPieces" status="status">
          	<tr>
			<td align='center'><s:property value="#status.count"/></td>
				<td align="center"><input  type="text" onkeyup="clearNoNum(this)" onchange="changeWeitht(this)" style="border:0px;width:170px;text-align:center;" name="weight<s:property value='#status.count'/>" value="<s:property value='#beans.Cpcpgrossweight'/>"></td>
				<td align="center"><input  type="text" onkeyup="clearNoNum(this)" style="border:0px;width:170px;text-align:center;" name="length<s:property value='#status.count'/>" value="<s:property value='#beans.cpCplength'/>"></td>
				<td align="center"><input  type="text" onkeyup="clearNoNum(this)" style="border:0px;width:170px;text-align:center;" name="width<s:property value='#status.count'/>" value="<s:property value='#beans.cpCpwidth'/>"></td>
				<td align="center"><input  type="text" onkeyup="clearNoNum(this)" style="border:0px;width:170px;text-align:center;" name="height<s:property value='#status.count'/>" value="<s:property value='#beans.cpCpheight'/>"></td>
				<td align="center"><input  type="button" onclick="deleteTr(this)" value="删除"; style="background:#edf8fd;width:30px;"></td>
			</tr>
			</s:iterator>
          </s:if>
          <s:else>
          <tr>
			<td align='center'>1</td>
				<td align="center"><input  type="text" onkeyup="clearNoNum(this)" style="border:0px;width:170px;text-align:center;" name="weight1" ></td>
				<td align="center"><input  type="text" onkeyup="clearNoNum(this)" style="border:0px;width:170px;text-align:center;" name="length1" ></td>
				<td align="center"><input  type="text" onkeyup="clearNoNum(this)" style="border:0px;width:170px;text-align:center;" name="width1" ></td>
				<td align="center"><input  type="text" onkeyup="clearNoNum(this)" style="border:0px;width:170px;text-align:center;" name="height1" ></td>
				<td align="center"><input  type="button" onclick="deleteTr(this)" value="删除"; style="background:#edf8fd;width:30px;"></td>
			</tr>
			</s:else>
        </table>
      </div>
      <div class="button">
      <button class="buttonbg" value="" type="button" onclick="costBudget();" style="margin:0 10px;font-size:13px;">测算费用</button>
      <button class="buttonbg" value="" type="reset"   style="margin:0 10px;font-size:13px;">刷新</button>
 
      </div>
      <div class="long_result">
        <table id="attributeval" class="manage_form" style="margin: 0px;table-layout:fixed;" cellspacing="1" cellpadding="0" border="0">
          <thead>
            <tr style="background:#edf8fd;">
              <td width="150">产品名称</td>  
              <td width="100">总额</td>
              <td width="100">运费值</td>
              <td width="100">杂费值</td>
              <td width="100">燃油费</td>
              <td width="100">货物重量</td>
              <td width="100">实重</td>
              <td width="100">体积重</td>
              <td width="100">体积重系数</td> 
              <td width="140">是否计体积</td>
              <td width="100">产品介绍</td>
              <td width="140">产品备注</td>
              <td width="100">可追踪</td> 
              <td width="140">参考时效(天)</td>
              <td width="150">可接受特殊货物</td>
              <td width="200">操作</td>
              
            </tr>
          </thead>
         	<tbody>
				<s:if test="#request.bud.equals('bud')">
					<s:if test="#request.objSaleTrialCalculateResult.size()==0">
						<tr>
							<td colspan="16"><font color="red">请准确填写试算条件信息</font></td>
						</tr>
					</s:if>
				</s:if>
				<s:else>					
					<tr>
						<td colspan="16"><font color="red">显示试算费用结果</font></td>
					</tr>
				</s:else>
				<s:iterator var="salebean" value="#request.objSaleTrialCalculateResult">
				<tr>
					
					<td><input name="salebean_Pkcode" type="hidden" value="<s:property value='#salebean.Pkcode'/>"/><s:property value="#salebean.Pkname"/></td>	
					<td ><s:property value="@java.lang.String@format('%.2f',@java.lang.Double@parseDouble(#salebean.Freightvalue)+@java.lang.Double@parseDouble(#salebean.Incidentalvalue)+@java.lang.Double@parseDouble(#salebean.Surchargevalue))"/></td>
					<td ><input name="salebean_Freightvalue" type="hidden" value="<s:property value='#salebean.Freightvalue'/>"/><s:property value="#salebean.Freightvalue"/></td>
					<td ><input name="salebean_Incidentalvalue" type="hidden" value="<s:property value='#salebean.Incidentalvalue'/>"/><s:property value="#salebean.Incidentalvalue"/></td>
					<td ><input name="salebean_Surchargevalue" type="hidden" value="<s:property value='#salebean.Surchargevalue'/>"/><s:property value="#salebean.Surchargevalue"/></td>	
					<td ><input name="salebean_Chargeweight" type="hidden" value="<s:property value='#salebean.Chargeweight'/>"/><s:property value="#salebean.Chargeweight"/></td>
					<td ><input name="salebean_Grossweight" type="hidden" value="<s:property value='#salebean.Grossweight'/>"/><s:property value="#salebean.Grossweight"/></td>
					<td ><input name="salebean_Volumeweight" type="hidden" value="<s:property value='#salebean.Volumeweight'/>"/><s:property value="#salebean.Volumeweight"/></td>
					<td ><input name="salebean_Volumerate" type="hidden" value="<s:property value='#salebean.Volumerate'/>"/><s:property value="#salebean.Volumerate"/></td>			
					<td><s:property value="#salebean.Pkcalcvolumesign"/></td>
					<td><s:property value="#salebean.Pkdescription"/></td>
					<td><s:property value="#salebean.Pkremark"/></td>
					<td><s:property value="#salebean.Pkhastracksign"/></td>
					<td><s:property value="#salebean.Pkdeliveryperiods"/></td>
					<td ><s:property value="@com.daiyun.dax.ProductkindDemand@getCargoKind(#salebean.Pkcode)"/></td>
					<td>
						<a href="javascript:void(0)" onclick="productDetail();"><font color="#0000FF">产品详情</font></a>
						<a href="javascript:void(0)" onclick="qucklyOrder();"><font color="#0000FF">快速下单</font></a>
					</td>
				</tr>				
				</s:iterator>				
				</tbody>
        </table>     	 
      </div>
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
</div>
<div id="light" class="white_content"></div> 
</form>

<SCRIPT type="text/javascript">
function qucklyOrder(){
	$('#myform').attr('action','${pageContext.request.contextPath}/order/qucklyOrder');
	$('#myform').submit();
}
function productDetail(){
	alert("功能正在完善中");
}
function changeWeitht(obj){
	/*var weightArray;
	var num = $('#num').val();
	var tab = document.getElementById('tablecode');
	for(var index = 0; index < num ;index++){
		//var weight = tab.rows[index+1].cells[2].innerHTML;
		var weight = obj.innerHTML;
		weightArray += weight;
	}
	$('#Grossweight').val(weightArray);*/
}

</SCRIPT>
</body>
</html>
