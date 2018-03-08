<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>订单导入信息</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	 	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.4.2.js"></script>
  </head>
 <script type="text/javascript">
 	
	function getFile() {
		var fileName = document.getElementById("fileid").value;
		fileName = fileName.replace(/\\\\/g, "\\");
		document.getElementById("fileName").innerHTML = fileName;
	}

	$("#fileName").text();
	function doOMH(spanId, question, id, method) {
		$.ajax({
			url : 'OMH',
			type : 'post',
			data : {
				error : question,
				id : id,
				method : method
			},
			async : false,
			cache : false,
			timeout : 60000,
			success : function(message) {
				//alert(message);
				document.getElementById(spanId).innerHTML = message;
			}
		});
	}

	//打开excel表格
	var idTmr = "";
	function Cleanup() {
		window.clearInterval(idTmr);
		CollectGarbage();
	}
	function openExcel(url) {

		var oExcel;
		var oWorkbook;
		var strAllName;
		try{
			oExcel = new ActiveXObject("Excel.Application");
		}catch(e){
			alert("无法创建服务，检查浏览器是否启用ActiveX控件");
			return;
		}
		oExcel.DisplayAlerts = false;
		oExcel.Visible = true;
		oExcel.Workbooks.Open(url);
		idTmr = window.setInterval("Cleanup();", 1000);
	}
       
 </script>
  <body>
  <form action="" method="post" name="myForm">
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
        <h3>我的代运  > 我的订单 > <span>批量上传</span></h3>
        </div>
    	  <div class="balance">
	  	<div class="r_title">订单导入状态</div>
	  		 <div class="nir2">
		<% String path22=(String)session.getAttribute("strPath");%>
	<input type="hidden" value="<%=path22%>" name="" id="fileid"/>
 <s:if test="#request.errorSize!=\"0\"">  
 <p><font color="red"><b>总共有<s:property value="#request.totalSize"/>条数据，已成功导入订单<s:property value="#request.normalSize"/>条，合并订单<s:property value="#request.megreSize"/>条，失败订单<s:property value="#request.errorSize"/>条。</b></font></p>
  	<br/>	
  </s:if>
  <s:else>
  <p><font color="red"><b>总共有<s:property value="#request.totalSize"/>条数据，全部上传成功。成功导入订单<s:property value="#request.normalSize"/>条，合并订单<s:property value="#request.megreSize"/>条。</b></font></p>
  <br/>	
  </s:else>
  <p >查看原订单:<a href="javascript:openExcel('<%=path22%>');"><%=path22%></a></p>
  <br/>	
  <p><font color="blue">若无法查看订单，请将Internet选择安全级别中的“未标记为可安全执行脚本的ActiveX控件”设为：提示</font></p>
    </div>
    </div>
 	
	<button class="pro_button" type="button" onclick="javascript:history.back(-1)" style="margin-left:10px;">返回</button>
	<br/>	<br/>			

  <div style="width: 860px;margin-top:5px;OVERFLOW-y:auto; OVERFLOW-x: auto; " >
  <div style=" WIDTH: 1400px; HEIGHT: 350px;">
 
   <s:iterator var="predict" value="#request.map" status="index">
  <%String strColor = ""; %>
  <s:if test="'系统已经存在相同的订单号并且已经打印了Label'.equals(key)">  
   <%strColor="#915794";%>
  </s:if>
  <s:if test="'系统已经存在相同的订单号并且为制单暂存状态'.equals(key) || '无法通过基本效验'.equals(key)">
  <s:set var="strcolor" value="red"/><%strColor="red"; %>
  </s:if> 
  <s:if test="'系统已经存在相同的订单号并且我司已确认收货，系统不会将这部分订单重新上传'.equals(key) || '系统已经存在相同的订单号而且发件人名和发件人公司也重复，系统中的订单为制单暂存状态'.equals(key) || '系统中已经存在相同的收件人且状态为暂存状态'.equals(key)">
  <s:set var="strcolor" value="blue"/><%strColor="blue"; %>
  </s:if>
  <p><font color="<%=strColor %>"><b><s:property value="key"/>&nbsp;总数：<s:property value="#predict.value.size"/></b></font></p>

   <div class="result">
 <table style="border-color: black;border-collapse: collapse;table-layout:fixed;word-wrap:break-word;"  id="attributeval"   border="1" cellpadding="0">
	<tr align="center" style="background:#edf8fd;" height="30px">
    <td width="100">订单号码</td>
    <td width="100">操作</td>
    <td width="120">详细信息</td>
    <td width="100">物流渠道</td>
    <td width="100">寄达国家</td>
    <td width="100">收件人名</td>
    <td width="450">收件人地址</td>
    <td width="230">货物名称</td>
    <td width="100">货物件数</td>

  </tr>
 
  <s:iterator value="#predict.value">
  <tr align="center" height="30px" >
    <td align="center"><s:property value="Waybillforpredict.Cwcw_customerewbcode"/></td>    
    <td align="center">    
    <s:if test="'OVVRIDE|HOLD'.equals(Opermode)">
    <span id="<s:property value="Waybillforpredict.Cwcw_customerewbcode"/>">
    <a href="javascript:doOMH('<s:property value="Waybillforpredict.Cwcw_customerewbcode"/>','<s:property value="key"/>','<s:property value="Index"/>','ovvride')"><font color="<%=strColor %>">覆盖</font></a>&nbsp;&nbsp;
    <a href="javascript:doOMH('<s:property value="Waybillforpredict.Cwcw_customerewbcode"/>','<s:property value="key"/>','<s:property value="Index"/>','hold')"><font color="<%=strColor %>">扣件</font></a>
    </span>
    </s:if>
    <s:if test="'SAVE|MERGE'.equals(Opermode)">
    <span id="<s:property value="Waybillforpredict.Cwcw_customerewbcode"/>">
    <a href="javascript:doOMH('<s:property value="Waybillforpredict.Cwcw_customerewbcode"/>','<s:property value="key"/>','<s:property value="Index"/>','save')"><font color="<%=strColor %>">暂存</font></a>&nbsp;&nbsp;
    <a href="javascript:doOMH('<s:property value="Waybillforpredict.Cwcw_customerewbcode"/>','<s:property value="key"/>','<s:property value="Index"/>','merge')"><font color="<%=strColor %>">合并</font></a>
    </span>
    </s:if>
    <s:if test="'OVVRIDE|MERGE'.equals(Opermode)">
    <span id="<s:property value="Waybillforpredict.Cwcw_customerewbcode"/>">
    <a href="javascript:doOMH('<s:property value="Waybillforpredict.Cwcw_customerewbcode"/>','<s:property value="key"/>','<s:property value="Index"/>','ovvride')"><font color="<%=strColor %>">覆盖</font></a>&nbsp;&nbsp;
    <a href="javascript:doOMH('<s:property value="Waybillforpredict.Cwcw_customerewbcode"/>','<s:property value="key"/>','<s:property value="Index"/>','merge')"><font color="<%=strColor %>">合并</font></a>
    </span>
    </s:if>    
    </td>
    
    <td><s:property value="Promptinfo"/></td>
    <td><s:if test="Waybillforpredict.Pkpk_ename !=null && !''.equals(Waybillforpredict.Pkpk_ename)">  
    <s:property value="Waybillforpredict.Pkpk_ename"/></s:if>
    <s:else> <s:property value="Waybillforpredict.Pkpk_code"/></s:else>
    </td>
    <td><s:if test="Waybillforpredict.Dtdt_ename !=null && !''.equals(Waybillforpredict.Dtdt_ename)">  
    <s:property value="Waybillforpredict.Dtdt_ename"/></s:if>
    <s:else> <s:property value="Waybillforpredict.Cwdt_code_signin"/></s:else>
    </td>
    <td><s:property value="Waybillforpredict.Hwhw_consigneename"/></td>
    <td><s:property value="Waybillforpredict.Hwhw_consigneeaddress1"/>&nbsp;<s:property value="Waybillforpredict.Hwhw_consigneeaddress2"/>&nbsp;<s:property value="Waybillforpredict.Hwhw_consigneeaddress3"/></td>
    
    <!--从map的value PredictOrderColumnsEX中取出 ListCargoInfo-->
    	<td><s:iterator var="list" value="ListCargoInfo">
				<s:property value="#list.Ciciename"/>&nbsp;
		</s:iterator></td>
		
    	<td><s:iterator var="list" value="ListCargoInfo">
			<s:property value="#list.Cicipieces"/>&nbsp;
		</s:iterator></td>  
  </tr>
  </s:iterator>
</table>
</div>
<br/>
<br/><br/>
<br/>
</s:iterator>
</div>
  <br/>
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
</body>
</html>
