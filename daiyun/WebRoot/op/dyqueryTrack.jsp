<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="kyle.common.util.jlang.*"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@page import="kyle.common.util.jlang.DateFormatUtility"%>

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
    
    <title>轨迹追踪</title>
    
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

		<script type="text/javascript">
	 		function doHidden(divId){
		var btn = "btn"+divId;
		var divId = "div"+divId;
		var statu = document.getElementById(divId).style.display;
		if(statu == "none"){
			document.getElementById(divId).style.display = "";			
			document.getElementById(btn).style.backgroundImage="url(${pageContext.request.contextPath}/images/hidden.png)";
			
		}else{
			document.getElementById(divId).style.display = "none";
			document.getElementById(btn).style.backgroundImage="url(${pageContext.request.contextPath}/images/show.png)";
		}	
	}

	//是否为空验证(true为空,false不为空)
	function checkNull(check_var) {
		if (check_var == null || check_var.length == 0 ||check_var == "Track up to 10 numbers at a time. Separate with a comma (,) or return (enter).")
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
		document.trackForm.submit();
	}
 	function onEnterDown(){ 
		if(window.event.keyCode == 13){ 
			checkTrackForm(); 
		}	 
	} 	
		</script>

 
  <body onkeydown='onEnterDown();'>
<form name="trackForm" id="trackForm" action="DyqueryTrack" method="post">
<div id="main">
  <div id="top">
    <div class="top">
      <div class="window">
        <div class="left">亲，<span><%=session.getAttribute("Opname")%></span> 您好！欢迎登录我的代运！</div>
        <div class="right"><span><a href="${pageContext.request.contextPath}/order/loginout">退出</a></span> | <span><a href="${pageContext.request.contextPath}/op/recharge.jsp" target="_blank">充值</a></span>| <span><a href="#">English</a></span></div>
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
        <h3>我的代运  > 订单辅助 > <span>轨迹追踪</span></h3>
      </div>
      <div class="tracing">
        <div class="search">
          <textarea name="queryCode" id="queryCode"  onfocus="if(value==defaultValue){value='';this.style.color='#666'}" onblur="if(!value){value=defaultValue;this.style.color='#666'}" style="color: rgb(153, 153, 153);">请在此输入您的订单号/代理单号/跟踪号，最多支持五个订单号的查询。输入多个订单号，请用“,”分隔 。</textarea>
          <div class="line_button">
            <button class="buttonbg" value="" type="button" onclick="return checkTrackForm();">查询</button>
            <button class="buttonbg" value="" type="reset"  >重置</button>
          </div>
        </div>
        <div class="center_table">
        
					<s:iterator var="WATColumns" value="#request.listWATColumns" status="index">
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<table  width="100%" cellpadding="0" cellspacing="0" style="table-layout:fixed;">
									<tr style="background:#edf8fd;">
										<td class="td1">客户运单号</td>
										<td class="td1">服务商号</td>
										<td class="td1">目的国家</td>
										<td class="td1">最新状态</td>
										<td class="td1">操作</td>
									</tr>
									<tr>
										<td class="td2"><s:property value="#WATColumns.StrCwcustomerewbcode"/></td>
										<td class="td2"><s:property value="#WATColumns.StrCwserverewbcode"/></td>
										<td class="td2"><s:property value="#WATColumns.StrDtcode"/></td>
										<td class="td2"><font color="red"><s:property value="#WATColumns.StrWbtsname"/></font></td>
										<td class="td2" onclick="doHidden(<s:property value="#index.index"/>)">
											<input id='btn<s:property value="#index.index"/>' type="button" style="width:48px;height:25px;border: none;background: url(${pageContext.request.contextPath}/images/show.png);"  />
										</td>
									</tr>
								</table>
							</td>
						</tr>	
						<tr id='div<s:property value="#index.index"/>' style="display:none;">
							<td>
								<table width="100%" cellpadding="0" cellspacing="0" style="table-layout:fixed;">
									<tr style="background:#edf8fd;">
										<td width="116" class="tab4">发生时间</td>
										<td width="129" class="tab4">发生地点</td>
										<td width="226" class="tab4">轨迹描述</td>
										<td width="240" class="tab4">中文描述</td>
									</tr>
									<s:iterator var="WBTColumns" value="#WATColumns.ListWBTColumns">
									<tr>
										<td class="tab66"><s:property value="#WBTColumns.Wbtwbtoccurdate"/></td>
										<td class="tab66"><s:property value="#WBTColumns.Wbtwbtlocation"/></td>
										<td class="tab66">
											<s:property value="#WBTColumns.Wbtswbtsename"/> 
											<!--
											<s:if test="#WBTColumns.Wbtswbtsename != null && #WBTColumns.Wbtswbtsename != \"\" ">
											<s:property value="#WBTColumns.Wbtswbtsename"/> 
											</s:if>
											<s:else>
											<s:property value="#WBTColumns.Wbtwbtdescription"/> 
											</s:else>
											-->
										</td>
										<td class="tab66"><s:property value="#WBTColumns.Wbtswbtsname"/></td>
									</tr>
									</s:iterator>
								</table>
							</td>
						</tr>
					</table>
				</s:iterator>					
			 
         </div>
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
