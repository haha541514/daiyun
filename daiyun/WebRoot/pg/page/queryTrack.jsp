<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="kyle.common.util.jlang.*"%>
<%@page import="kyle.leis.eo.finance.dunning.dax.FinanceReportResults"%>
<%@page import="kyle.leis.eo.finance.dunning.da.FinancestatisticsColumns"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib uri = "/project" prefix="p" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/Calendar.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/IndexTrackQuery_total.css"/>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/IndexTrackQuery.css"/>
 	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.4.2.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/component/Ext3/js/ext-base.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/component/Ext3/js/ext-all.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/component/My97DatePicker/WdatePicker.js"></script>
	<script language="javascript"  src="${pageContext.request.contextPath}/js/index.js"></script>
	<script language="javascript"  src="${pageContext.request.contextPath}/js/Menus.js"></script>
<title>轨迹查询</title>
 
<style type="text/css">
.td1 {
	text-align: center;
	font-size: "30px";
	font-family: "宋体";
	height:30px;
	width:200px;
}
.td2 {
	font-size: "30px";
	height:30px;
	font-family: "宋体";
	text-align: center;
	width:200px;
}

.tab4 {
	BORDER-RIGHT: #ffffff 1px solid;
	BACKGROUND-POSITION: 0px 0px;
	COLOR: #000000;
	LINE-HEIGHT: 27px;
	BACKGROUND-REPEAT: repeat-x;
	HEIGHT: 27px;
	TEXT-ALIGN: center
}		
		
.tab66 {
	text-align: center;
	BACKGROUND-IMAGE: url(images/g12_1.gif);
	line-height: 25px;
	height: 30px;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #FFFFFF;
	/*文本长度限制*/
	text-overflow: ellipsis;
	-o-text-overflow: ellipsis;
	/*自动换行*/
	word-break: break-all;
	
}		
		
<!--
#demo {
background: #FFF;
overflow:hidden;
width: 885px;
}
#demo img {
border: 3px solid #F2F2F2;
}
#indemo {
float: left;
width: 800%;
}
#demo1 {
float: left;
}
#demo2 {
float: left;
}
-->
</style>
<script language="javascript">
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

	function doFold(chImg,chSupList){
		if(document.getElementById(chImg).className == "clsLeftImg"){
			document.getElementById(chImg).className = "chClsLeftImg";
			document.getElementById(chSupList).style.display = 'none';
		}else{
			document.getElementById(chImg).className = "clsLeftImg";
			document.getElementById(chSupList).style.display = 'block';
		}
	}
	//是否为空验证(true为空,false不为空)
	function checkNull(check_var) {
		if (check_var == null || check_var.length == 0 ||check_var == "Track up to 10 numbers at a time. Separate with a comma (,) or return (enter).")
			return true;
		else
			return false;
	}
	//文本域焦点事件


	function doTestArea(obj) {
		if (obj.value == "Track up to 10 numbers at a time. Separate with a comma (,) or return (enter).") {
			obj.value = "";
			obj.focus();
		}
	}
	
	function doblur(obj) {
		if (obj.value == null || obj.value == "") {
			obj.value = "Track up to 10 numbers at a time. Separate with a comma (,) or return (enter).";
		}
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


</script>

</head>
<body>
<form name="trackForm" id="trackForm" action="queryTrack" method="post">
<div id="main">
  <div id="top">
    <div class="top">
      <div class="logo">
        <div class="left"><img src="${pageContext.request.contextPath}/images/logo.jpg" /></div>
        <div class="right"><img src="${pageContext.request.contextPath}/images/tel.jpg" /></div>
      </div>
     <div class="nav">
  		<jsp:include page="../include/main_menu.jsp"></jsp:include>
        <div class="nav_last"></div>
      </div>
    </div>
  </div>
	 
    <div class="forwarding">
     	  <div class="home">
        <h3><a href="#">我的代运</a> > <span>轨迹追踪</span></h3>
      </div>
      <div class="tracing">
        <div class="search">
          <textarea name="queryCode" id="queryCode"  onfocus="if(value==defaultValue){value='';this.style.color='#666'}" onblur="if(!value){value=defaultValue;this.style.color='#666'}" style="color: rgb(153, 153, 153);">请在此输入您的订单号/代理单号/跟踪号，最多支持五个订单号的查询。输入多个订单号，请用“,”分隔 。</textarea>
          <div class="line_button">
            <button class="buttonbg" value="" type="button" onclick="return checkTrackForm();">查询</button>
            <button class="buttonbg" value="" type="reset"  >重置</button>
          </div>
        </div>
				<s:iterator var="WATColumns" value="#request.listWATColumns" status="index" >
					<table width="108%" border="0" cellpadding="0" cellspacing="0" style="table-layout:fixed;">
						<tr>
							<td>
								<table width="108%" cellpadding="0" cellspacing="0" style="table-layout:fixed;" >
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
											<input id='btn<s:property value="#index.index"/>' type="button"  style="width:48px;height:25px;border: none;background: url(${pageContext.request.contextPath}/images/show.png);" />
										</td>
									</tr>
								</table>
							</td>
						</tr>	
						<tr id='div<s:property value="#index.index"/>' style="display:none;" >
							<td>
								<table width="108%" cellpadding="0" cellspacing="0">
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
<div id="light" class="white_content"></div> 
</form>
</body>
</html>